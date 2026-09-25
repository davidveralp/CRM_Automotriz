// Herramienta de un solo uso para conectar la LISTA DE LA DEMO con ClickUp,
// separada de la lista real de Didial.
//
//   verificar : compara los estados (columnas) de la lista real y la de la demo,
//               y muestra los webhooks que ya existen en el espacio de trabajo.
//   webhook   : crea el webhook de la lista demo (ClickUp -> CRM) y guarda su
//               secreto directamente en los secretos de Supabase
//               (CLICKUP_WEBHOOK_SECRET_DEMO), sin mostrarlo en pantalla.
//
// Requiere CLICKUP_API_TOKEN en el entorno: un secreto real que nunca se guarda
// en este repo ni se imprime.
//
// Uso (CMD):
//   set CLICKUP_API_TOKEN=pk_...
//   node scripts/clickup-demo.mjs verificar
//   node scripts/clickup-demo.mjs webhook
//
// "webhook" además usa el CLI de Supabase ya autenticado en esta máquina.

import { execSync } from 'node:child_process'
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const EQUIPO = '90132937173'
const LISTA_REAL = '901324296305'
const LISTA_DEMO = '901329160662'
const PROYECTO_SUPABASE = 'ywdozovkhnnvlpckstsd'
const ENDPOINT = `https://${PROYECTO_SUPABASE}.supabase.co/functions/v1/clickup-webhook`
const EVENTOS_POR_DEFECTO = ['taskCreated', 'taskUpdated', 'taskStatusUpdated', 'taskAssigneeUpdated']

const token = process.env.CLICKUP_API_TOKEN
const modo = process.argv[2]

if (!token) {
  console.error('Falta CLICKUP_API_TOKEN en el entorno.')
  process.exit(1)
}
if (!['verificar', 'webhook'].includes(modo)) {
  console.error('Uso: node scripts/clickup-demo.mjs verificar | webhook')
  process.exit(1)
}

async function api(ruta, opciones = {}) {
  const respuesta = await fetch(`https://api.clickup.com/api/v2${ruta}`, {
    ...opciones,
    headers: { Authorization: token, 'Content-Type': 'application/json' },
  })
  const texto = await respuesta.text()
  const cuerpo = texto ? JSON.parse(texto) : null
  if (!respuesta.ok) {
    throw new Error(`ClickUp respondió ${respuesta.status} en ${ruta}: ${cuerpo?.err || texto}`)
  }
  return cuerpo
}

async function leerLista(id) {
  const lista = await api(`/list/${id}`)
  return { id, nombre: lista.name, estados: (lista.statuses || []).map((estado) => estado.status) }
}

async function listarWebhooks() {
  const { webhooks } = await api(`/team/${EQUIPO}/webhook`)
  return webhooks || []
}

// IDs de los campos personalizados de la lista REAL (los mismos que hay fijos en
// supabase/functions/_shared/clickup.ts; son identificadores, no secretos).
const EMPRESA_DEMO = 'b0000000-0000-4000-8000-000000000001'
const CAMPOS_REAL = {
  datosCliente: '61ad3618-8fe4-49e8-9b74-9beae1e15ec5',
  kilometraje: '077a8b3f-5b4d-4f1f-99c6-ea331b0ad6e2',
  numeroOt: 'ffa27da5-0457-4ddc-be1a-4a365c09cf84',
  observaciones: 'd2337ca4-7808-42ee-972a-40bfc0f83fec',
  patente: 'c0783f36-567c-403d-be24-8fad9748b20b',
  tipoServicio: '108bfea6-f304-46ed-887d-53488084d9a3',
}
const OPCIONES_REAL = {
  taller_mecanico: '4bdfaf1d-cf1b-4e72-aa57-08721f7352af',
  servicio_rapido: '4babdeb1-5a12-413f-bcea-c9bd2c310fe2',
  dyp: '861d5027-3d4b-4427-b5fa-110e44d8e939',
}

const normalizar = (texto) =>
  String(texto || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .trim()

const etiquetaOpcion = (opcion) => opcion.name ?? opcion.label ?? ''

// Compara los campos personalizados de las dos listas POR NOMBRE. Si los IDs
// de la lista demo son otros, imprime el SQL que los guarda en clickup_config.
async function verificarCampos() {
  const [{ fields: camposReal }, { fields: camposDemo }] = await Promise.all([
    api(`/list/${LISTA_REAL}/field`),
    api(`/list/${LISTA_DEMO}/field`),
  ])

  console.log('')
  console.log(`Campos personalizados: real ${camposReal.length}, demo ${camposDemo.length}`)
  console.log(`  demo: ${camposDemo.map((c) => `${c.name} (${c.type})`).join(' | ')}`)

  const propios = {}
  const problemas = []
  for (const [clave, idReal] of Object.entries(CAMPOS_REAL)) {
    const enReal = camposReal.find((c) => c.id === idReal)
    if (!enReal) {
      problemas.push(`El campo "${clave}" (${idReal}) ya no existe en la lista real: revisa supabase/functions/_shared/clickup.ts.`)
      continue
    }
    const enDemo = camposDemo.find((c) => normalizar(c.name) === normalizar(enReal.name))
    if (!enDemo) {
      problemas.push(`Falta en la lista demo el campo "${enReal.name}" (tipo ${enReal.type}). Créalo con el mismo nombre y tipo.`)
      continue
    }
    if (enDemo.type !== enReal.type) {
      problemas.push(`El campo "${enReal.name}" es de tipo ${enDemo.type} en la demo y ${enReal.type} en la real.`)
    }
    propios[clave] = enDemo.id
    console.log(`  ${clave}: "${enReal.name}" -> ${enDemo.id === idReal ? 'mismo ID que la real' : `ID propio ${enDemo.id}`}`)

    if (clave === 'tipoServicio') {
      const opcionesReal = enReal.type_config?.options || []
      const opcionesDemo = enDemo.type_config?.options || []
      const opciones = {}
      for (const [categoria, idOpcionReal] of Object.entries(OPCIONES_REAL)) {
        const etiqueta = etiquetaOpcion(opcionesReal.find((o) => o.id === idOpcionReal) || {})
        const equivalente = opcionesDemo.find((o) => normalizar(etiquetaOpcion(o)) === normalizar(etiqueta))
        if (!equivalente) problemas.push(`Falta en "Tipo de servicio" de la demo la opción "${etiqueta}".`)
        else opciones[categoria] = equivalente.id
      }
      propios.opcionesTipoServicio = opciones
    }
  }

  if (problemas.length > 0) {
    console.log('')
    console.log('PROBLEMAS con los campos personalizados de la lista demo:')
    for (const problema of problemas) console.log(`  - ${problema}`)
    return
  }

  const iguales =
    Object.entries(CAMPOS_REAL).every(([clave, id]) => propios[clave] === id) &&
    Object.entries(OPCIONES_REAL).every(([categoria, id]) => propios.opcionesTipoServicio?.[categoria] === id)
  console.log('')
  if (iguales) {
    console.log('OK: los campos de la lista demo tienen los mismos IDs que los de la real; no hace falta configurar nada.')
  } else {
    console.log('Los IDs de la lista demo son distintos. Ejecuta este SQL en el editor de Supabase:')
    console.log('')
    console.log(`update public.clickup_config set campos = '${JSON.stringify(propios)}'::jsonb where empresa_id = '${EMPRESA_DEMO}';`)
  }
}

async function verificar() {
  const [real, demo] = await Promise.all([leerLista(LISTA_REAL), leerLista(LISTA_DEMO)])

  console.log(`Lista real (${real.id}): "${real.nombre}" - ${real.estados.length} estados`)
  console.log(`  ${real.estados.join(' | ')}`)
  console.log(`Lista demo (${demo.id}): "${demo.nombre}" - ${demo.estados.length} estados`)
  console.log(`  ${demo.estados.join(' | ')}`)

  const enDemo = new Set(demo.estados.map((estado) => estado.toLowerCase()))
  const enReal = new Set(real.estados.map((estado) => estado.toLowerCase()))
  const faltan = real.estados.filter((estado) => !enDemo.has(estado.toLowerCase()))
  const sobran = demo.estados.filter((estado) => !enReal.has(estado.toLowerCase()))

  console.log('')
  if (faltan.length === 0) {
    console.log('OK: la lista demo tiene todos los estados de la lista real.')
  } else {
    console.log(`FALTAN en la lista demo (${faltan.length}): ${faltan.join(', ')}`)
    console.log('Créalos con el mismo nombre en ClickUp; el CRM crea tarjetas en "agenda" o "POR DESIGNAR" y reacciona a varios de los demás.')
  }
  if (sobran.length > 0) console.log(`Estados extra en la demo (no es un problema): ${sobran.join(', ')}`)

  await verificarCampos()

  console.log('')
  const webhooks = await listarWebhooks()
  console.log(`Webhooks del espacio de trabajo (${webhooks.length}):`)
  for (const w of webhooks) {
    const alcance = w.list_id ? `lista ${w.list_id}` : w.folder_id ? `carpeta ${w.folder_id}` : w.space_id ? `espacio ${w.space_id}` : 'todo el equipo'
    console.log(`  ${w.id} -> ${w.endpoint} | ${alcance} | eventos: ${(w.events || []).join(', ')} | estado: ${w.health?.status ?? '?'}`)
  }
  const propios = webhooks.filter((w) => w.endpoint === ENDPOINT)
  const tieneDemo = propios.some((w) => String(w.list_id) === LISTA_DEMO)
  console.log('')
  console.log(tieneDemo ? 'OK: ya hay un webhook para la lista demo.' : 'Falta el webhook de la lista demo: ejecuta "webhook".')
}

async function crearWebhook() {
  const existentes = await listarWebhooks()
  const propios = existentes.filter((w) => w.endpoint === ENDPOINT)
  if (propios.some((w) => String(w.list_id) === LISTA_DEMO)) {
    console.log('Ya existe un webhook para la lista demo; no se crea otro (su secreto no se puede volver a leer).')
    console.log('Si perdiste el secreto, borra ese webhook en ClickUp y vuelve a ejecutar este comando.')
    return
  }

  // Mismos eventos que el webhook real de esta función, si ya existe uno.
  const referencia = propios.find((w) => !w.list_id || String(w.list_id) === LISTA_REAL) || propios[0]
  const eventos = referencia?.events?.length ? referencia.events : EVENTOS_POR_DEFECTO

  const creado = await api(`/team/${EQUIPO}/webhook`, {
    method: 'POST',
    body: JSON.stringify({ endpoint: ENDPOINT, events: eventos, list_id: LISTA_DEMO }),
  })
  const secreto = creado?.webhook?.secret
  if (!secreto) throw new Error('ClickUp creó el webhook pero no devolvió el secreto.')
  console.log(`Webhook creado (${creado.id}) para la lista demo, eventos: ${eventos.join(', ')}`)

  // El secreto va directo a Supabase, por un archivo temporal que se borra al terminar.
  const carpeta = mkdtempSync(join(tmpdir(), 'clickup-'))
  const archivo = join(carpeta, 'secreto.env')
  try {
    writeFileSync(archivo, `CLICKUP_WEBHOOK_SECRET_DEMO=${secreto}\n`)
    // Un solo comando (sin argumentos sueltos con shell): la ruta es de un
    // archivo temporal propio y el ID de proyecto es una constante, sin datos externos.
    execSync(`npx supabase secrets set --env-file "${archivo}" --project-ref ${PROYECTO_SUPABASE}`, { stdio: 'inherit' })
    console.log('Secreto guardado en Supabase como CLICKUP_WEBHOOK_SECRET_DEMO.')
  } catch (error) {
    console.error('No se pudo guardar el secreto en Supabase:', error.message)
    console.error('El webhook ya existe en ClickUp: bórralo allá y vuelve a ejecutar "webhook" para intentarlo de nuevo.')
    process.exitCode = 1
  } finally {
    rmSync(carpeta, { recursive: true, force: true })
  }
}

try {
  if (modo === 'verificar') await verificar()
  else await crearWebhook()
} catch (error) {
  console.error(error.message)
  process.exit(1)
}
