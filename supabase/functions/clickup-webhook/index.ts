// clickup-webhook
//
// Recibe los eventos que ClickUp manda cuando algo cambia en la lista de
// trabajos: nueva subtarea (el jefe de taller la crea directamente en
// ClickUp), cambio de estado, de asignado, o de un ítem de checklist.
//
// No se intenta leer el diff exacto que manda el payload del webhook -la
// granularidad de eventos de ClickUp para checklists no está garantizada-;
// en vez de eso, ante cualquier evento se vuelve a pedir la tarea completa
// a la API y se reconcilia contra lo que hay en la base. Cuesta una llamada
// extra por evento, pero es mucho más simple y confiable que tratar de
// interpretar cada tipo de evento por separado, y el volumen de Didial
// (~5 vehículos/día) lo hace irrelevante en costo.
//
// Verificación de firma: ClickUp firma cada webhook con HMAC-SHA256 sobre
// el cuerpo crudo, usando el secreto que entrega al crear la suscripción
// (guardado como CLICKUP_WEBHOOK_SECRET). Sin esto, cualquiera que
// adivinara la URL podría inyectar datos falsos en el taller.
import { createClient } from 'jsr:@supabase/supabase-js@2'
import { respuestaJson, respuestaPreflight } from '../_shared/cors.ts'
import { obtenerTarea } from '../_shared/clickup.ts'

async function firmaValida(cuerpoCrudo: string, firmaRecibida: string | null): Promise<boolean> {
  const secreto = Deno.env.get('CLICKUP_WEBHOOK_SECRET')
  if (!secreto || !firmaRecibida) return false

  const claveCripto = await crypto.subtle.importKey(
    'raw',
    new TextEncoder().encode(secreto),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign']
  )
  const firma = await crypto.subtle.sign('HMAC', claveCripto, new TextEncoder().encode(cuerpoCrudo))
  const firmaHex = Array.from(new Uint8Array(firma))
    .map((b) => b.toString(16).padStart(2, '0'))
    .join('')

  return firmaHex === firmaRecibida
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return respuestaPreflight()

  const cuerpoCrudo = await req.text()

  if (!(await firmaValida(cuerpoCrudo, req.headers.get('X-Signature')))) {
    return respuestaJson({ error: { mensaje: 'Firma inválida.' } }, 401)
  }

  const payload = JSON.parse(cuerpoCrudo) as { task_id?: string }
  const taskId = payload.task_id
  if (!taskId) {
    // Eventos que no traen task_id (ej. de listas/carpetas) no aplican aquí.
    return respuestaJson({ data: { ignorado: true } })
  }

  const supabase = createClient(Deno.env.get('SUPABASE_URL')!, Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!)

  async function registrarError(empresaId: string | null, trabajoId: string | null, operacion: string, error: unknown) {
    const mensaje = error instanceof Error ? error.message : String(error)
    if (empresaId) {
      await supabase.from('integraciones_clickup_errores').insert({
        empresa_id: empresaId,
        trabajo_id: trabajoId,
        operacion,
        mensaje,
        detalle: error instanceof Error ? { stack: error.stack } : null,
      })
    }
  }

  try {
    // Caso 1: el evento es sobre una subtarea de mano de obra que ya conocemos.
    const { data: tareaExistente } = await supabase
      .from('tareas_taller')
      .select('id, trabajo_id, tecnico_id, trabajos_taller(empresa_id)')
      .eq('clickup_task_id', taskId)
      .maybeSingle()

    const tareaRemota = (await obtenerTarea(taskId)) as {
      name: string
      status?: { status?: string }
      assignees?: { id: number; email: string }[]
      parent: string | null
      checklists?: { id: string; name: string; items: { id: string; name: string; resolved: boolean; assignee?: { email: string } }[] }[]
    }

    // El asignado se cruza por correo contra nuestros propios usuarios, no
    // contra la lista de miembros de ClickUp: el correo ya viene en el
    // objeto assignee de la tarea, así que no hace falta la llamada extra a
    // obtenerMiembrosEquipo() (esa sirve solo para el sentido CRM -> ClickUp).
    const asignado = tareaRemota.assignees?.[0]
    const usuarioAsignado = asignado
      ? await supabase.from('usuarios').select('id').eq('correo', asignado.email).maybeSingle()
      : null

    if (tareaExistente) {
      const empresaId = (Array.isArray(tareaExistente.trabajos_taller)
        ? tareaExistente.trabajos_taller[0]
        : tareaExistente.trabajos_taller
      )?.empresa_id as string | undefined

      const { error: errorActualizar } = await supabase
        .from('tareas_taller')
        .update({
          descripcion: tareaRemota.name,
          estado: tareaRemota.status?.status ?? 'agenda',
          tecnico_id: usuarioAsignado?.data?.id ?? null,
          clickup_asignado_nombre: usuarioAsignado?.data ? null : asignado?.email ?? null,
        })
        .eq('id', tareaExistente.id)

      if (errorActualizar) {
        await registrarError(empresaId ?? null, tareaExistente.trabajo_id, 'actualizar_tarea_taller', errorActualizar)
        return respuestaJson({ error: { mensaje: errorActualizar.message } }, 500)
      }

      return respuestaJson({ data: { actualizada: 'tarea_taller', id: tareaExistente.id } })
    }

    // Caso 2: es la tarjeta (OT) misma -> reconciliar sus checklists.
    const { data: trabajo } = await supabase
      .from('trabajos_taller')
      .select('id, empresa_id')
      .eq('clickup_task_id', taskId)
      .maybeSingle()

    if (trabajo) {
      await reconciliarChecklists(supabase, trabajo.id, tareaRemota.checklists ?? [])
      return respuestaJson({ data: { reconciliado: 'trabajos_taller', id: trabajo.id } })
    }

    // Caso 3: subtarea nueva, creada directamente en ClickUp por el jefe de
    // taller (spec §7: "el jefe crea trabajo directamente en ClickUp y eso
    // debe llegar al CRM"). Se importa si su padre es una OT conocida.
    if (tareaRemota.parent) {
      const { data: trabajoPadre } = await supabase
        .from('trabajos_taller')
        .select('id, empresa_id')
        .eq('clickup_task_id', tareaRemota.parent)
        .maybeSingle()

      if (trabajoPadre) {
        const { data: nuevaTarea, error: errorInsercion } = await supabase
          .from('tareas_taller')
          .insert({
            trabajo_id: trabajoPadre.id,
            descripcion: tareaRemota.name,
            estado: tareaRemota.status?.status ?? 'agenda',
            clickup_task_id: taskId,
            tecnico_id: usuarioAsignado?.data?.id ?? null,
            clickup_asignado_nombre: usuarioAsignado?.data ? null : asignado?.email ?? null,
          })
          .select('id')
          .single()

        if (errorInsercion) {
          await registrarError(trabajoPadre.empresa_id, trabajoPadre.id, 'importar_tarea_nueva', errorInsercion)
          return respuestaJson({ error: { mensaje: errorInsercion.message } }, 500)
        }

        return respuestaJson({ data: { importada: 'tarea_taller', id: nuevaTarea.id } })
      }
    }

    // No pertenece a ninguna OT que administre este CRM: se ignora.
    return respuestaJson({ data: { ignorado: true } })
  } catch (error) {
    await registrarError(null, null, 'webhook_general', error)
    return respuestaJson({ error: { mensaje: error instanceof Error ? error.message : 'Error inesperado.' } }, 500)
  }
})

// Compara los checklists que trae ClickUp contra ot_detalle: marca
// verificado/nombre en los ítems que ya conocemos, e importa los que se
// hayan agregado directamente en ClickUp.
async function reconciliarChecklists(
  // deno-lint-ignore no-explicit-any
  supabase: any,
  trabajoId: string,
  checklists: { id: string; name: string; items: { id: string; name: string; resolved: boolean }[] }[]
) {
  const NOMBRE_A_AREA: Record<string, string> = {
    REPUESTOS: 'repuestos',
    'LUBRICANTES E INSUMOS': 'lubricantes_insumos',
    'SERVICIO EXTERNO': 'servicios_externos',
  }

  for (const checklist of checklists) {
    const area = NOMBRE_A_AREA[checklist.name]
    if (!area) continue // checklist que no es de las tres áreas conocidas: se deja como está

    for (const item of checklist.items) {
      const { data: itemExistente } = await supabase
        .from('ot_detalle')
        .select('id')
        .eq('clickup_checklist_item_id', item.id)
        .maybeSingle()

      if (itemExistente) {
        await supabase
          .from('ot_detalle')
          .update({ detalle: item.name, verificado: item.resolved })
          .eq('id', itemExistente.id)
      } else {
        await supabase.from('ot_detalle').insert({
          trabajo_id: trabajoId,
          area,
          detalle: item.name,
          verificado: item.resolved,
          clickup_checklist_item_id: item.id,
        })
      }
    }
  }
}
