import { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { supabase } from '../supabaseClient'
import { invocarFuncion } from '../lib/invocarFuncion'

const ETIQUETA_AREA = {
  repuestos: 'Repuestos',
  lubricantes_insumos: 'Lubricantes e insumos',
  servicios_externos: 'Servicios externos',
}

function nombreCliente(cliente) {
  if (!cliente) return '—'
  return cliente.razon_social || [cliente.nombre, cliente.apellido].filter(Boolean).join(' ')
}

function TrabajoDetalle() {
  const { id } = useParams()
  const [trabajo, setTrabajo] = useState(null)
  const [tareas, setTareas] = useState([])
  const [detalle, setDetalle] = useState([])
  const [tecnicos, setTecnicos] = useState([])
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState(null)

  const [descripcionTarea, setDescripcionTarea] = useState('')
  const [tecnicoTarea, setTecnicoTarea] = useState('')
  const [guardandoTarea, setGuardandoTarea] = useState(false)

  const [areaDetalle, setAreaDetalle] = useState('repuestos')
  const [detalleTexto, setDetalleTexto] = useState('')
  const [cantidadDetalle, setCantidadDetalle] = useState('1')
  const [guardandoDetalle, setGuardandoDetalle] = useState(false)

  const [sincronizando, setSincronizando] = useState(false)
  const [resultadoSync, setResultadoSync] = useState(null)
  const [errorSync, setErrorSync] = useState(null)

  async function cargarTodo() {
    try {
      const [{ data: trabajoData, error: errorTrabajo }, { data: tareasData }, { data: detalleData }, { data: tecnicosData }] =
        await Promise.all([
          supabase
            .from('trabajos_taller')
            .select('id, numero_ot, tipo_ingreso, estado, categoria_servicio, clickup_task_id, clientes(nombre, apellido, razon_social), vehiculos(patente, marca, modelo, anio)')
            .eq('id', id)
            .maybeSingle(),
          supabase
            .from('tareas_taller')
            .select('id, descripcion, estado, tecnico_id, clickup_asignado_nombre, usuarios(nombre_completo)')
            .eq('trabajo_id', id)
            .order('orden'),
          supabase
            .from('ot_detalle')
            .select('id, area, detalle, cantidad, verificado')
            .eq('trabajo_id', id)
            .neq('area', 'mano_obra')
            .order('creado_en'),
          supabase.from('usuarios').select('id, nombre_completo').eq('rol', 'tecnico').eq('activo', true),
        ])

      if (errorTrabajo) {
        setError(errorTrabajo.message)
      } else {
        setTrabajo(trabajoData)
      }
      setTareas(tareasData || [])
      setDetalle(detalleData || [])
      setTecnicos(tecnicosData || [])
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setCargando(false)
    }
  }

  useEffect(() => {
    cargarTodo()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [id])

  async function agregarTarea(evento) {
    evento.preventDefault()
    setGuardandoTarea(true)
    try {
      const { error: errorInsercion } = await supabase.from('tareas_taller').insert({
        trabajo_id: id,
        descripcion: descripcionTarea,
        tecnico_id: tecnicoTarea || null,
        orden: tareas.length,
      })
      if (errorInsercion) {
        setError(errorInsercion.message)
        return
      }
      setDescripcionTarea('')
      setTecnicoTarea('')
      await cargarTodo()
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setGuardandoTarea(false)
    }
  }

  async function agregarDetalle(evento) {
    evento.preventDefault()
    setGuardandoDetalle(true)
    try {
      const { error: errorInsercion } = await supabase.from('ot_detalle').insert({
        trabajo_id: id,
        area: areaDetalle,
        detalle: detalleTexto,
        cantidad: Number(cantidadDetalle) || 1,
      })
      if (errorInsercion) {
        setError(errorInsercion.message)
        return
      }
      setDetalleTexto('')
      setCantidadDetalle('1')
      await cargarTodo()
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setGuardandoDetalle(false)
    }
  }

  async function sincronizarConClickUp() {
    setSincronizando(true)
    setErrorSync(null)
    setResultadoSync(null)
    try {
      const resultado = await invocarFuncion('clickup-sincronizar', { body: { trabajo_id: id } })
      setResultadoSync(resultado)
      await cargarTodo()
    } catch (excepcion) {
      setErrorSync(excepcion.message)
    } finally {
      setSincronizando(false)
    }
  }

  if (cargando) return <div className="p-6 text-slate-500">Cargando…</div>
  if (!trabajo) return <div className="p-6 text-slate-500">No se encontró el trabajo.</div>

  return (
    <div className="p-6">
      <div className="mb-4 flex items-start justify-between">
        <div>
          <h1 className="text-xl font-semibold text-slate-900">
            OT {trabajo.numero_ot} — {trabajo.vehiculos?.patente}
          </h1>
          <p className="text-sm text-slate-500">
            {trabajo.vehiculos?.marca} {trabajo.vehiculos?.modelo} {trabajo.vehiculos?.anio || ''} ·{' '}
            {nombreCliente(trabajo.clientes)} · Estado: {trabajo.estado}
          </p>
        </div>
        <div className="text-right">
          <button
            type="button"
            onClick={sincronizarConClickUp}
            disabled={sincronizando}
            className="rounded bg-slate-900 px-4 py-2 text-sm font-medium text-white hover:bg-slate-800 disabled:opacity-50"
          >
            {sincronizando ? 'Sincronizando…' : 'Sincronizar con ClickUp'}
          </button>
          {trabajo.clickup_task_id && (
            <p className="mt-1 text-xs text-slate-400">Tarjeta ya creada en ClickUp</p>
          )}
        </div>
      </div>

      {error && <p className="mb-4 text-sm text-red-600">{error}</p>}
      {errorSync && <p className="mb-4 text-sm text-red-600">Error al sincronizar: {errorSync}</p>}
      {resultadoSync && (
        <div className="mb-4 rounded border border-green-300 bg-green-50 p-3 text-sm text-green-900">
          Sincronizado: {resultadoSync.tareas_sincronizadas} tarea(s), {resultadoSync.items_sincronizados} ítem(s) de
          control.
          {resultadoSync.errores?.length > 0 && (
            <ul className="mt-2 list-disc pl-5 text-amber-800">
              {resultadoSync.errores.map((e, indice) => (
                <li key={indice}>
                  {e.operacion}: {e.mensaje}
                </li>
              ))}
            </ul>
          )}
        </div>
      )}

      <div className="grid max-w-4xl grid-cols-1 gap-6 md:grid-cols-2">
        <section>
          <h2 className="mb-2 text-lg font-semibold text-slate-900">Mano de obra</h2>
          <ul className="mb-3 divide-y divide-slate-100 rounded border border-slate-200 bg-white">
            {tareas.map((tarea) => (
              <li key={tarea.id} className="px-3 py-2 text-sm">
                <p className="text-slate-800">{tarea.descripcion}</p>
                <p className="text-xs text-slate-500">
                  {tarea.usuarios?.nombre_completo || tarea.clickup_asignado_nombre || 'Sin asignar'} · {tarea.estado}
                </p>
              </li>
            ))}
            {tareas.length === 0 && <li className="px-3 py-3 text-sm text-slate-400">Sin tareas todavía.</li>}
          </ul>
          <form onSubmit={agregarTarea} className="rounded border border-slate-200 bg-white p-3">
            <input
              required
              value={descripcionTarea}
              onChange={(evento) => setDescripcionTarea(evento.target.value)}
              placeholder="Ej. Cambio de pastillas de freno delanteras"
              className="mb-2 w-full rounded border border-slate-300 px-3 py-2 text-sm"
            />
            <select
              value={tecnicoTarea}
              onChange={(evento) => setTecnicoTarea(evento.target.value)}
              className="mb-2 w-full rounded border border-slate-300 px-3 py-2 text-sm"
            >
              <option value="">Sin asignar todavía</option>
              {tecnicos.map((tecnico) => (
                <option key={tecnico.id} value={tecnico.id}>
                  {tecnico.nombre_completo}
                </option>
              ))}
            </select>
            <button
              type="submit"
              disabled={guardandoTarea}
              className="rounded bg-slate-900 px-3 py-1.5 text-sm font-medium text-white hover:bg-slate-800 disabled:opacity-50"
            >
              Agregar tarea
            </button>
          </form>
        </section>

        <section>
          <h2 className="mb-2 text-lg font-semibold text-slate-900">Repuestos, insumos y servicios externos</h2>
          <ul className="mb-3 divide-y divide-slate-100 rounded border border-slate-200 bg-white">
            {detalle.map((item) => (
              <li key={item.id} className="flex items-center justify-between px-3 py-2 text-sm">
                <span className="text-slate-800">
                  {item.detalle} <span className="text-slate-400">× {item.cantidad}</span>
                </span>
                <span className={item.verificado ? 'text-green-600' : 'text-slate-400'}>
                  {item.verificado ? 'Verificado' : ETIQUETA_AREA[item.area]}
                </span>
              </li>
            ))}
            {detalle.length === 0 && <li className="px-3 py-3 text-sm text-slate-400">Sin ítems todavía.</li>}
          </ul>
          <form onSubmit={agregarDetalle} className="rounded border border-slate-200 bg-white p-3">
            <select
              value={areaDetalle}
              onChange={(evento) => setAreaDetalle(evento.target.value)}
              className="mb-2 w-full rounded border border-slate-300 px-3 py-2 text-sm"
            >
              {Object.entries(ETIQUETA_AREA).map(([valor, etiqueta]) => (
                <option key={valor} value={valor}>
                  {etiqueta}
                </option>
              ))}
            </select>
            <div className="mb-2 flex gap-2">
              <input
                required
                value={detalleTexto}
                onChange={(evento) => setDetalleTexto(evento.target.value)}
                placeholder="Ej. Filtro de aceite"
                className="w-full rounded border border-slate-300 px-3 py-2 text-sm"
              />
              <input
                type="number"
                min="1"
                value={cantidadDetalle}
                onChange={(evento) => setCantidadDetalle(evento.target.value)}
                className="w-20 rounded border border-slate-300 px-3 py-2 text-sm"
              />
            </div>
            <button
              type="submit"
              disabled={guardandoDetalle}
              className="rounded bg-slate-900 px-3 py-1.5 text-sm font-medium text-white hover:bg-slate-800 disabled:opacity-50"
            >
              Agregar ítem
            </button>
          </form>
        </section>
      </div>
    </div>
  )
}

export default TrabajoDetalle
