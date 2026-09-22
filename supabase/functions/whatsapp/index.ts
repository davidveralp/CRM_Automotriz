// whatsapp
//
// Webhook + endpoint de envío para la integración de WhatsApp Cloud API en
// modo Coexistencia (dos números reales de Didial: Toyota y Multimarca, ver
// 0032_whatsapp_recepcion.sql). Un solo Deno.serve maneja dos cosas
// distintas, cada una con su propia forma de autenticación -Verify JWT
// queda OFF en el dashboard de Supabase a propósito, porque Meta llama al
// webhook sin ninguna sesión de Supabase-:
//
//   1. GET  -> verificación del webhook (handshake único al suscribir en
//      Meta App Dashboard): compara hub.verify_token contra WA_VERIFY_TOKEN.
//   2. POST con encabezado Authorization -> acción propia del CRM (enviar
//      un mensaje desde el panel de Recepción). Con "Verify JWT" en OFF a
//      nivel de función, el gateway de Supabase no valida esto solo, así
//      que se verifica acá mismo contra Supabase Auth (`auth.getUser`) y se
//      confirma el rol de quien llama contra `usuarios` -igual que
//      cualquier otra pantalla protegida de este CRM, nada de un secreto
//      estático compartido: un documento de referencia de otro proyecto
//      proponía eso, pero acá el frontend es una SPA pública y cualquier
//      secreto embebido en su bundle deja de ser secreto-.
//   3. POST sin ese encabezado -> webhook real de Meta. Exige una firma
//      X-Hub-Signature-256 válida (HMAC-SHA256 con WA_APP_SECRET) antes de
//      procesar nada -sin esto, cualquiera que adivinara la URL podría
//      inyectar mensajes falsos en la bandeja de Recepción-.
//
// Formas de payload verificadas contra la documentación oficial de Meta
// (developers.facebook.com/documentation/business-messaging/whatsapp/webhooks/reference/*)
// el 2026-09-21, no adivinadas de un documento de otro proyecto: los 5
// campos (`messages`, `smb_message_echoes`, `history`, `smb_app_state_sync`,
// `account_update`) usan el mismo sobre `entry[].changes[].field/value`
// -incluyendo `history`, que ese documento anterior asumía con una forma
// distinta-. Aun así, nada de esto se ha probado todavía contra un webhook
// real (la cuenta de Meta sigue esperando aprobación de "Tech Provider"):
// `payload_original` se guarda siempre crudo en cada tabla para poder
// reprocesar si algún nombre de campo resulta distinto en producción real.
import { createClient } from 'jsr:@supabase/supabase-js@2'

const GRAPH_BASE = 'https://graph.facebook.com/v23.0'

// Roles que pueden operar el panel de Recepción -mismo grupo que la policy
// de UPDATE de whatsapp_contactos en 0032_whatsapp_recepcion.sql-.
const ROLES_PUEDEN_ENVIAR = ['asesor', 'recepcionista', 'jefe_taller', 'admin', 'socia']

// deno-lint-ignore no-explicit-any
type Cambio = { field: string; value: Record<string, any> }
type Entrada = { id: string; changes?: Cambio[] }

function clienteServicio() {
  return createClient(Deno.env.get('SUPABASE_URL')!, Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!)
}

Deno.serve(async (req) => {
  const url = new URL(req.url)

  if (req.method === 'GET') return manejarVerificacion(url)
  if (req.method !== 'POST') return new Response('Método no soportado.', { status: 405 })

  const cuerpoCrudo = await req.text()
  const encabezadoAuth = req.headers.get('Authorization')

  if (encabezadoAuth) {
    const usuario = await usuarioDesdeToken(encabezadoAuth)
    if (!usuario) return json({ error: { mensaje: 'Sesión inválida o expirada.' } }, 401)
    if (!ROLES_PUEDEN_ENVIAR.includes(usuario.rol ?? '')) {
      return json({ error: { mensaje: 'Tu rol no tiene permiso para enviar mensajes de WhatsApp.' } }, 403)
    }
    return await manejarEnvio(clienteServicio(), usuario.empresa_id, JSON.parse(cuerpoCrudo))
  }

  if (!(await firmaValida(cuerpoCrudo, req.headers.get('X-Hub-Signature-256')))) {
    return json({ error: { mensaje: 'Firma inválida.' } }, 401)
  }

  const payload = JSON.parse(cuerpoCrudo) as { entry?: Entrada[] }
  await procesarWebhook(clienteServicio(), payload)
  return json({ recibido: true })
})

// Verifica el JWT de la sesión del navegador contra Supabase Auth (el
// gateway no lo hace por nosotros con "Verify JWT" en OFF) y confirma que
// la cuenta sigue activa y con rol -mismo criterio que ya usa `AuthContext`
// del frontend, reescrito acá porque el Edge Function no comparte ese
// código con el navegador-.
async function usuarioDesdeToken(encabezadoAuth: string): Promise<{ id: string; empresa_id: string; rol: string | null } | null> {
  const token = encabezadoAuth.replace(/^Bearer\s+/i, '')
  const clienteAuth = createClient(Deno.env.get('SUPABASE_URL')!, Deno.env.get('SUPABASE_ANON_KEY')!, {
    global: { headers: { Authorization: `Bearer ${token}` } },
  })

  const { data: datosAuth, error: errorAuth } = await clienteAuth.auth.getUser(token)
  if (errorAuth || !datosAuth?.user) return null

  const { data: fila } = await clienteAuth
    .from('usuarios')
    .select('id, empresa_id, rol, activo')
    .eq('id', datosAuth.user.id)
    .maybeSingle()

  if (!fila || !fila.activo) return null
  return fila
}

function manejarVerificacion(url: URL): Response {
  const modo = url.searchParams.get('hub.mode')
  const token = url.searchParams.get('hub.verify_token')
  const desafio = url.searchParams.get('hub.challenge')
  if (modo === 'subscribe' && token && token === Deno.env.get('WA_VERIFY_TOKEN')) {
    return new Response(desafio ?? '', { status: 200 })
  }
  return new Response('Verificación fallida.', { status: 403 })
}

async function firmaValida(cuerpoCrudo: string, firmaRecibida: string | null): Promise<boolean> {
  const secreto = Deno.env.get('WA_APP_SECRET')
  if (!secreto || !firmaRecibida) return false

  const claveCripto = await crypto.subtle.importKey(
    'raw',
    new TextEncoder().encode(secreto),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign']
  )
  const firma = await crypto.subtle.sign('HMAC', claveCripto, new TextEncoder().encode(cuerpoCrudo))
  const firmaHex =
    'sha256=' +
    Array.from(new Uint8Array(firma))
      .map((b) => b.toString(16).padStart(2, '0'))
      .join('')

  return firmaHex === firmaRecibida
}

function json(cuerpo: unknown, status = 200) {
  return new Response(JSON.stringify(cuerpo), { status, headers: { 'Content-Type': 'application/json' } })
}

function tsAFecha(tsSegundos: string | number): string {
  return new Date(Number(tsSegundos) * 1000).toISOString()
}

function soloDigitos(valor: string | undefined | null): string {
  return (valor ?? '').replace(/[^0-9]/g, '')
}

// ---------------------------------------------------------------------------
// Despacho por campo (fix del documento original: un código que asume
// siempre "messages" pierde los otros 4 campos en silencio -responde 200 a
// Meta igual, así que el problema no se nota hasta que falta un mensaje-).
// ---------------------------------------------------------------------------
async function procesarWebhook(
  // deno-lint-ignore no-explicit-any
  supabase: any,
  payload: { entry?: Entrada[] }
) {
  for (const entrada of payload.entry ?? []) {
    for (const cambio of entrada.changes ?? []) {
      try {
        switch (cambio.field) {
          case 'messages':
            await procesarMensajes(supabase, cambio.value)
            break
          case 'smb_message_echoes':
            await procesarEcos(supabase, cambio.value)
            break
          case 'history':
            await procesarHistorial(supabase, cambio.value)
            break
          case 'smb_app_state_sync':
            await procesarSincronizacionContactos(supabase, cambio.value)
            break
          case 'account_update':
            await procesarEventoCuenta(supabase, entrada.id, cambio.value)
            break
          default:
          // Campo no contemplado: se ignora, mismo criterio que clickup-webhook
          // con eventos que no le competen.
        }
      } catch (error) {
        console.error(`whatsapp: error procesando campo "${cambio.field}":`, error)
      }
    }
  }
}

// deno-lint-ignore no-explicit-any
async function empresaDeCuenta(supabase: any, phoneNumberId: string): Promise<string | null> {
  const { data } = await supabase.from('whatsapp_cuentas').select('empresa_id').eq('phone_number_id', phoneNumberId).maybeSingle()
  return data?.empresa_id ?? null
}

// deno-lint-ignore no-explicit-any
async function empresaDeWaba(supabase: any, wabaId: string): Promise<string | null> {
  const { data } = await supabase.from('whatsapp_cuentas').select('empresa_id').eq('waba_id', wabaId).maybeSingle()
  return data?.empresa_id ?? null
}

// Alta/actualización de contacto + intento de match automático por
// teléfono, todo en el RPC (ver 0032_whatsapp_recepcion.sql) para que sea
// atómico y nunca pise la categorización manual de Recepción.
async function registrarContacto(
  // deno-lint-ignore no-explicit-any
  supabase: any,
  empresaId: string,
  phoneNumberId: string,
  waId: string | undefined,
  nombreWhatsapp: string | null
) {
  if (!waId) return
  const { error } = await supabase.rpc('whatsapp_registrar_contacto', {
    p_empresa_id: empresaId,
    p_phone_number_id: phoneNumberId,
    p_wa_id: waId,
    p_nombre_whatsapp: nombreWhatsapp,
  })
  if (error) console.error('whatsapp: error registrando contacto', error)
}

// deno-lint-ignore no-explicit-any
async function marcarSincronizacion(supabase: any, phoneNumberId: string, tipo: string, cambios: Record<string, unknown>) {
  const { data: existente } = await supabase
    .from('whatsapp_sincronizaciones')
    .select('id')
    .eq('phone_number_id', phoneNumberId)
    .eq('tipo', tipo)
    .order('iniciado_en', { ascending: false })
    .limit(1)
    .maybeSingle()

  if (existente) {
    const { error } = await supabase.from('whatsapp_sincronizaciones').update(cambios).eq('id', existente.id)
    if (error) console.error('whatsapp: error actualizando sincronización', error)
    return
  }

  // No debería pasar en operación normal (la fila se crea al pedir la
  // sincronización), pero si llega un webhook sin ese registro previo, se
  // deja constancia igual en vez de perder la señal.
  const empresaId = await empresaDeCuenta(supabase, phoneNumberId)
  if (!empresaId) return
  const { error } = await supabase
    .from('whatsapp_sincronizaciones')
    .insert({ empresa_id: empresaId, phone_number_id: phoneNumberId, tipo, ...cambios })
  if (error) console.error('whatsapp: error creando sincronización', error)
}

// ---------------------------------------------------------------------------
// field = "messages": mensajes entrantes (value.messages), estados de
// entrega de lo que el CRM mandó (value.statuses).
// ---------------------------------------------------------------------------
// deno-lint-ignore no-explicit-any
async function procesarMensajes(supabase: any, valor: Record<string, any>) {
  const phoneNumberId = valor?.metadata?.phone_number_id
  if (!phoneNumberId) return
  const empresaId = await empresaDeCuenta(supabase, phoneNumberId)
  if (!empresaId) return

  const nombrePorWaId = new Map<string, string>()
  for (const contacto of valor.contacts ?? []) {
    if (contacto?.wa_id && contacto?.profile?.name) nombrePorWaId.set(contacto.wa_id, contacto.profile.name)
  }

  for (const mensaje of valor.messages ?? []) {
    await registrarContacto(supabase, empresaId, phoneNumberId, mensaje.from, nombrePorWaId.get(mensaje.from) ?? null)

    const { error } = await supabase.from('whatsapp_mensajes').upsert(
      {
        wamid: mensaje.id,
        empresa_id: empresaId,
        phone_number_id: phoneNumberId,
        wa_id: mensaje.from,
        direccion: 'entrante',
        origen: 'cloud_api',
        tipo_mensaje: mensaje.type,
        contenido: mensaje,
        wa_timestamp: tsAFecha(mensaje.timestamp),
        payload_original: mensaje,
      },
      { onConflict: 'wamid', ignoreDuplicates: true }
    )
    if (error) console.error('whatsapp: error insertando mensaje entrante', error)
  }

  for (const estado of valor.statuses ?? []) {
    const { error } = await supabase.from('whatsapp_mensajes').update({ estado_entrega: estado.status }).eq('wamid', estado.id)
    if (error) console.error('whatsapp: error actualizando estado de entrega', error)
  }
}

// ---------------------------------------------------------------------------
// field = "smb_message_echoes": el equipo respondió desde la app del
// celular, no desde el CRM -mismo hilo, saliente-.
// ---------------------------------------------------------------------------
// deno-lint-ignore no-explicit-any
async function procesarEcos(supabase: any, valor: Record<string, any>) {
  const phoneNumberId = valor?.metadata?.phone_number_id
  if (!phoneNumberId) return
  const empresaId = await empresaDeCuenta(supabase, phoneNumberId)
  if (!empresaId) return

  for (const eco of valor.message_echoes ?? []) {
    await registrarContacto(supabase, empresaId, phoneNumberId, eco.to, null)

    const { error } = await supabase.from('whatsapp_mensajes').upsert(
      {
        wamid: eco.id,
        empresa_id: empresaId,
        phone_number_id: phoneNumberId,
        wa_id: eco.to,
        direccion: 'saliente',
        origen: 'app_celular',
        tipo_mensaje: eco.type,
        contenido: eco,
        wa_timestamp: tsAFecha(eco.timestamp),
        payload_original: eco,
      },
      { onConflict: 'wamid', ignoreDuplicates: true }
    )
    if (error) console.error('whatsapp: error insertando eco de mensaje', error)
  }
}

// ---------------------------------------------------------------------------
// field = "history": carga única de conversación previa a la conexión
// (hasta 180 días), en fases/chunks. value.history[].errors (código
// 2593109) si el negocio no compartió historial desde la app.
// ---------------------------------------------------------------------------
// deno-lint-ignore no-explicit-any
async function procesarHistorial(supabase: any, valor: Record<string, any>) {
  const phoneNumberId = valor?.metadata?.phone_number_id
  if (!phoneNumberId) return
  const empresaId = await empresaDeCuenta(supabase, phoneNumberId)
  if (!empresaId) return

  const numeroNegocio = soloDigitos(valor?.metadata?.display_phone_number)

  for (const item of valor.history ?? []) {
    if (item.errors?.length) {
      const codigo = item.errors[0]?.code
      if (codigo === 2593109) {
        await marcarSincronizacion(supabase, phoneNumberId, 'historial', {
          estado: 'rechazado',
          completado_en: new Date().toISOString(),
        })
      } else {
        console.error('whatsapp: error en history', item.errors)
      }
      continue
    }

    const fase = item.metadata?.phase ?? null
    const progreso = item.metadata?.progress ?? null

    await marcarSincronizacion(supabase, phoneNumberId, 'historial', {
      estado: Number(progreso) >= 100 ? 'completo' : 'en_progreso',
      fase,
      progreso,
      completado_en: Number(progreso) >= 100 ? new Date().toISOString() : null,
    })

    for (const hilo of item.threads ?? []) {
      const waId = hilo.id
      await registrarContacto(supabase, empresaId, phoneNumberId, waId, null)

      for (const mensaje of hilo.messages ?? []) {
        const direccion = soloDigitos(mensaje.from) === numeroNegocio ? 'saliente' : 'entrante'
        const { error } = await supabase.from('whatsapp_mensajes').upsert(
          {
            wamid: mensaje.id,
            empresa_id: empresaId,
            phone_number_id: phoneNumberId,
            wa_id: waId,
            direccion,
            origen: 'historial',
            tipo_mensaje: mensaje.type,
            contenido: mensaje,
            fase_historial: fase,
            wa_timestamp: tsAFecha(mensaje.timestamp),
            payload_original: mensaje,
          },
          { onConflict: 'wamid', ignoreDuplicates: true }
        )
        if (error) console.error('whatsapp: error insertando mensaje de historial', error)
      }
    }
  }
}

// ---------------------------------------------------------------------------
// field = "smb_app_state_sync": altas/ediciones ("add") y bajas ("remove")
// de contactos en la app del celular. Una baja NO borra el contacto acá
// -perdería el vínculo con el cliente y, por cascada, su historial de
// mensajes-, solo queda registrado en el log de la función.
// ---------------------------------------------------------------------------
// deno-lint-ignore no-explicit-any
async function procesarSincronizacionContactos(supabase: any, valor: Record<string, any>) {
  const phoneNumberId = valor?.metadata?.phone_number_id
  if (!phoneNumberId) return
  const empresaId = await empresaDeCuenta(supabase, phoneNumberId)
  if (!empresaId) return

  for (const item of valor.state_sync ?? []) {
    if (item.type !== 'contact') continue

    if (item.action === 'add') {
      const nombre = item.contact?.full_name || item.contact?.first_name || null
      await registrarContacto(supabase, empresaId, phoneNumberId, item.contact?.phone_number, nombre)
    } else if (item.action === 'remove') {
      console.log(`whatsapp: contacto eliminado en la app del celular (${item.contact?.phone_number ?? 'desconocido'})`)
    }
  }
}

// ---------------------------------------------------------------------------
// field = "account_update": PARTNER_REMOVED (se desconectó de la API),
// ACCOUNT_OFFBOARDED, ACCOUNT_RECONNECTED. Solo PARTNER_REMOVED trae
// waba_info -para los otros dos se usa el id de la entrada (WABA ID real
// según la referencia de Meta), y ninguno trae phone_number_id-.
// ---------------------------------------------------------------------------
// deno-lint-ignore no-explicit-any
async function procesarEventoCuenta(supabase: any, wabaIdEntrada: string, valor: Record<string, any>) {
  const wabaId = valor?.waba_info?.waba_id ?? wabaIdEntrada
  const empresaId = await empresaDeWaba(supabase, wabaId)

  const { error } = await supabase.from('whatsapp_eventos_cuenta').insert({
    empresa_id: empresaId,
    waba_id: wabaId,
    evento: valor?.event ?? 'desconocido',
    motivo: valor?.disconnection_info?.reason ?? null,
    iniciado_por: valor?.disconnection_info?.initiated_by ?? null,
    payload_original: valor,
  })
  if (error) console.error('whatsapp: error insertando evento de cuenta', error)

  if (valor?.event === 'PARTNER_REMOVED' && empresaId) {
    const { error: errorNotif } = await supabase.from('notificaciones').insert({
      empresa_id: empresaId,
      tipo: 'whatsapp_desconectado',
      titulo: 'WhatsApp desconectado',
      mensaje: `El número quedó desconectado de la API (WABA ${wabaId}). Hay que repetir la conexión desde Embedded Signup dentro de las próximas 24 horas para no perder mensajes.`,
    })
    if (errorNotif) console.error('whatsapp: error creando notificación de desconexión', errorNotif)
  }
}

// ---------------------------------------------------------------------------
// Acción propia del CRM: enviar un mensaje de texto desde el panel de
// Recepción. Protegida con CRM_SECRET (fix del documento original: la rama
// de envío no verificaba quién llamaba, y Verify JWT está OFF a propósito
// para que Meta pueda llamar al webhook sin sesión de Supabase).
// ---------------------------------------------------------------------------
// deno-lint-ignore no-explicit-any
async function manejarEnvio(supabase: any, empresaId: string, body: Record<string, any>): Promise<Response> {
  const phoneNumberId = body?.phone_number_id
  const waId = body?.wa_id
  const texto = body?.texto

  if (!phoneNumberId || !waId || !texto) {
    return json({ error: { mensaje: 'Faltan phone_number_id, wa_id o texto.' } }, 400)
  }

  // La cuenta debe ser de la MISMA empresa de quien llama -nunca confiar en
  // el phone_number_id que manda el body sin cruzarlo contra algo propio
  // del usuario autenticado; en multi-tenant, evita que alguien mande un
  // phone_number_id de otro tenant y el mensaje salga igual.
  const empresaDeLaCuenta = await empresaDeCuenta(supabase, phoneNumberId)
  if (empresaDeLaCuenta !== empresaId) {
    return json({ error: { mensaje: 'Esa cuenta de WhatsApp no pertenece a tu empresa.' } }, 403)
  }

  const respuesta = await fetch(`${GRAPH_BASE}/${phoneNumberId}/messages`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${Deno.env.get('WA_TOKEN')}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ messaging_product: 'whatsapp', to: waId, type: 'text', text: { body: texto } }),
  })

  const resultado = await respuesta.json()
  if (!respuesta.ok) {
    return json({ error: { mensaje: 'Meta rechazó el envío.', detalle: resultado } }, 502)
  }

  const wamid = resultado.messages?.[0]?.id

  if (wamid) {
    const { error } = await supabase.from('whatsapp_mensajes').upsert(
      {
        wamid,
        empresa_id: empresaId,
        phone_number_id: phoneNumberId,
        wa_id: waId,
        direccion: 'saliente',
        origen: 'cloud_api',
        tipo_mensaje: 'text',
        contenido: { text: { body: texto } },
        wa_timestamp: new Date().toISOString(),
        payload_original: resultado,
      },
      { onConflict: 'wamid', ignoreDuplicates: true }
    )
    if (error) console.error('whatsapp: error registrando mensaje enviado', error)

    await registrarContacto(supabase, empresaId, phoneNumberId, waId, null)
  }

  return json({ ok: true, wamid })
}
