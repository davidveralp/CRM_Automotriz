import { useCallback, useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { supabase } from '../supabaseClient'
import { useAuth } from '../context/AuthContext'

const ETIQUETA_ESTADO = {
  borrador: 'Borrador',
  enviado: 'Enviado · esperando respuesta',
  aceptado: 'Aceptado',
  parcial: 'Aceptado parcial',
  rechazado: 'Rechazado',
  anulado: 'Anulado',
}

const ETIQUETA_AREA = {
  repuestos: 'Repuestos',
  lubricantes_insumos: 'Lubricantes y Otros Insumos',
  servicios_externos: 'Servicios Externos',
  mano_obra: 'Mano de Obra',
}

const AREAS_ORDEN = ['repuestos', 'lubricantes_insumos', 'servicios_externos', 'mano_obra']

function nombreCliente(cliente) {
  if (!cliente) return ''
  return cliente.razon_social || [cliente.nombre, cliente.apellido].filter(Boolean).join(' ')
}

function formatoNumero(numero) {
  if (numero === null || numero === undefined) return ''
  return Math.round(numero).toLocaleString('es-CL')
}

function formatoFecha(fechaIso) {
  if (!fechaIso) return null
  const fecha = new Date(fechaIso)
  return `${String(fecha.getDate()).padStart(2, '0')}-${String(fecha.getMonth() + 1).padStart(2, '0')}-${fecha.getFullYear()}`
}

function PresupuestoDetalle() {
  const { id } = useParams()
  const { usuario } = useAuth()

  const [presupuesto, setPresupuesto] = useState(null)
  const [trabajo, setTrabajo] = useState(null)
  const [clienteSolicita, setClienteSolicita] = useState('')
  const [items, setItems] = useState([])
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState(null)
  const [actualizando, setActualizando] = useState(false)

  const cargar = useCallback(async () => {
    setCargando(true)
    setError(null)
    try {
      const { data: presupuestoData, error: errorPresupuesto } = await supabase
        .from('presupuestos_taller')
        .select('id, correlativo, estado, creado_en, fecha_envio, fecha_respuesta, notas, trabajo_id')
        .eq('id', id)
        .maybeSingle()

      if (errorPresupuesto) {
        setError(errorPresupuesto.message)
        return
      }
      if (!presupuestoData) {
        setError('Presupuesto no encontrado.')
        return
      }
      setPresupuesto(presupuestoData)

      const [{ data: trabajoData, error: errorTrabajo }, { data: inspeccionData }, { data: itemsData, error: errorItems }] =
        await Promise.all([
          supabase
            .from('trabajos_taller')
            .select(
              'numero_ot, clientes(nombre, apellido, razon_social, rut, telefono_norm), vehiculos(patente, marca, modelo, anio, color)'
            )
            .eq('id', presupuestoData.trabajo_id)
            .maybeSingle(),
          supabase.from('inspecciones_ingreso').select('cliente_solicita').eq('trabajo_id', presupuestoData.trabajo_id).maybeSingle(),
          supabase
            .from('ot_detalle_con_permiso')
            .select('id, area, codigo, detalle, cantidad, precio_unitario, total_linea')
            .eq('presupuesto_id', id)
            .order('creado_en'),
        ])

      if (errorTrabajo) {
        setError(errorTrabajo.message)
        return
      }
      if (errorItems) {
        setError(errorItems.message)
        return
      }

      setTrabajo(trabajoData)
      setClienteSolicita(inspeccionData?.cliente_solicita || '')
      setItems(itemsData || [])
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setCargando(false)
    }
  }, [id])

  useEffect(() => {
    cargar()
  }, [cargar])

  async function cambiarEstado(nuevoEstado) {
    setActualizando(true)
    setError(null)
    try {
      const payload = { estado: nuevoEstado }
      if (['aceptado', 'parcial', 'rechazado'].includes(nuevoEstado)) {
        payload.fecha_respuesta = new Date().toISOString()
      }
      const { error: errorUpdate } = await supabase.from('presupuestos_taller').update(payload).eq('id', id)
      if (errorUpdate) {
        setError(errorUpdate.message)
        return
      }
      await cargar()
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setActualizando(false)
    }
  }

  if (cargando) return <div className="p-6 text-slate-500">Cargando…</div>
  if (error && !presupuesto) return <div className="p-6 text-red-600">{error}</div>
  if (!presupuesto) return null

  const empresa = usuario?.empresas
  const itemsPorArea = items.reduce((acumulado, item) => {
    if (!acumulado[item.area]) acumulado[item.area] = []
    acumulado[item.area].push(item)
    return acumulado
  }, {})
  const total = items.reduce((acumulado, item) => acumulado + (item.total_linea || 0), 0)
  const neto = Math.round(total / 1.19)
  const iva = total - neto

  const telefonoCliente = trabajo?.clientes?.telefono_norm
  const linkWhatsapp = telefonoCliente
    ? `https://wa.me/${telefonoCliente.replace('+', '')}?text=${encodeURIComponent(
        [
          `Hola ${nombreCliente(trabajo?.clientes)}, te compartimos el presupuesto ${presupuesto.correlativo} para tu ${trabajo?.vehiculos?.marca} ${trabajo?.vehiculos?.modelo} (${trabajo?.vehiculos?.patente}):`,
          '',
          ...items.map((item) => `- ${item.detalle}: $${formatoNumero(item.total_linea)}`),
          '',
          `Total: $${formatoNumero(total)}`,
          '',
          'Quedamos atentos a tus consultas.',
        ].join('\n')
      )}`
    : null

  return (
    <div className="p-6">
      <div className="mb-4 flex flex-wrap items-center gap-2 print:hidden">
        <button
          type="button"
          onClick={() => window.print()}
          className="rounded bg-slate-900 px-3 py-2 text-sm font-medium text-white hover:bg-slate-800"
        >
          Imprimir / guardar como PDF
        </button>
        {linkWhatsapp ? (
          <a
            href={linkWhatsapp}
            target="_blank"
            rel="noreferrer"
            className="rounded bg-green-600 px-3 py-2 text-sm font-medium text-white hover:bg-green-700"
          >
            Enviar por WhatsApp
          </a>
        ) : (
          <span className="rounded border border-amber-300 bg-amber-50 px-3 py-2 text-sm text-amber-800">
            El cliente no tiene teléfono registrado
          </span>
        )}
        <Link
          to={`/trabajos/${presupuesto.trabajo_id}`}
          className="rounded border border-slate-300 px-3 py-2 text-sm text-slate-700 hover:bg-slate-100"
        >
          Ver OT
        </Link>
        <Link to="/presupuestos" className="rounded border border-slate-300 px-3 py-2 text-sm text-slate-700 hover:bg-slate-100">
          Volver a Presupuestos
        </Link>

        <span className="ml-2 rounded bg-slate-100 px-3 py-1 text-sm font-medium text-slate-700">
          {ETIQUETA_ESTADO[presupuesto.estado] || presupuesto.estado}
        </span>

        {presupuesto.estado === 'enviado' && (
          <>
            <button
              type="button"
              disabled={actualizando}
              onClick={() => cambiarEstado('aceptado')}
              className="rounded border border-green-300 bg-green-50 px-3 py-2 text-sm text-green-800 hover:bg-green-100 disabled:opacity-50"
            >
              Marcar aceptado
            </button>
            <button
              type="button"
              disabled={actualizando}
              onClick={() => cambiarEstado('parcial')}
              className="rounded border border-blue-300 bg-blue-50 px-3 py-2 text-sm text-blue-800 hover:bg-blue-100 disabled:opacity-50"
            >
              Aceptado parcial
            </button>
            <button
              type="button"
              disabled={actualizando}
              onClick={() => cambiarEstado('rechazado')}
              className="rounded border border-red-300 bg-red-50 px-3 py-2 text-sm text-red-800 hover:bg-red-100 disabled:opacity-50"
            >
              Marcar rechazado
            </button>
            <button
              type="button"
              disabled={actualizando}
              onClick={() => cambiarEstado('anulado')}
              className="rounded border border-slate-300 px-3 py-2 text-sm text-slate-600 hover:bg-slate-100 disabled:opacity-50"
            >
              Anular
            </button>
          </>
        )}
        {['aceptado', 'parcial', 'rechazado'].includes(presupuesto.estado) && (
          <button
            type="button"
            disabled={actualizando}
            onClick={() => cambiarEstado('enviado')}
            className="rounded border border-slate-300 px-3 py-2 text-sm text-slate-600 hover:bg-slate-100 disabled:opacity-50"
          >
            Revertir a &quot;enviado&quot;
          </button>
        )}
      </div>

      {error && <p className="mb-4 text-sm text-red-600 print:hidden">{error}</p>}

      {(presupuesto.fecha_envio || presupuesto.fecha_respuesta) && (
        <p className="mb-3 text-xs text-slate-500 print:hidden">
          {presupuesto.fecha_envio && `Enviado: ${formatoFecha(presupuesto.fecha_envio)}`}
          {presupuesto.fecha_respuesta && ` · Respondido: ${formatoFecha(presupuesto.fecha_respuesta)}`}
        </p>
      )}

      <div className="max-w-3xl rounded border border-slate-200 bg-white p-6 text-sm text-slate-900 print:border-0 print:p-0">
        <div className="mb-2 flex items-start justify-between border-b border-slate-800 pb-2">
          <div>
            <p className="font-bold uppercase">{empresa?.nombre}</p>
            <p>{empresa?.direccion}</p>
            <p>{empresa?.correo}</p>
            <p>{empresa?.telefono}</p>
          </div>
          <div className="text-right">
            <p className="font-bold">PRESUPUESTO N° {presupuesto.correlativo}</p>
            <p className="font-bold">FECHA: {formatoFecha(presupuesto.creado_en)}</p>
            <p className="mt-1 text-xs">Página: 1</p>
          </div>
        </div>

        <div className="mb-3 space-y-0.5 border-b border-slate-300 pb-3">
          <div className="flex justify-between">
            <p>Patente: {trabajo?.vehiculos?.patente}</p>
            <p>R.U.T.: {trabajo?.clientes?.rut || ''}</p>
          </div>
          <div className="flex justify-between">
            <p>
              Nombre Cliente: {nombreCliente(trabajo?.clientes)} &nbsp;&nbsp; Color: {trabajo?.vehiculos?.color || ''}
            </p>
            <p>Año: {trabajo?.vehiculos?.anio || ''}</p>
          </div>
          <p>
            Marca: {trabajo?.vehiculos?.marca} &nbsp;&nbsp; Modelo: {trabajo?.vehiculos?.modelo}
          </p>
        </div>

        <div className="mb-3 border-b border-slate-300 pb-3">
          <p className="font-bold">Cliente Solicita:</p>
          <p className="whitespace-pre-line">{clienteSolicita || 'Presupuesto creado sin solicitud.'}</p>
        </div>

        {AREAS_ORDEN.filter((area) => itemsPorArea[area]?.length).map((area) => {
          const itemsArea = itemsPorArea[area]
          const subtotal = itemsArea.reduce((acumulado, item) => acumulado + (item.total_linea || 0), 0)
          const esManoObra = area === 'mano_obra'
          return (
            <div key={area} className="mb-3">
              <p className="font-bold">{ETIQUETA_AREA[area]}</p>
              <table className="w-full text-xs">
                <thead>
                  <tr className="border-b border-slate-400 text-slate-600">
                    {!esManoObra && <th className="py-1 text-left">CÓDIGO</th>}
                    <th className="py-1 text-left">DETALLE</th>
                    {!esManoObra && <th className="py-1 text-right">CANTIDAD</th>}
                    {!esManoObra && <th className="py-1 text-right">PRECIO</th>}
                    <th className="py-1 text-right">TOTAL</th>
                  </tr>
                </thead>
                <tbody>
                  {itemsArea.map((item) => (
                    <tr key={item.id}>
                      {!esManoObra && <td className="py-0.5">{item.codigo || ''}</td>}
                      <td className="py-0.5">{item.detalle}</td>
                      {!esManoObra && <td className="py-0.5 text-right">{item.cantidad}</td>}
                      {!esManoObra && <td className="py-0.5 text-right">{formatoNumero(item.precio_unitario)}</td>}
                      <td className="py-0.5 text-right">{formatoNumero(item.total_linea)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
              <p className="text-right text-xs font-bold">
                Subtotal {ETIQUETA_AREA[area]}: {formatoNumero(subtotal)}
              </p>
            </div>
          )
        })}

        {items.length === 0 && <p className="mb-3 text-slate-400">Sin ítems vinculados a este presupuesto.</p>}

        <div className="mt-2 text-right text-sm">
          <p>NETO: {formatoNumero(neto)}</p>
          <p>I.V.A.: {formatoNumero(iva)}</p>
          <p className="font-bold">TOTAL: {formatoNumero(total)}</p>
        </div>
      </div>
    </div>
  )
}

export default PresupuestoDetalle
