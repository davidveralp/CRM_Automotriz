// Cliente de la API de ClickUp v2 + constantes específicas del workspace de
// Didial, capturadas inspeccionando la lista real el 2026-09-14 (no son
// valores inventados). Si ClickUp cambia estos campos o listas, actualizar
// aquí -no hay forma de descubrirlos en tiempo de ejecución sin otra
// llamada a la API, y hardcodearlos evita esa llamada extra en cada sync-.

const BASE_URL = 'https://api.clickup.com/api/v2'

// Equipo (workspace) "DIDIAL" en ClickUp.
export const CLICKUP_TEAM_ID = '90132937173'

// IDs de los campos personalizados de la lista "Vehiculos en Taller".
export const CAMPOS_PERSONALIZADOS = {
  datosCliente: '61ad3618-8fe4-49e8-9b74-9beae1e15ec5',
  kilometraje: '077a8b3f-5b4d-4f1f-99c6-ea331b0ad6e2',
  numeroOt: 'ffa27da5-0457-4ddc-be1a-4a365c09cf84',
  observaciones: 'd2337ca4-7808-42ee-972a-40bfc0f83fec',
  patente: 'c0783f36-567c-403d-be24-8fad9748b20b',
  tipoServicio: '108bfea6-f304-46ed-887d-53488084d9a3',
} as const

// Opciones del campo "Tipo de servicio" (tipo `labels`, multi-selección).
export const OPCIONES_TIPO_SERVICIO: Record<string, string> = {
  taller_mecanico: '4bdfaf1d-cf1b-4e72-aa57-08721f7352af', // "Mecánica"
  servicio_rapido: '4babdeb1-5a12-413f-bcea-c9bd2c310fe2', // "Servicio Rápido"
  dyp: '861d5027-3d4b-4427-b5fa-110e44d8e939', // "DyP"
}

// Estado con el que nace la tarjeta según el origen del ingreso, confirmado
// por el cliente el 2026-09-15: "agenda" si el vehículo venía de una cita
// (trabajos_taller.cita_id no nulo), "POR DESIGNAR" si entró directo sin
// cita. Sin esto, ClickUp aplica el default de la lista, que no distingue
// el origen.
export const ESTADO_TARJETA_CON_CITA = 'agenda'
export const ESTADO_TARJETA_SIN_CITA = 'POR DESIGNAR'

// Nombres de los tres checklists de "lista de control" (spec §7). El orden
// importa poco; el nombre debe calzar exacto con lo que ya usa el equipo.
// Confirmados por el cliente revisando la tarjeta real de prueba
// (2026-09-15): no son los que se habían asumido al inspeccionar el
// workspace en el Bloque 4.
export const NOMBRE_CHECKLIST_POR_AREA: Record<string, string> = {
  repuestos: 'Repuestos',
  lubricantes_insumos: 'Lubricantes e insumos',
  servicios_externos: 'Servicios Rápidos',
}

export class ErrorClickUp extends Error {
  status: number
  cuerpo: unknown

  constructor(mensaje: string, status: number, cuerpo: unknown) {
    super(mensaje)
    this.name = 'ErrorClickUp'
    this.status = status
    this.cuerpo = cuerpo
  }
}

async function clickupFetch(ruta: string, opciones: RequestInit = {}): Promise<unknown> {
  const token = Deno.env.get('CLICKUP_API_TOKEN')
  if (!token) {
    throw new Error('Falta el secreto CLICKUP_API_TOKEN en este Edge Function.')
  }

  const respuesta = await fetch(`${BASE_URL}${ruta}`, {
    ...opciones,
    headers: {
      Authorization: token,
      'Content-Type': 'application/json',
      ...opciones.headers,
    },
  })

  const texto = await respuesta.text()
  const cuerpo = texto ? JSON.parse(texto) : null

  if (!respuesta.ok) {
    // Nunca tragarse el error: se necesita la causa real (código + mensaje
    // que entrega ClickUp), no un "algo falló" genérico.
    const mensaje = (cuerpo as { err?: string })?.err || `ClickUp respondió ${respuesta.status}`
    throw new ErrorClickUp(mensaje, respuesta.status, cuerpo)
  }

  return cuerpo
}

export interface MiembroClickUp {
  id: number
  username: string
  email: string
}

export async function obtenerMiembrosEquipo(): Promise<MiembroClickUp[]> {
  // No existe un GET /team/{team_id} que devuelva un solo equipo: la API
  // solo tiene "Get Authorized Teams" (GET /team, sin id), que lista TODOS
  // los workspaces a los que el token tiene acceso. Hay que traer la lista
  // completa y filtrar por CLICKUP_TEAM_ID -llamar con el id en la ruta
  // devolvía un cuerpo sin `.teams`, y `datos.teams[0]` reventaba con
  // "Cannot read properties of undefined".
  const datos = (await clickupFetch('/team')) as {
    teams: { id: string; members: { user: MiembroClickUp }[] }[]
  }
  const equipo = datos.teams?.find((t) => t.id === CLICKUP_TEAM_ID)
  return equipo ? equipo.members.map((m) => m.user) : []
}

export function encontrarPorCorreo(miembros: MiembroClickUp[], correo: string | null): MiembroClickUp | null {
  if (!correo) return null
  const objetivo = correo.trim().toLowerCase()
  return miembros.find((m) => m.email?.trim().toLowerCase() === objetivo) ?? null
}

export function crearTarea(listaId: string, cuerpo: Record<string, unknown>) {
  return clickupFetch(`/list/${listaId}/task`, { method: 'POST', body: JSON.stringify(cuerpo) })
}

export function actualizarTarea(tareaId: string, cuerpo: Record<string, unknown>) {
  return clickupFetch(`/task/${tareaId}`, { method: 'PUT', body: JSON.stringify(cuerpo) })
}

export function obtenerTarea(tareaId: string) {
  return clickupFetch(`/task/${tareaId}`)
}

export function fijarCampoPersonalizado(tareaId: string, campoId: string, valor: unknown) {
  return clickupFetch(`/task/${tareaId}/field/${campoId}`, {
    method: 'POST',
    body: JSON.stringify({ value: valor }),
  })
}

export function crearChecklist(tareaId: string, nombre: string) {
  return clickupFetch(`/task/${tareaId}/checklist`, {
    method: 'POST',
    body: JSON.stringify({ name: nombre }),
  })
}

export function crearItemChecklist(checklistId: string, nombre: string, asignadoId: number | null) {
  const cuerpo: Record<string, unknown> = { name: nombre }
  if (asignadoId) cuerpo.assignee = asignadoId
  return clickupFetch(`/checklist/${checklistId}/checklist_item`, {
    method: 'POST',
    body: JSON.stringify(cuerpo),
  })
}

export function actualizarItemChecklist(
  checklistId: string,
  itemId: string,
  cuerpo: Record<string, unknown>
) {
  return clickupFetch(`/checklist/${checklistId}/checklist_item/${itemId}`, {
    method: 'PUT',
    body: JSON.stringify(cuerpo),
  })
}

export function eliminarTarea(tareaId: string) {
  return clickupFetch(`/task/${tareaId}`, { method: 'DELETE' })
}

// Campos personalizados de la lista de una empresa. Los de la lista real de
// Didial están fijos arriba; otra lista (por ejemplo la de la demo) puede tener
// IDs distintos, y se guardan en clickup_config.campos (jsonb). null o campos
// que falten = los de la lista real.
export interface CamposLista {
  ids: Record<keyof typeof CAMPOS_PERSONALIZADOS, string>
  opcionesTipoServicio: Record<string, string>
}

export function resolverCampos(campos: unknown): CamposLista {
  const configurados = (campos && typeof campos === 'object' ? campos : {}) as Record<string, unknown>
  const ids: Record<keyof typeof CAMPOS_PERSONALIZADOS, string> = { ...CAMPOS_PERSONALIZADOS }
  for (const clave of Object.keys(ids) as (keyof typeof CAMPOS_PERSONALIZADOS)[]) {
    if (typeof configurados[clave] === 'string' && configurados[clave]) ids[clave] = configurados[clave] as string
  }
  const opciones = { ...OPCIONES_TIPO_SERVICIO }
  const propias = configurados.opcionesTipoServicio
  if (propias && typeof propias === 'object') {
    for (const [clave, valor] of Object.entries(propias as Record<string, unknown>)) {
      if (typeof valor === 'string' && valor) opciones[clave] = valor
    }
  }
  return { ids, opcionesTipoServicio: opciones }
}

// Diferencia de la zona horaria de Chile (minutos respecto de UTC) en un instante dado.
function desfaseChileMinutos(instante: Date): number {
  const partes = Object.fromEntries(
    new Intl.DateTimeFormat('en-US', {
      timeZone: 'America/Santiago',
      hourCycle: 'h23',
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
    })
      .formatToParts(instante)
      .map((parte) => [parte.type, parte.value])
  )
  const comoUtc = Date.UTC(+partes.year, +partes.month - 1, +partes.day, +partes.hour, +partes.minute, +partes.second)
  return (comoUtc - instante.getTime()) / 60000
}

// Milisegundos desde 1970 de una fecha y hora "de pared" de Chile (respeta el
// cambio de horario de verano). ClickUp espera esa marca de tiempo en las
// fechas de vencimiento. Sin hora se usa 09:00.
export function marcaTiempoChile(fecha: string, hora: string | null): number {
  const [anio, mes, dia] = fecha.split('-').map(Number)
  const [horas, minutos] = (hora ?? '09:00').split(':').map(Number)
  const suposicion = Date.UTC(anio, mes - 1, dia, horas, minutos)
  const primerDesfase = desfaseChileMinutos(new Date(suposicion))
  const candidato = suposicion - primerDesfase * 60000
  const segundoDesfase = desfaseChileMinutos(new Date(candidato))
  return suposicion - segundoDesfase * 60000
}
