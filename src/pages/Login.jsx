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
      setError('Correo o contraseña incorrectos.')
    }
    setEnviando(false)
  }

  return (
    <div className="flex min-h-screen w-full flex-col bg-didial-dark lg:flex-row">
      {/* Panel de marca */}
      <div className="relative flex min-h-[300px] items-center justify-center overflow-hidden px-8 py-14 lg:w-3/5 lg:py-0">
        <div className="carbon absolute inset-0" />
        <div className="absolute inset-0" style={{ boxShadow: 'inset 0 0 160px 40px rgba(0,0,0,0.6)' }} />

        <svg className="absolute inset-0 h-full w-full opacity-[0.08]" preserveAspectRatio="none">
          <defs>
            <pattern id="speed" width="60" height="60" patternUnits="userSpaceOnUse" patternTransform="rotate(-20)">
              <line x1="0" y1="0" x2="0" y2="60" stroke="#fff" strokeWidth="1" />
            </pattern>
          </defs>
          <rect width="100%" height="100%" fill="url(#speed)" />
        </svg>

        <svg
          className="absolute -right-10 top-1/2 h-auto w-[120%] -translate-y-1/2 opacity-90"
          viewBox="0 0 800 300"
          fill="none"
        >
          <path
            d="M-50 220 C 250 120, 520 90, 860 30"
            stroke="#F9C847"
            strokeWidth="14"
            strokeLinecap="round"
            fill="none"
            opacity="0.85"
          />
          <path
            d="M-50 250 C 280 170, 560 150, 880 100"
            stroke="#E73C32"
            strokeWidth="6"
            strokeLinecap="round"
            fill="none"
            opacity="0.6"
          />
        </svg>

        <div className="relative z-10 max-w-md text-center lg:text-left">
          <div className="inline-block rounded-2xl bg-white px-7 py-6 shadow-2xl">
            <img src="/logo-completo-didial.png" alt="Servicio Automotriz Didial" className="h-16 w-auto lg:h-20" />
          </div>
          <h1 className="mt-8 text-3xl font-bold leading-tight text-white lg:text-4xl">
            Gestión <span className="text-didial-amber">del taller</span>
          </h1>
          <p className="mt-3 text-base text-slate-300 lg:text-lg">CRM de recepción, ventas y postventa.</p>
          <div className="mt-6 flex items-center justify-center gap-2 lg:justify-start">
            <span className="h-1 w-10 rounded-full bg-didial-red" />
            <span className="h-1 w-6 rounded-full bg-didial-amber" />
            <span className="h-1 w-3 rounded-full bg-white/40" />
          </div>
        </div>
      </div>

      {/* Panel de login */}
      <div className="flex items-center justify-center bg-white px-6 py-12 lg:w-2/5">
        <div className="w-full max-w-sm">
          <div className="mb-8 flex justify-center lg:hidden">
            <img src="/logo-completo-didial.png" alt="Didial" className="h-12 w-auto" />
          </div>

          <h2 className="text-2xl font-bold text-ink">Iniciar sesión</h2>
          <p className="mb-8 mt-1 text-sm text-slate-500">Ingresa con tu correo del taller.</p>

          <form onSubmit={manejarEnvio} className="space-y-5">
            <div>
              <label className="label" htmlFor="correo">
                Correo
              </label>
              <input
                id="correo"
                className="input"
                type="email"
                autoComplete="username"
                required
                value={correo}
                onChange={(evento) => setCorreo(evento.target.value)}
              />
            </div>
            <div>
              <label className="label" htmlFor="clave">
                Contraseña
              </label>
              <input
                id="clave"
                className="input"
                type="password"
                autoComplete="current-password"
                required
                value={clave}
                onChange={(evento) => setClave(evento.target.value)}
              />
            </div>

            {error && (
              <div className="rounded-lg border border-red-100 bg-red-50 px-3 py-2 text-sm text-red-600">{error}</div>
            )}

            <button
              type="submit"
              disabled={enviando}
              className="w-full rounded-lg bg-didial-red py-3 font-semibold text-white transition-colors hover:bg-[#c92f26] disabled:opacity-50"
            >
              {enviando ? 'Ingresando…' : 'Ingresar'}
            </button>
          </form>

          <p className="mt-10 text-center text-xs text-slate-400">Servicio Automotriz Didial · La Serena</p>
        </div>
      </div>
    </div>
  )
}

export default Login
