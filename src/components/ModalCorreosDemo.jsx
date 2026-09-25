import { useEffect, useState } from 'react'
import { supabase } from '../supabaseClient'
import { useAuth } from '../context/AuthContext'

// Solo en el tenant de demostración (empresas.es_demo): al entrar se piden el
// correo del cliente y el del asesor -pueden ser el mismo- para que quien
// prueba reciba de verdad los correos del sistema (encuesta de postventa al
// cliente, aviso de encuesta negativa al asesor). Ver 0040_demo_correos_de_prueba.sql.
//
// Se pregunta una vez por sesión del navegador. Los correos NO se precargan
// desde la base: el tenant es compartido y se filtraría el correo de la
// persona que probó antes.
const CLAVE_SESION = 'correosDemoResueltos'
export const EVENTO_ABRIR_CORREOS_DEMO = 'abrir-correos-demo'

function leerSesion() {
  try {
    return sessionStorage.getItem(CLAVE_SESION)
  } catch {
    return null
  }
}

function marcarSesion(valor) {
  try {
    sessionStorage.setItem(CLAVE_SESION, valor)
  } catch {
    // Sin sessionStorage (ventana privada): se volverá a preguntar, sin romper nada.
  }
}

function ModalCorreosDemo() {
  const { usuario } = useAuth()
  const esDemo = Boolean(usuario?.empresas?.es_demo)

  const [abierto, setAbierto] = useState(false)
  const [correoCliente, setCorreoCliente] = useState('')
  const [correoAsesor, setCorreoAsesor] = useState('')
  const [mismoCorreo, setMismoCorreo] = useState(true)
  const [guardando, setGuardando] = useState(false)
  const [error, setError] = useState(null)
  const [guardado, setGuardado] = useState(false)

  useEffect(() => {
    if (esDemo && !leerSesion()) setAbierto(true)
  }, [esDemo])

  useEffect(() => {
    if (!esDemo) return undefined
    const abrir = () => {
      setError(null)
      setGuardado(false)
      setAbierto(true)
    }
    window.addEventListener(EVENTO_ABRIR_CORREOS_DEMO, abrir)
    return () => window.removeEventListener(EVENTO_ABRIR_CORREOS_DEMO, abrir)
  }, [esDemo])

  if (!esDemo || !abierto) return null

  async function guardar(evento) {
    evento.preventDefault()
    setError(null)
    setGuardando(true)
    try {
      const { error: errorRpc } = await supabase.rpc('demo_guardar_correos', {
        p_correo_cliente: correoCliente,
        p_correo_asesor: mismoCorreo ? correoCliente : correoAsesor,
      })
      if (errorRpc) throw errorRpc
      marcarSesion('guardados')
      setGuardado(true)
    } catch (excepcion) {
      setError(excepcion.message || 'No se pudieron guardar los correos.')
    } finally {
      setGuardando(false)
    }
  }

  function omitir() {
    if (!leerSesion()) marcarSesion('omitido')
    setAbierto(false)
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-start justify-center overflow-y-auto bg-black/50 p-4"
      role="dialog"
      aria-modal="true"
      aria-labelledby="titulo-correos-demo"
    >
      <div className="my-8 w-full max-w-md rounded-xl bg-white p-6 shadow-xl">
        {guardado ? (
          <>
            <h2 id="titulo-correos-demo" className="text-lg font-semibold text-slate-900">
              Listo, correos guardados
            </h2>
            <p className="mt-2 text-sm text-slate-600">
              Para probarlos: en <strong>Oportunidades</strong> pulsa &quot;Enviar encuestas de postventa pendientes&quot;
              (llegará al correo del cliente). Abre el enlace del correo y responde la encuesta con 1 o 2 estrellas
              en alguna pregunta: el aviso de encuesta negativa llegará al correo del asesor.
            </p>
            <p className="mt-2 text-xs text-slate-500">
              Puedes cambiarlos cuando quieras desde &quot;Correos de prueba&quot; en el menú lateral.
            </p>
            <div className="mt-5 flex justify-end">
              <button type="button" className="btn-primary" onClick={() => setAbierto(false)}>
                Entendido
              </button>
            </div>
          </>
        ) : (
          <form onSubmit={guardar}>
            <h2 id="titulo-correos-demo" className="text-lg font-semibold text-slate-900">
              Correos para probar la demo
            </h2>
            <p className="mt-2 text-sm text-slate-600">
              Ingresa tu correo para recibir de verdad los correos del sistema. Los datos de ejemplo tienen
              direcciones ficticias: aquí se usan las tuyas, y nunca se le escribe a un cliente real.
            </p>

            <div className="mt-4">
              <label className="label" htmlFor="correo-demo-cliente">
                Correo del cliente
              </label>
              <input
                id="correo-demo-cliente"
                type="email"
                required
                autoFocus
                value={correoCliente}
                onChange={(evento) => setCorreoCliente(evento.target.value)}
                placeholder="cliente@ejemplo.com"
                className="input"
              />
              <p className="mt-1 text-xs text-slate-500">Recibe la encuesta de postventa.</p>
            </div>

            <label className="mt-4 flex items-center gap-2 text-sm text-slate-700">
              <input
                type="checkbox"
                checked={mismoCorreo}
                onChange={(evento) => setMismoCorreo(evento.target.checked)}
              />
              Usar el mismo correo para el asesor
            </label>

            {!mismoCorreo && (
              <div className="mt-3">
                <label className="label" htmlFor="correo-demo-asesor">
                  Correo del asesor
                </label>
                <input
                  id="correo-demo-asesor"
                  type="email"
                  required
                  value={correoAsesor}
                  onChange={(evento) => setCorreoAsesor(evento.target.value)}
                  placeholder="asesor@ejemplo.com"
                  className="input"
                />
                <p className="mt-1 text-xs text-slate-500">Recibe el aviso cuando una encuesta llega negativa.</p>
              </div>
            )}

            <p className="mt-4 rounded bg-amber-50 px-3 py-2 text-xs text-amber-800">
              La demo es compartida: si otra persona guarda sus correos después, los correos pasan a ser suyos.
            </p>

            {error && <div className="mt-3 rounded border border-red-200 bg-red-50 px-3 py-2 text-sm text-red-700">{error}</div>}

            <div className="mt-5 flex items-center justify-end gap-2">
              <button type="button" className="btn-ghost" onClick={omitir}>
                Ahora no
              </button>
              <button type="submit" className="btn-primary" disabled={guardando}>
                {guardando ? 'Guardando…' : 'Guardar correos'}
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  )
}

export default ModalCorreosDemo
