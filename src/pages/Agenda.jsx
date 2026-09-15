import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../supabaseClient'
import { useAuth } from '../context/AuthContext'

const ETIQUETA_ESTADO = {
  agendada: 'Agendada',
  confirmada: 'Confirmada',
  completada: 'Completada',
  cancelada: 'Cancelada',
  no_asistio: 'No asistió',
}

const ESTADOS_QUE_OCUPAN_CUPO = ['agendada', 'confirmada']

// Pistas de duración típica por isla (solo ayuda visual al agendar, no se
// guarda como default en la base): una mantención de taller mecánico dura
// 1-2h de 8h disponibles, servicio rápido/alineación ~30 min, pintura no
// tiene duración definida -ocupa el cupo hasta el cierre del día-.
const PISTAS_DURACION = [
  { patron: /mecánico/i, texto: 'Duración típica: 60–120 min.' },
  { patron: /rápido/i, texto: 'Duración típica: 30 min.' },
  { patron: /alineación/i, texto: 'Duración típica: 30 min.' },
  { patron: /pintura/i, texto: 'Sin duración definida: deja el campo vacío, ocupa el cupo hasta el cierre del día.' },
]

function pistaDuracion(nombreIsla) {
  return PISTAS_DURACION.find((p) => p.patron.test(nombreIsla || ''))?.texto || null
}

function hoyISO() {
  return new Date().toISOString().slice(0, 10)
}

function horaAMinutos(hora) {
  const [h, m] = hora.split(':').map(Number)
  return h * 60 + m
}

// Pico de ocupación simultánea de una isla en el día -no un conteo plano de
// citas-: una cita sin duración (o sin hora) se trata como si ocupara el
// cupo hasta el cierre del día calendario, mismo criterio que la función SQL
// citas_cupos_disponibles.
function picoOcupacion(citasIsla) {
  const eventos = []
  citasIsla.forEach((c) => {
    const inicio = c.hora ? horaAMinutos(c.hora) : 0
    const fin = c.duracion_estimada_minutos != null ? inicio + c.duracion_estimada_minutos : 24 * 60
    eventos.push([inicio, 1], [fin, -1])
  })
  eventos.sort((a, b) => a[0] - b[0] || a[1] - b[1])
  let actual = 0
  let pico = 0
  for (const [, delta] of eventos) {
    actual += delta
    pico = Math.max(pico, actual)
  }
  return pico
}

function nombreVisible(cliente) {
  if (!cliente) return ''
  if (cliente.tipo === 'empresa') return cliente.razon_social || cliente.nombre
  return [cliente.nombre, cliente.apellido].filter(Boolean).join(' ')
}

function Agenda() {
  const { usuario } = useAuth()
  const [fecha, setFecha] = useState(hoyISO())
  const [tiposIsla, setTiposIsla] = useState([])
  const [citas, setCitas] = useState([])
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState(null)
  const [mostrarFormulario, setMostrarFormulario] = useState(false)

  async function cargar() {
    setCargando(true)
    setError(null)
    try {
      const [{ data: islas, error: errorIslas }, { data: citasDia, error: errorCitas }] = await Promise.all([
        supabase.from('tipos_isla').select('id, nombre, capacidad, orden').eq('activo', true).order('orden'),
        supabase
          .from('citas')
          .select(
            // trabajos_taller!citas_trabajo_id_fkey: desde el Bloque "ingreso
            // desde cita" (2026-09-15) trabajos_taller.cita_id agregó una
            // SEGUNDA relación entre estas dos tablas (la inversa de
            // citas.trabajo_id). PostgREST ya no puede adivinar sola cuál
            // usar para el embed -hay que nombrar la restricción a mano-.
            'id, tipo_isla_id, fecha, hora, duracion_estimada_minutos, descripcion, estado, clientes(id, tipo, nombre, apellido, razon_social, telefono), vehiculos(id, patente, marca, modelo), trabajo_id, trabajos_taller!citas_trabajo_id_fkey(numero_ot)'
          )
          .eq('fecha', fecha)
          .order('hora', { nullsFirst: true }),
      ])

      if (errorIslas) {
        setError(errorIslas.message)
        return
      }
      if (errorCitas) {
        setError(errorCitas.message)
        return
      }
      setTiposIsla(islas || [])
      setCitas(citasDia || [])
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setCargando(false)
    }
  }

  useEffect(() => {
    cargar()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [fecha])

  async function actualizarEstado(id, estado) {
    try {
      const { error: errorActualizar } = await supabase.from('citas').update({ estado }).eq('id', id)
      if (errorActualizar) {
        setError(errorActualizar.message)
        return
      }
      await cargar()
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    }
  }

  function picoDeIsla(tipoIslaId) {
    const citasIsla = citas.filter((c) => c.tipo_isla_id === tipoIslaId && ESTADOS_QUE_OCUPAN_CUPO.includes(c.estado))
    return picoOcupacion(citasIsla)
  }

  return (
    <div className="p-6">
      <div className="mb-4 flex items-center justify-between">
        <h1 className="text-xl font-semibold text-slate-900">Agenda</h1>
        <button
          type="button"
          onClick={() => setMostrarFormulario(true)}
          className="rounded bg-slate-900 px-3 py-2 text-sm font-medium text-white hover:bg-slate-800"
        >
          Nueva cita
        </button>
      </div>

      <div className="mb-4 flex items-center gap-2">
        <label className="text-sm font-medium text-slate-700">Fecha</label>
        <input
          type="date"
          value={fecha}
          onChange={(evento) => setFecha(evento.target.value)}
          className="rounded border border-slate-300 px-3 py-2 text-sm"
        />
      </div>

      {error && <p className="mb-4 text-sm text-red-600">{error}</p>}

      <div className="mb-6 grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-5">
        {tiposIsla.map((isla) => {
          const pico = picoDeIsla(isla.id)
          const sobrecupo = pico > isla.capacidad
          return (
            <div
              key={isla.id}
              className={`rounded border p-3 text-sm ${
                sobrecupo ? 'border-amber-300 bg-amber-50' : 'border-slate-200 bg-white'
              }`}
            >
              <p className="font-medium text-slate-800">{isla.nombre}</p>
              <p className={sobrecupo ? 'text-amber-700' : 'text-slate-500'}>
                {pico} / {isla.capacidad} en el peor momento del día
              </p>
            </div>
          )
        })}
      </div>

      <div className="overflow-x-auto rounded border border-slate-200 bg-white">
        <table className="w-full text-left text-sm">
          <thead className="bg-slate-50 text-slate-500">
            <tr>
              <th className="px-3 py-2">Hora</th>
              <th className="px-3 py-2">Isla</th>
              <th className="px-3 py-2">Cliente</th>
              <th className="px-3 py-2">Vehículo</th>
              <th className="px-3 py-2">Detalle</th>
              <th className="px-3 py-2">Estado</th>
              <th className="px-3 py-2"></th>
            </tr>
          </thead>
          <tbody>
            {!cargando &&
              citas.map((cita) => (
                <tr key={cita.id} className="border-t border-slate-100">
                  <td className="px-3 py-2 text-slate-600">
                    {cita.hora || '—'}
                    {cita.duracion_estimada_minutos && (
                      <span className="text-xs text-slate-400"> ({cita.duracion_estimada_minutos} min)</span>
                    )}
                  </td>
                  <td className="px-3 py-2 text-slate-600">
                    {tiposIsla.find((i) => i.id === cita.tipo_isla_id)?.nombre || '—'}
                  </td>
                  <td className="px-3 py-2 text-slate-800">
                    {nombreVisible(cita.clientes)}
                    <p className="text-xs text-slate-400">{cita.clientes?.telefono}</p>
                  </td>
                  <td className="px-3 py-2 text-slate-600">
                    {cita.vehiculos ? `${cita.vehiculos.patente} — ${cita.vehiculos.marca} ${cita.vehiculos.modelo}` : 'Sin definir'}
                  </td>
                  <td className="px-3 py-2 text-slate-600">{cita.descripcion || '—'}</td>
                  <td className="px-3 py-2">
                    <select
                      value={cita.estado}
                      onChange={(evento) => actualizarEstado(cita.id, evento.target.value)}
                      className="rounded border border-slate-300 px-2 py-1 text-xs"
                    >
                      {Object.entries(ETIQUETA_ESTADO).map(([valor, etiqueta]) => (
                        <option key={valor} value={valor}>
                          {etiqueta}
                        </option>
                      ))}
                    </select>
                  </td>
                  <td className="px-3 py-2">
                    {cita.trabajo_id && (
                      <Link
                        to={`/trabajos/${cita.trabajo_id}`}
                        className="text-xs text-slate-500 underline hover:text-slate-700"
                      >
                        OT {cita.trabajos_taller?.numero_ot}
                      </Link>
                    )}
                  </td>
                </tr>
              ))}
            {!cargando && citas.length === 0 && (
              <tr>
                <td colSpan={7} className="px-3 py-6 text-center text-slate-400">
                  Sin citas agendadas para este día.
                </td>
              </tr>
            )}
            {cargando && (
              <tr>
                <td colSpan={7} className="px-3 py-6 text-center text-slate-400">
                  Cargando…
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {mostrarFormulario && (
        <FormularioNuevaCita
          empresaId={usuario.empresa_id}
          usuarioId={usuario.id}
          tiposIsla={tiposIsla}
          fechaInicial={fecha}
          onCancelar={() => setMostrarFormulario(false)}
          onCreada={() => {
            setMostrarFormulario(false)
            cargar()
          }}
        />
      )}
    </div>
  )
}

function FormularioNuevaCita({ empresaId, usuarioId, tiposIsla, fechaInicial, onCancelar, onCreada }) {
  const [fecha, setFecha] = useState(fechaInicial)
  const [tipoIslaId, setTipoIslaId] = useState(tiposIsla[0]?.id || '')
  const [hora, setHora] = useState('')
  const [duracionMinutos, setDuracionMinutos] = useState('')
  const [descripcion, setDescripcion] = useState('')
  const [cupos, setCupos] = useState(null)

  const [terminoCliente, setTerminoCliente] = useState('')
  const [buscandoCliente, setBuscandoCliente] = useState(false)
  const [resultadosCliente, setResultadosCliente] = useState([])
  const [clienteSeleccionado, setClienteSeleccionado] = useState(null)
  const [creandoClienteNuevo, setCreandoClienteNuevo] = useState(false)
  const [nombreNuevo, setNombreNuevo] = useState('')
  const [apellidoNuevo, setApellidoNuevo] = useState('')
  const [telefonoNuevo, setTelefonoNuevo] = useState('')

  const [vehiculosCliente, setVehiculosCliente] = useState([])
  const [vehiculoId, setVehiculoId] = useState('')

  const [forzarSobrecupo, setForzarSobrecupo] = useState(false)
  const [guardando, setGuardando] = useState(false)
  const [error, setError] = useState(null)

  useEffect(() => {
    async function cargarCupos() {
      if (!tipoIslaId || !fecha) return
      try {
        const { data, error: errorCupos } = await supabase.rpc('citas_cupos_disponibles', {
          p_tipo_isla_id: tipoIslaId,
          p_fecha: fecha,
          p_hora: hora || null,
          p_duracion_minutos: duracionMinutos ? Number(duracionMinutos) : null,
        })
        if (!errorCupos) setCupos(data)
      } catch {
        // El cálculo de cupos es una ayuda visual, no bloquea el guardado.
      }
    }
    cargarCupos()
    setForzarSobrecupo(false)
  }, [tipoIslaId, fecha, hora, duracionMinutos])

  async function buscarCliente(evento) {
    evento.preventDefault()
    setBuscandoCliente(true)
    setError(null)
    try {
      const termino = terminoCliente.trim()
      const soloDigitos = termino.replace(/\D/g, '')
      let consulta = supabase
        .from('clientes')
        .select('id, tipo, nombre, apellido, razon_social, rut, telefono')
        .is('eliminado_en', null)
        .limit(10)

      const condiciones = [`nombre.ilike.%${termino}%`, `apellido.ilike.%${termino}%`, `razon_social.ilike.%${termino}%`]
      if (soloDigitos) {
        condiciones.push(`rut_norm.ilike.%${soloDigitos}%`)
        condiciones.push(`telefono_norm.ilike.%${soloDigitos}%`)
      }
      consulta = consulta.or(condiciones.join(','))

      const { data, error: errorConsulta } = await consulta
      if (errorConsulta) {
        setError(errorConsulta.message)
        return
      }
      setResultadosCliente(data || [])
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setBuscandoCliente(false)
    }
  }

  async function elegirCliente(cliente) {
    setClienteSeleccionado(cliente)
    setResultadosCliente([])
    setCreandoClienteNuevo(false)
    setVehiculoId('')
    try {
      const { data, error: errorVehiculos } = await supabase
        .from('clientes_vehiculos')
        .select('vehiculos(id, patente, marca, modelo)')
        .eq('cliente_id', cliente.id)
      if (!errorVehiculos) {
        setVehiculosCliente((data || []).map((v) => v.vehiculos).filter(Boolean))
      }
    } catch {
      // Sin vehículos vinculados no impide agendar; se completa al ingresar de verdad.
    }
  }

  async function crearClienteNuevo() {
    setError(null)
    setGuardando(true)
    try {
      const { data, error: errorInsercion } = await supabase
        .from('clientes')
        .insert({
          empresa_id: empresaId,
          tipo: 'persona',
          nombre: nombreNuevo,
          apellido: apellidoNuevo || null,
          telefono: telefonoNuevo || null,
        })
        .select()
        .single()

      if (errorInsercion) {
        setError(errorInsercion.message)
        return
      }
      await elegirCliente(data)
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setGuardando(false)
    }
  }

  async function manejarEnvio(evento) {
    evento.preventDefault()
    if (!clienteSeleccionado) return

    setGuardando(true)
    setError(null)
    try {
      const { error: errorInsercion } = await supabase.from('citas').insert({
        empresa_id: empresaId,
        tipo_isla_id: tipoIslaId,
        cliente_id: clienteSeleccionado.id,
        vehiculo_id: vehiculoId || null,
        fecha,
        hora: hora || null,
        duracion_estimada_minutos: duracionMinutos ? Number(duracionMinutos) : null,
        descripcion: descripcion || null,
        creado_por: usuarioId,
      })

      if (errorInsercion) {
        setError(errorInsercion.message)
        return
      }
      onCreada()
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setGuardando(false)
    }
  }

  const sinCupo = cupos !== null && cupos <= 0

  return (
    <div className="fixed inset-0 flex items-center justify-center overflow-y-auto bg-black/30 p-4">
      <form onSubmit={manejarEnvio} className="my-8 w-full max-w-lg rounded-lg bg-white p-6 shadow-lg">
        <h2 className="mb-4 text-lg font-semibold text-slate-900">Nueva cita</h2>

        <div className="mb-3">
          <label className="mb-1 block text-sm font-medium text-slate-700">Fecha</label>
          <input
            type="date"
            required
            value={fecha}
            onChange={(evento) => setFecha(evento.target.value)}
            className="w-full rounded border border-slate-300 px-3 py-2 text-sm"
          />
        </div>

        <div className="mb-3">
          <label className="mb-1 block text-sm font-medium text-slate-700">Isla</label>
          <select
            required
            value={tipoIslaId}
            onChange={(evento) => setTipoIslaId(evento.target.value)}
            className="w-full rounded border border-slate-300 px-3 py-2 text-sm"
          >
            {tiposIsla.map((isla) => (
              <option key={isla.id} value={isla.id}>
                {isla.nombre} (capacidad {isla.capacidad})
              </option>
            ))}
          </select>
        </div>

        <div className="mb-3 grid grid-cols-2 gap-3">
          <div>
            <label className="mb-1 block text-sm font-medium text-slate-700">Hora (opcional)</label>
            <input
              type="time"
              value={hora}
              onChange={(evento) => setHora(evento.target.value)}
              className="w-full rounded border border-slate-300 px-3 py-2 text-sm"
            />
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium text-slate-700">Duración en minutos (opcional)</label>
            <input
              type="number"
              min="1"
              value={duracionMinutos}
              onChange={(evento) => setDuracionMinutos(evento.target.value)}
              className="w-full rounded border border-slate-300 px-3 py-2 text-sm"
            />
          </div>
        </div>

        <div className="mb-3">
          {pistaDuracion(tiposIsla.find((i) => i.id === tipoIslaId)?.nombre) && (
            <p className="mb-1 text-xs text-slate-400">
              {pistaDuracion(tiposIsla.find((i) => i.id === tipoIslaId)?.nombre)}
            </p>
          )}
          {cupos !== null && (
            <p className={`text-xs ${sinCupo ? 'text-amber-700' : 'text-slate-500'}`}>
              {sinCupo
                ? `Sin cupos disponibles a esa hora (${cupos < 0 ? `${-cupos} sobre capacidad` : '0 disponibles'}).`
                : `${cupos} cupo(s) disponible(s) a esa hora.`}
            </p>
          )}
        </div>

        {sinCupo && (
          <label className="mb-3 flex items-center gap-2 rounded border border-amber-300 bg-amber-50 p-2 text-sm text-amber-900">
            <input type="checkbox" checked={forzarSobrecupo} onChange={(e) => setForzarSobrecupo(e.target.checked)} />
            Igual agendar (sobrecupo)
          </label>
        )}

        <div className="mb-3 border-t border-slate-100 pt-3">
          <label className="mb-1 block text-sm font-medium text-slate-700">Cliente</label>
          {clienteSeleccionado ? (
            <div className="flex items-center justify-between rounded border border-slate-200 bg-slate-50 px-3 py-2 text-sm">
              <span>{nombreVisible(clienteSeleccionado)}</span>
              <button
                type="button"
                onClick={() => {
                  setClienteSeleccionado(null)
                  setVehiculosCliente([])
                  setVehiculoId('')
                }}
                className="text-xs text-slate-500 underline hover:text-slate-700"
              >
                Cambiar
              </button>
            </div>
          ) : (
            <>
              <div className="mb-2 flex gap-2">
                <input
                  type="text"
                  value={terminoCliente}
                  onChange={(evento) => setTerminoCliente(evento.target.value)}
                  placeholder="Buscar por nombre, RUT o teléfono"
                  className="w-full rounded border border-slate-300 px-3 py-2 text-sm"
                />
                <button
                  type="button"
                  onClick={buscarCliente}
                  disabled={buscandoCliente}
                  className="rounded border border-slate-300 px-3 py-2 text-sm text-slate-700 hover:bg-slate-100"
                >
                  Buscar
                </button>
              </div>
              {resultadosCliente.length > 0 && (
                <ul className="mb-2 space-y-1 text-sm">
                  {resultadosCliente.map((cliente) => (
                    <li key={cliente.id}>
                      <button
                        type="button"
                        onClick={() => elegirCliente(cliente)}
                        className="text-slate-700 underline hover:text-slate-900"
                      >
                        {nombreVisible(cliente)} {cliente.telefono ? `· ${cliente.telefono}` : ''}
                      </button>
                    </li>
                  ))}
                </ul>
              )}
              {!creandoClienteNuevo ? (
                <button
                  type="button"
                  onClick={() => setCreandoClienteNuevo(true)}
                  className="text-sm text-slate-500 underline hover:text-slate-700"
                >
                  + Cliente nuevo
                </button>
              ) : (
                <div className="border-t border-slate-100 pt-2">
                  <div className="mb-2 grid grid-cols-2 gap-2">
                    <input
                      placeholder="Nombre"
                      value={nombreNuevo}
                      onChange={(evento) => setNombreNuevo(evento.target.value)}
                      className="rounded border border-slate-300 px-3 py-2 text-sm"
                    />
                    <input
                      placeholder="Apellido"
                      value={apellidoNuevo}
                      onChange={(evento) => setApellidoNuevo(evento.target.value)}
                      className="rounded border border-slate-300 px-3 py-2 text-sm"
                    />
                    <input
                      placeholder="Teléfono"
                      value={telefonoNuevo}
                      onChange={(evento) => setTelefonoNuevo(evento.target.value)}
                      className="col-span-2 rounded border border-slate-300 px-3 py-2 text-sm"
                    />
                  </div>
                  <button
                    type="button"
                    onClick={crearClienteNuevo}
                    disabled={!nombreNuevo || guardando}
                    className="rounded bg-slate-900 px-3 py-2 text-sm font-medium text-white hover:bg-slate-800 disabled:opacity-50"
                  >
                    Crear y continuar
                  </button>
                </div>
              )}
            </>
          )}
        </div>

        {clienteSeleccionado && vehiculosCliente.length > 0 && (
          <div className="mb-3">
            <label className="mb-1 block text-sm font-medium text-slate-700">Vehículo (opcional)</label>
            <select
              value={vehiculoId}
              onChange={(evento) => setVehiculoId(evento.target.value)}
              className="w-full rounded border border-slate-300 px-3 py-2 text-sm"
            >
              <option value="">Sin definir todavía</option>
              {vehiculosCliente.map((vehiculo) => (
                <option key={vehiculo.id} value={vehiculo.id}>
                  {vehiculo.patente} — {vehiculo.marca} {vehiculo.modelo}
                </option>
              ))}
            </select>
          </div>
        )}

        <div className="mb-4">
          <label className="mb-1 block text-sm font-medium text-slate-700">Detalle (opcional)</label>
          <textarea
            value={descripcion}
            onChange={(evento) => setDescripcion(evento.target.value)}
            rows={2}
            placeholder="Ej: cambio de aceite, ruido en freno delantero"
            className="w-full rounded border border-slate-300 px-3 py-2 text-sm"
          />
        </div>

        {error && <p className="mb-4 text-sm text-red-600">{error}</p>}

        <div className="flex justify-end gap-2">
          <button
            type="button"
            onClick={onCancelar}
            className="rounded border border-slate-300 px-3 py-2 text-sm text-slate-700 hover:bg-slate-100"
          >
            Cancelar
          </button>
          <button
            type="submit"
            disabled={guardando || !clienteSeleccionado || (sinCupo && !forzarSobrecupo)}
            className="rounded bg-slate-900 px-3 py-2 text-sm font-medium text-white hover:bg-slate-800 disabled:opacity-50"
          >
            {guardando ? 'Guardando…' : 'Agendar'}
          </button>
        </div>
      </form>
    </div>
  )
}

export default Agenda
