import { useState } from 'react'
import { Navigate } from 'react-router-dom'
import { supabase } from '../supabaseClient'
import { useAuth } from '../context/AuthContext'

function Login() {
  const { sesion, cargando } = useAuth()
  const [correo, setCorreo] = useState('')
  const [clave, setClave] = useState('')
  const [enviando, setEnviando] = useState(false)
  const [error, setError] = useState(null)

  if (!cargando && sesion) {
    return <Navigate to="/" replace />
  }

  async function manejarEnvio(evento) {
    evento.preventDefault()
    setEnviando(true)
    setError(null)

    const { error: errorLogin } = await supabase.auth.signInWithPassword({
      email: correo,
      password: clave,
    })

    if (errorLogin) {
      setError(errorLogin.message)
    }
    setEnviando(false)
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-slate-100">
      <form onSubmit={manejarEnvio} className="w-full max-w-sm rounded-lg bg-white p-8 shadow-sm">
        <h1 className="mb-1 text-xl font-semibold text-slate-900">Iniciar sesión</h1>
        <p className="mb-6 text-sm text-slate-500">Ingresa con tu correo del taller.</p>

        <label className="mb-1 block text-sm font-medium text-slate-700" htmlFor="correo">
          Correo
        </label>
        <input
          id="correo"
          type="email"
          required
          value={correo}
          onChange={(evento) => setCorreo(evento.target.value)}
          className="mb-4 w-full rounded border border-slate-300 px-3 py-2 text-sm"
        />

        <label className="mb-1 block text-sm font-medium text-slate-700" htmlFor="clave">
          Contraseña
        </label>
        <input
          id="clave"
          type="password"
          required
          value={clave}
          onChange={(evento) => setClave(evento.target.value)}
          className="mb-4 w-full rounded border border-slate-300 px-3 py-2 text-sm"
        />

        {error && <p className="mb-4 text-sm text-red-600">{error}</p>}

        <button
          type="submit"
          disabled={enviando}
          className="w-full rounded bg-slate-900 px-3 py-2 text-sm font-medium text-white hover:bg-slate-800 disabled:opacity-50"
        >
          {enviando ? 'Ingresando…' : 'Ingresar'}
        </button>
      </form>
    </div>
  )
}

export default Login
