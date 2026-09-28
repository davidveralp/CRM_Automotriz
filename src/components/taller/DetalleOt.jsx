import { useEffect, useState } from 'react'
import { supabase } from '../../supabaseClient'
import { invocarFuncion } from '../../lib/invocarFuncion'
import { formatearPatente } from '../../lib/patente'
import { nombreCliente } from '../../lib/plano'
import { NOMBRE_CHECKLIST_POR_AREA, PRIORIDADES, iniciales } from '../../lib/tallerReglas'

function uno(valor) {
  return Array.isArray(valor) ? valor[0] : valor
}

const ETIQUETA_TIPO_SERVICIO = {
  taller_mecanico: 'Mecánica',
  servicio_rapido: 'Servicio Rápido',
  dyp: 'DyP',
}

const AREAS = ['repuestos', 'lubricantes_insumos', 'servicios_externos']

const ZONA = 'America/Santiago'
function fechaHora(iso) {
  if (!iso) return null
  return new Intl.DateTimeFormat('es-CL', { timeZone: ZONA, day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' }).format(
    new Date(iso)
  )
}

// Detalle de una OT al abrir su tarjeta en el Kanban -parecido a como se ve
// la tarjeta en ClickUp-. Casi todo sale de lo que ya está sincronizado en la
// base (subtareas, checklists, campos); solo la descripción y la fecha de
// inicio se traen en vivo de ClickUp al abrir (acción "detalle" de
// clickup-kanban), porque nadie las copia a la base en ningún otro momento.
function DetalleOt({ trabajoId, nombreTecnico, onCerrar }) {
  const [trabajo, setTrabajo] = useState(null)
  const [subtareas, setSubtareas] = useState([])
  const [items, setItems] = useState([])
  const [clickup, setClickup] = useState(null)
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    let vigente = true
    async function cargar() {
      setCargando(true)
      setError(null)
      try {
        const [respTrabajo, respTareas, respItems] = await Promise.all([
          supabase
            .from('trabajos_taller')
            .select(
              'id, numero_ot, kilometraje_ingreso, categoria_servicio, clickup_estado_actual, clickup_prioridad, clickup_fecha_programada, clickup_fecha_con_hora, clickup_descripcion, clickup_fecha_inicio, vehiculos(patente, marca, modelo), clientes(tipo, nombre, apellido, razon_social, telefono)'
            )
            .eq('id', trabajoId)
            .single(),
          supabase
            .from('tareas_taller')
            .select('id, descripcion, estado, completada, tecnico_id, clickup_asignado_nombre, observaciones_tecnico')
            .eq('trabajo_id', trabajoId)
            .order('orden'),
          supabase
            .from('ot_detalle')
            .select('id, area, detalle, cantidad, verificado')
            .eq('trabajo_id', trabajoId)
            .neq('area', 'mano_obra')
            .order('creado_en'),
        ])
        if (!vigente) return
        if (respTrabajo.error) throw respTrabajo.error
        if (respTareas.error) throw respTareas.error
        if (respItems.error) throw respItems.error
        setTrabajo(respTrabajo.data)
        setSubtareas(respTareas.data || [])
        setItems(respItems.data || [])

        // Descripción y fecha de inicio: en vivo desde ClickUp (no se guardan en
        // ningún otro flujo). Si falla, el resto del detalle igual se muestra.
        try {
          const detalleClickup = await invocarFuncion('clickup-kanban', { body: { accion: 'detalle', trabajo_id: trabajoId } })
          if (vigente) setClickup(detalleClickup)
        } catch (excepcionClickup) {
          if (vigente) setClickup({ error: excepcionClickup.message })
        }
      } catch (excepcion) {
        if (vigente) setError(excepcion.message)
      } finally {
        if (vigente) setCargando(false)
      }
    }
    cargar()
    return () => {
      vigente = false
    }
  }, [trabajoId])

  const vehiculo = trabajo ? uno(trabajo.vehiculos) : null
  const cliente = trabajo ? uno(trabajo.clientes) : null
  const asignados = [...new Set(subtareas.map((t) => (t.tecnico_id ? nombreTecnico(t.tecnico_id) : t.clickup_asignado_nombre)).filter(Boolean))]
  const total = subtareas.length
  const hechas = subtareas.filter((t) => t.completada).length
  const progreso = total === 0 ? 0 : Math.round((hechas / total) * 100)

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center overflow-y-auto bg-black/40 p-4" onClick={onCerrar}>
      <div
        className="my-8 w-full max-w-2xl rounded-lg bg-white shadow-xl"
        onClick={(evento) => evento.stopPropagation()}
      >
        {cargando ? (
          <p className="p-6 text-slate-500">Cargando…</p>
        ) : error ? (
          <div className="p-6">
            <p className="rounded border border-red-200 bg-red-50 px-3 py-2 text-sm text-red-700">{error}</p>
            <button type="button" onClick={onCerrar} className="btn-ghost mt-3">
              Cerrar
            </button>
          </div>
        ) : (
          <>
            <div className="flex items-start justify-between gap-2 border-b border-slate-200 p-4">
              <div className="min-w-0">
                <h2 className="text-lg font-semibold text-slate-900">
                  {formatearPatente(vehiculo?.patente)} {vehiculo ? `${vehiculo.marca} ${vehiculo.modelo}` : ''}
                  {trabajo.kilometraje_ingreso ? ` · ${trabajo.kilometraje_ingreso.toLocaleString('es-CL')} km` : ''} · OT {trabajo.numero_ot}
                </h2>
                <p className="mt-0.5 text-sm text-slate-500">
                  {nombreCliente(cliente)}
                  {cliente?.telefono ? ` · ${cliente.telefono}` : ''}
                </p>
              </div>
              <button type="button" onClick={onCerrar} className="shrink-0 rounded p-1 text-slate-400 hover:bg-slate-100 hover:text-slate-700" aria-label="Cerrar">
                ✕
              </button>
            </div>

            <div className="grid grid-cols-1 gap-4 p-4 sm:grid-cols-2">
              <div>
                <p className="label">Estado</p>
                <p className="text-sm font-medium text-slate-800">{trabajo.clickup_estado_actual || '—'}</p>
              </div>
              <div>
                <p className="label">Personas asignadas</p>
                {asignados.length > 0 ? (
                  <div className="mt-0.5 flex flex-wrap gap-1">
                    {asignados.map((nombre) => (
                      <span key={nombre} className="flex items-center gap-1 rounded-full bg-deep/10 px-2 py-0.5 text-xs font-medium text-deep">
                        <span className="flex h-4 w-4 items-center justify-center rounded-full bg-deep/20 text-[9px]">{iniciales(nombre)}</span>
                        {nombre}
                      </span>
                    ))}
                  </div>
                ) : (
                  <p className="text-sm text-slate-400">Sin asignar</p>
                )}
              </div>
              <div>
                <p className="label">Fechas</p>
                <p className="text-sm text-slate-700">
                  {fechaHora(clickup?.fecha_inicio) || 'Sin inicio'} → {trabajo.clickup_fecha_programada ? fechaHora(trabajo.clickup_fecha_programada) : 'Sin fecha límite'}
                </p>
              </div>
              <div>
                <p className="label">Prioridad</p>
                <p className="text-sm text-slate-700">{PRIORIDADES[trabajo.clickup_prioridad]?.etiqueta || '—'}</p>
              </div>
              <div>
                <p className="label">N.º OT</p>
                <p className="text-sm text-slate-700">{trabajo.numero_ot}</p>
              </div>
              <div>
                <p className="label">Patente</p>
                <p className="text-sm text-slate-700">{formatearPatente(vehiculo?.patente) || '—'}</p>
              </div>
              <div>
                <p className="label">Tipo de servicio</p>
                <p className="text-sm text-slate-700">{ETIQUETA_TIPO_SERVICIO[trabajo.categoria_servicio] || '—'}</p>
              </div>
              <div>
                <p className="label">Progreso</p>
                <div className="mt-1 h-2 rounded bg-slate-100">
                  <div className="h-2 rounded bg-emerald-500" style={{ width: `${progreso}%` }} />
                </div>
                <p className="mt-0.5 text-xs text-slate-500">
                  {hechas}/{total} subtareas · {progreso}%
                </p>
              </div>
            </div>

            <div className="border-t border-slate-200 p-4">
              <p className="label mb-1">Descripción</p>
              {clickup?.error ? (
                <p className="text-sm text-amber-700">No se pudo traer la descripción de ClickUp: {clickup.error}</p>
              ) : clickup?.descripcion ? (
                <p className="whitespace-pre-line text-sm text-slate-700">{clickup.descripcion}</p>
              ) : (
                <p className="text-sm text-slate-400">Sin descripción en ClickUp.</p>
              )}
            </div>

            {subtareas.length > 0 && (
              <div className="border-t border-slate-200 p-4">
                <p className="label mb-2">Subtareas ({hechas}/{total} cerradas)</p>
                <div className="overflow-x-auto rounded border border-slate-200">
                  <table className="w-full text-left text-xs">
                    <thead className="bg-slate-50 text-slate-500">
                      <tr>
                        <th className="px-2 py-1.5"></th>
                        <th className="px-2 py-1.5">Nombre</th>
                        <th className="px-2 py-1.5">Observaciones</th>
                        <th className="px-2 py-1.5">Persona asignada</th>
                      </tr>
                    </thead>
                    <tbody>
                      {subtareas.map((t) => (
                        <tr key={t.id} className="border-t border-slate-100">
                          <td className="px-2 py-1.5">
                            <span className={t.completada ? 'text-emerald-600' : 'text-slate-300'}>{t.completada ? '✓' : '○'}</span>
                          </td>
                          <td className={`px-2 py-1.5 ${t.completada ? 'text-slate-400 line-through' : 'text-slate-700'}`}>{t.descripcion}</td>
                          <td className="px-2 py-1.5 text-slate-500">{t.observaciones_tecnico || '—'}</td>
                          <td className="px-2 py-1.5 text-slate-500">
                            {(t.tecnico_id ? nombreTecnico(t.tecnico_id) : t.clickup_asignado_nombre) || '—'}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            )}

            {AREAS.map((area) => {
              const filas = items.filter((i) => i.area === area)
              if (filas.length === 0) return null
              return (
                <div key={area} className="border-t border-slate-200 p-4">
                  <p className="label mb-2">
                    {NOMBRE_CHECKLIST_POR_AREA[area]} ({filas.filter((i) => i.verificado).length}/{filas.length})
                  </p>
                  <ul className="space-y-1">
                    {filas.map((item) => (
                      <li key={item.id} className="flex items-center gap-2 text-sm">
                        <span className={item.verificado ? 'text-emerald-600' : 'text-slate-300'}>{item.verificado ? '✓' : '○'}</span>
                        <span className={item.verificado ? 'text-slate-400 line-through' : 'text-slate-700'}>
                          {item.detalle}
                          {item.cantidad > 1 ? ` (x${item.cantidad})` : ''}
                        </span>
                      </li>
                    ))}
                  </ul>
                </div>
              )
            })}
          </>
        )}
      </div>
    </div>
  )
}

export default DetalleOt
