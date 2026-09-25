// Funciones puras de la Agenda: fechas, bloques de 30 minutos y ocupación.
// Sin acceso a la base de datos ni a React: todo lo que se puede probar sin red.
//
// Las fechas son siempre texto "YYYY-MM-DD" y se arman con componentes LOCALES.
// new Date('YYYY-MM-DD') se interpreta como medianoche UTC: en Chile (UTC-3/-4)
// eso puede caer en el día calendario anterior y dar un día de la semana
// equivocado (mismo gotcha ya documentado en Agenda.jsx).

export const ESTADOS_QUE_OCUPAN_CUPO = ['agendada', 'confirmada']
export const PASO_BLOQUE_MINUTOS = 30

// De la vista más amplia a la más fina: sirve para animar el cambio de vista como
// un acercamiento (hacia el día) o un alejamiento (hacia el año).
export const NIVEL_DE_VISTA = { anio: 0, mes: 1, semana: 2, dia: 3 }

const DIAS_SEMANA_CORTOS = ['dom', 'lun', 'mar', 'mié', 'jue', 'vie', 'sáb']

function dosDigitos(numero) {
  return String(numero).padStart(2, '0')
}

function aISO(fecha) {
  return `${fecha.getFullYear()}-${dosDigitos(fecha.getMonth() + 1)}-${dosDigitos(fecha.getDate())}`
}

function deISO(fechaISO) {
  const [anio, mes, dia] = fechaISO.split('-').map(Number)
  return new Date(anio, mes - 1, dia)
}

// Hoy según el reloj de quien usa la app (no UTC: pasadas las 21:00 en Chile
// toISOString() ya devuelve el día siguiente).
export function hoyLocalISO() {
  return aISO(new Date())
}

export function sumarDias(fechaISO, dias) {
  const fecha = deISO(fechaISO)
  fecha.setDate(fecha.getDate() + dias)
  return aISO(fecha)
}

export function diaSemanaDe(fechaISO) {
  return deISO(fechaISO).getDay()
}

// Lunes de la semana de una fecha (la semana chilena parte el lunes).
export function lunesDe(fechaISO) {
  const dia = diaSemanaDe(fechaISO)
  return sumarDias(fechaISO, dia === 0 ? -6 : 1 - dia)
}

export function primerDiaDelMes(fechaISO) {
  const [anio, mes] = fechaISO.split('-').map(Number)
  return `${anio}-${dosDigitos(mes)}-01`
}

export function ultimoDiaDelMes(fechaISO) {
  const [anio, mes] = fechaISO.split('-').map(Number)
  return aISO(new Date(anio, mes, 0))
}

export function sumarMeses(fechaISO, meses) {
  const [anio, mes] = fechaISO.split('-').map(Number)
  return aISO(new Date(anio, mes - 1 + meses, 1))
}

export function diasEntre(desde, hasta) {
  const dias = []
  for (let f = desde; f <= hasta; f = sumarDias(f, 1)) dias.push(f)
  return dias
}

// Rango de fechas que hay que pedir a la base según la vista.
export function rangoDeVista(vista, fechaISO) {
  if (vista === 'anio') {
    const anio = fechaISO.slice(0, 4)
    return { desde: `${anio}-01-01`, hasta: `${anio}-12-31` }
  }
  if (vista === 'semana') {
    const lunes = lunesDe(fechaISO)
    return { desde: lunes, hasta: sumarDias(lunes, 6) }
  }
  if (vista === 'mes') {
    // La grilla del mes empieza el lunes anterior al día 1 y termina el domingo
    // posterior al último día.
    const desde = lunesDe(primerDiaDelMes(fechaISO))
    const hasta = sumarDias(lunesDe(ultimoDiaDelMes(fechaISO)), 6)
    return { desde, hasta }
  }
  return { desde: fechaISO, hasta: fechaISO }
}

export function moverFecha(vista, fechaISO, sentido) {
  if (vista === 'anio') return sumarMeses(fechaISO, 12 * sentido)
  if (vista === 'semana') return sumarDias(fechaISO, 7 * sentido)
  if (vista === 'mes') return sumarMeses(fechaISO, sentido)
  return sumarDias(fechaISO, sentido)
}

export function etiquetaDiaCorta(fechaISO) {
  const fecha = deISO(fechaISO)
  return `${DIAS_SEMANA_CORTOS[fecha.getDay()]} ${fecha.getDate()}`
}

export function etiquetaLarga(fechaISO) {
  return deISO(fechaISO).toLocaleDateString('es-CL', { weekday: 'long', day: '2-digit', month: '2-digit' })
}

export function etiquetaDeRango(vista, fechaISO) {
  if (vista === 'anio') return fechaISO.slice(0, 4)
  if (vista === 'mes') {
    return deISO(fechaISO).toLocaleDateString('es-CL', { month: 'long', year: 'numeric' })
  }
  if (vista === 'semana') {
    const { desde, hasta } = rangoDeVista('semana', fechaISO)
    const inicio = deISO(desde).toLocaleDateString('es-CL', { day: 'numeric', month: 'short' })
    const fin = deISO(hasta).toLocaleDateString('es-CL', { day: 'numeric', month: 'short', year: 'numeric' })
    return `${inicio} al ${fin}`
  }
  return etiquetaLarga(fechaISO)
}

export function horaAMinutos(hora) {
  const [h, m] = hora.split(':').map(Number)
  return h * 60 + m
}

export function minutosAHora(minutos) {
  return `${dosDigitos(Math.floor(minutos / 60))}:${dosDigitos(minutos % 60)}`
}

export function generarBloques(apertura, cierre) {
  const bloques = []
  let actual = horaAMinutos(apertura)
  const fin = horaAMinutos(cierre)
  while (actual < fin) {
    bloques.push(minutosAHora(actual))
    actual += PASO_BLOQUE_MINUTOS
  }
  return bloques
}

// Ocupación de una isla en un bloque puntual, por solapamiento de horario
// -mismo criterio que citas_cupos_disponibles (0010_agenda_duracion.sql):
// sin hora/duración = ocupa hasta el cierre del día calendario-.
export function citasEnBloque(citasIsla, bloque) {
  const inicioBloque = horaAMinutos(bloque)
  const finBloque = inicioBloque + PASO_BLOQUE_MINUTOS
  return citasIsla.filter((c) => {
    if (!ESTADOS_QUE_OCUPAN_CUPO.includes(c.estado)) return false
    const inicio = c.hora ? horaAMinutos(c.hora) : 0
    const fin = c.duracion_estimada_minutos != null ? inicio + c.duracion_estimada_minutos : 24 * 60
    return inicio < finBloque && inicioBloque < fin
  })
}

export function bloqueEnCorte(bloque, corte) {
  if (!corte?.inicio || !corte?.fin) return false
  const minuto = horaAMinutos(bloque)
  return minuto >= horaAMinutos(corte.inicio) && minuto < horaAMinutos(corte.fin)
}

// Cupos de un día: por cada bloque de atención, cuántos puestos hay y cuántos
// están libres sumando todas las islas que operan en ese bloque (durante el
// corte de mediodía solo cuentan las islas que siguen operando).
export function ocupacionDelDia(fechaISO, citasDia, tiposIsla, horarios, corte) {
  const horario = horarios.find((h) => h.dia_semana === diaSemanaDe(fechaISO))
  if (!horario) return { abierto: false, bloques: [], libres: 0, total: 0, pctOcupado: 0 }

  const bloques = generarBloques(horario.hora_apertura, horario.hora_cierre).map((bloque) => {
    const enCorte = bloqueEnCorte(bloque, corte)
    let libres = 0
    let total = 0
    for (const isla of tiposIsla) {
      if (enCorte && !isla.opera_en_corte) continue
      const ocupantes = citasEnBloque(
        citasDia.filter((c) => c.tipo_isla_id === isla.id),
        bloque
      ).length
      total += isla.capacidad
      libres += Math.max(0, isla.capacidad - ocupantes)
    }
    return { bloque, libres, total }
  })

  const total = bloques.reduce((suma, b) => suma + b.total, 0)
  const libres = bloques.reduce((suma, b) => suma + b.libres, 0)
  return { abierto: true, bloques, libres, total, pctOcupado: total ? Math.round(((total - libres) / total) * 100) : 0 }
}

// Los bloques con más disponibilidad de un conjunto de días, para sugerir el
// mejor momento para atender a alguien. Empata por el más temprano.
export function mejoresMomentos(ocupacionPorDia, cantidad = 3) {
  const candidatos = []
  for (const [fecha, ocupacion] of Object.entries(ocupacionPorDia)) {
    for (const b of ocupacion.bloques) {
      if (b.total > 0 && b.libres > 0) candidatos.push({ fecha, bloque: b.bloque, libres: b.libres, total: b.total })
    }
  }
  candidatos.sort(
    (a, b) => b.libres / b.total - a.libres / a.total || b.libres - a.libres || a.fecha.localeCompare(b.fecha) || a.bloque.localeCompare(b.bloque)
  )
  return candidatos.slice(0, cantidad)
}

export function nombreVisible(cliente) {
  if (!cliente) return ''
  if (cliente.tipo === 'empresa') return cliente.razon_social || cliente.nombre
  return [cliente.nombre, cliente.apellido].filter(Boolean).join(' ')
}

// Reglas para mover una cita a otro día u hora. Devuelve { ok, motivo }.
//   - otrasCitasDelDia: las citas del día de destino (puede incluir la propia
//     cita: se ignora), para contar cupo sin que ella misma ocupe su lugar nuevo.
//   - ahoraMinutos: la hora actual en minutos, solo para no agendar en una hora
//     que ya pasó hoy.
// Usa las mismas reglas que la grilla: horario de atención por día, corte de
// mediodía (solo opera la isla que lo permite) y capacidad por bloque de 30 min.
export function validarReagendamiento({ cita, fecha, hora, otrasCitasDelDia, isla, horarios, corte, hoy, ahoraMinutos }) {
  if (!fecha || !hora) return { ok: false, motivo: 'Elige el día y la hora.' }
  if (fecha < hoy) return { ok: false, motivo: 'No se puede agendar en un día que ya pasó.' }

  const inicio = horaAMinutos(hora)
  if (fecha === hoy && ahoraMinutos != null && inicio < ahoraMinutos) {
    return { ok: false, motivo: 'Esa hora ya pasó hoy.' }
  }
  if (fecha === cita.fecha && cita.hora && hora === cita.hora.slice(0, 5)) {
    return { ok: false, motivo: 'Es el mismo día y hora que ya tiene.' }
  }

  const horario = horarios.find((h) => h.dia_semana === diaSemanaDe(fecha))
  if (!horario) return { ok: false, motivo: 'El taller no atiende ese día.' }

  const duracion = cita.duracion_estimada_minutos ?? PASO_BLOQUE_MINUTOS
  const fin = inicio + duracion
  const apertura = horaAMinutos(horario.hora_apertura)
  const cierre = horaAMinutos(horario.hora_cierre)
  if (inicio < apertura || fin > cierre) {
    return {
      ok: false,
      motivo: `Queda fuera del horario de atención de ese día (${horario.hora_apertura.slice(0, 5)} a ${horario.hora_cierre.slice(0, 5)}).`,
    }
  }

  if (corte?.inicio && corte?.fin && !isla?.opera_en_corte) {
    if (inicio < horaAMinutos(corte.fin) && horaAMinutos(corte.inicio) < fin) {
      return { ok: false, motivo: `Ese horario cae en el corte de mediodía (${corte.inicio.slice(0, 5)} a ${corte.fin.slice(0, 5)}).` }
    }
  }

  const otrasEnLaIsla = otrasCitasDelDia.filter((c) => c.id !== cita.id && c.tipo_isla_id === cita.tipo_isla_id)
  for (let minuto = inicio; minuto < fin; minuto += PASO_BLOQUE_MINUTOS) {
    const ocupadas = citasEnBloque(otrasEnLaIsla, minutosAHora(minuto)).length
    if (isla && ocupadas >= isla.capacidad) {
      return { ok: false, motivo: `No hay cupo en ${isla.nombre} a las ${minutosAHora(minuto)} de ese día.` }
    }
  }
  return { ok: true, motivo: null }
}
