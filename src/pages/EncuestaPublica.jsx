import { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { supabase } from '../supabaseClient'

const CARAS = ['😞', '🙁', '😐', '🙂', '😄']

function EncuestaPublica() {
  const { token } = useParams()
  const [datos, setDatos] = useState(null)
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState(null)
  const [calificacion, setCalificacion] = useState(null)
  const [comentario, setComentario] = useState('')
  const [enviando, setEnviando] = useState(false)
  const [enviado, setEnviado] = useState(false)

  useEffect(() => {
    async function cargar() {
      try {
        const { data, error: errorRpc } = await supabase.rpc('encuesta_obtener_por_token', { p_token: token })
        if (errorRpc || !data || data.length === 0) {
          setError('No encontramos esta encuesta. Puede que el enlace esté vencido o incompleto.')
          return
        }
        setDatos(data[0])
      } catch {
        setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
      } finally {
        setCargando(false)
      }
    }
    cargar()
  }, [token])

  async function enviarRespuesta(evento) {
    evento.preventDefault()
    if (!calificacion) return
    setEnviando(true)
    setError(null)
    try {
      const { error: errorRpc } = await supabase.rpc('encuesta_responder', {
        p_token: token,
        p_calificacion: calificacion,
        p_comentario: comentario || null,
      })
      if (errorRpc) {
        setError(errorRpc.message)
        return
      }
      setEnviado(true)
    } catch {
      setError('No se pudo conectar con el servidor. Revisa la conexión e intenta de nuevo.')
    } finally {
      setEnviando(false)
    }
  }

  if (cargando) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-slate-100 p-4 text-slate-500">Cargando…</div>
    )
  }

  if (error) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-slate-100 p-4">
        <p className="max-w-sm text-center text-slate-600">{error}</p>
      </div>
    )
  }

  const yaRespondida = enviado || datos?.respondido_en

  return (
    <div className="flex min-h-screen items-center justify-center bg-slate-100 p-4">
      <div className="w-full max-w-sm rounded-lg bg-white p-8 shadow-sm">
        {yaRespondida ? (
          <>
            <p className="mb-2 text-3xl">🙏</p>
            <h1 className="mb-1 text-lg font-semibold text-slate-900">¡Gracias por tu respuesta!</h1>
            <p className="text-sm text-slate-500">Nos ayuda a mejorar el servicio.</p>
          </>
        ) : (
          <form onSubmit={enviarRespuesta}>
            <h1 className="mb-1 text-lg font-semibold text-slate-900">¿Cómo fue tu experiencia?</h1>
            <p className="mb-4 text-sm text-slate-500">
              {datos?.marca} {datos?.modelo} · patente {datos?.patente} · OT {datos?.numero_ot}
            </p>

            <div className="mb-4 flex justify-between">
              {CARAS.map((cara, indice) => {
                const valor = indice + 1
                return (
                  <button
                    key={valor}
                    type="button"
                    onClick={() => setCalificacion(valor)}
                    className={`rounded-full p-2 text-3xl transition ${
                      calificacion === valor ? 'bg-slate-900 scale-110' : 'hover:bg-slate-100'
                    }`}
                  >
                    {cara}
                  </button>
                )
              })}
            </div>

            <textarea
              value={comentario}
              onChange={(evento) => setComentario(evento.target.value)}
              placeholder="¿Algo que quieras contarnos? (opcional)"
              rows={3}
              className="mb-4 w-full rounded border border-slate-300 px-3 py-2 text-sm"
            />

            {error && <p className="mb-4 text-sm text-red-600">{error}</p>}

            <button
              type="submit"
              disabled={!calificacion || enviando}
              className="w-full rounded bg-slate-900 px-3 py-2 text-sm font-medium text-white hover:bg-slate-800 disabled:opacity-50"
            >
              {enviando ? 'Enviando…' : 'Enviar'}
            </button>
          </form>
        )}
      </div>
    </div>
  )
}

export default EncuestaPublica
