// Constantes y utilidades puras del plano del taller (ver 0038_plano_taller.sql).
// Sin acceso a la base de datos: todo lo que se puede probar sin red vive acá.

export const CELDA = 32
export const COLUMNAS = 40
export const FILAS = 24

// clases: fondo/borde del rectángulo. Las clases de Tailwind van completas
// (no armadas con template strings) para que el compilador las detecte.
export const TIPOS_PLANO = {
  isla_elevador: {
    etiqueta: 'Isla con elevador',
    ancho: 3,
    alto: 5,
    esPuesto: true,
    islaNombre: 'Taller mecánico',
    clases: 'bg-sky-50 border-sky-500 text-sky-900',
  },
  isla_simple: {
    etiqueta: 'Isla sin elevador',
    ancho: 3,
    alto: 5,
    esPuesto: true,
    islaNombre: 'Taller mecánico',
    clases: 'bg-slate-50 border-slate-500 text-slate-800',
  },
  isla_pozo: {
    etiqueta: 'Isla con pozo',
    ancho: 3,
    alto: 5,
    esPuesto: true,
    islaNombre: 'Taller mecánico',
    clases: 'bg-stone-100 border-stone-500 text-stone-800',
  },
  alineadora: {
    etiqueta: 'Alineadora',
    ancho: 3,
    alto: 6,
    esPuesto: true,
    islaNombre: 'Alineación',
    clases: 'bg-indigo-50 border-indigo-500 text-indigo-900',
  },
  vulcanizacion: {
    etiqueta: 'Vulcanización',
    ancho: 3,
    alto: 4,
    esPuesto: true,
    islaNombre: null,
    clases: 'bg-orange-50 border-orange-500 text-orange-900',
  },
  pulmon: {
    etiqueta: 'Espacio de pulmón',
    ancho: 6,
    alto: 5,
    capacidad: 4,
    esPuesto: true,
    islaNombre: null,
    clases: 'bg-amber-50 border-amber-500 text-amber-900',
  },
  desabolladura_pintura: {
    etiqueta: 'Desabolladura y pintura',
    ancho: 4,
    alto: 6,
    esPuesto: true,
    islaNombre: 'Pintura',
    clases: 'bg-rose-50 border-rose-500 text-rose-900',
  },
  lavado: {
    etiqueta: 'Isla de lavado',
    ancho: 3,
    alto: 5,
    esPuesto: true,
    islaNombre: 'Lavado',
    clases: 'bg-cyan-50 border-cyan-500 text-cyan-900',
  },
  oficina: {
    etiqueta: 'Oficina',
    ancho: 5,
    alto: 4,
    esPuesto: false,
    islaNombre: null,
    clases: 'bg-emerald-50 border-emerald-600 text-emerald-900',
  },
}

export const ORDEN_PALETA = [
  'isla_elevador',
  'isla_simple',
  'isla_pozo',
  'alineadora',
  'vulcanizacion',
  'pulmon',
  'desabolladura_pintura',
  'lavado',
  'oficina',
]

export function buscarIslaPorNombre(tiposIsla, nombre) {
  if (!nombre) return null
  const buscado = nombre.toLowerCase()
  return tiposIsla.find((isla) => isla.nombre.toLowerCase() === buscado) || null
}

export function dentroDelLienzo(caja) {
  return caja.x >= 0 && caja.y >= 0 && caja.x + caja.ancho <= COLUMNAS && caja.y + caja.alto <= FILAS
}

export function seSuperponen(a, b) {
  return a.x < b.x + b.ancho && b.x < a.x + a.ancho && a.y < b.y + b.alto && b.y < a.y + a.alto
}

// Una caja es válida si cabe en el lienzo y no pisa a ninguna otra figura.
export function posicionValida(caja, elementos, ignorarId) {
  if (!dentroDelLienzo(caja)) return false
  return !elementos.some((otro) => otro.id !== ignorarId && seSuperponen(caja, otro))
}

// Primer hueco libre recorriendo el lienzo de arriba a abajo, de izquierda a derecha.
export function buscarHueco(ancho, alto, elementos) {
  for (let y = 0; y + alto <= FILAS; y++) {
    for (let x = 0; x + ancho <= COLUMNAS; x++) {
      if (posicionValida({ x, y, ancho, alto }, elementos, null)) return { x, y }
    }
  }
  return null
}

export function orientacionLarga(elemento) {
  return elemento.alto >= elemento.ancho ? 'vertical' : 'horizontal'
}

export function nombreCliente(cliente) {
  if (!cliente) return ''
  if (cliente.tipo === 'empresa') return cliente.razon_social || cliente.nombre
  return `${cliente.nombre} ${cliente.apellido || ''}`.trim()
}

export function formatoTranscurrido(desde) {
  if (!desde) return '-'
  const minutos = Math.max(0, Math.floor((Date.now() - new Date(desde).getTime()) / 60000))
  if (minutos < 60) return `${minutos} min`
  const horas = Math.floor(minutos / 60)
  if (horas < 24) return `${horas} h ${minutos % 60} min`
  return `${Math.floor(horas / 24)} d ${horas % 24} h`
}

// Plano de ejemplo: coincide con las capacidades de la demo (4 puestos de
// taller mecánico, 2 de servicio rápido, 1 de alineación, pintura y lavado).
export const PLANO_EJEMPLO = [
  { tipo: 'oficina', nombre: 'Recepción', x: 0, y: 0, ancho: 6, alto: 4 },
  { tipo: 'oficina', nombre: 'Jefe de taller', x: 6, y: 0, ancho: 5, alto: 4 },
  { tipo: 'oficina', nombre: 'Bodega y repuestos', x: 11, y: 0, ancho: 6, alto: 4 },
  { tipo: 'isla_elevador', nombre: 'Elevador 1', x: 0, y: 6 },
  { tipo: 'isla_elevador', nombre: 'Elevador 2', x: 4, y: 6 },
  { tipo: 'isla_elevador', nombre: 'Elevador 3', x: 8, y: 6 },
  { tipo: 'isla_pozo', nombre: 'Pozo 1', x: 12, y: 6 },
  { tipo: 'alineadora', nombre: 'Alineadora', x: 16, y: 6 },
  { tipo: 'vulcanizacion', nombre: 'Vulcanización', x: 20, y: 6 },
  { tipo: 'isla_simple', nombre: 'Servicio rápido 1', x: 24, y: 6, islaNombre: 'Servicio rápido' },
  { tipo: 'isla_simple', nombre: 'Servicio rápido 2', x: 28, y: 6, islaNombre: 'Servicio rápido' },
  { tipo: 'desabolladura_pintura', nombre: 'Pintura', x: 0, y: 14 },
  { tipo: 'lavado', nombre: 'Lavado', x: 5, y: 14 },
  { tipo: 'pulmon', nombre: 'Pulmón', x: 9, y: 14 },
]
