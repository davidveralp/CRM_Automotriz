import { Navigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'

// Guarda de acceso: exige sesión, cuenta activa con rol asignado y,
// opcionalmente, que el rol esté en `rolesPermitidos`.
function RutaProtegida({ children, rolesPermitidos }) {
  const { sesion, usuario, cargando } = useAuth()

  if (cargando) {
    return <div className="p-6 text-slate-500">Cargando…</div>
  }

  if (!sesion) {
    return <Navigate to="/login" replace />
  }

  if (!usuario || !usuario.activo || !usuario.rol) {
    return (
      <div className="p-6 text-slate-600">
        Tu cuenta todavía no tiene un rol asignado. Pide a un administrador que la active.
      </div>
    )
  }

  if (rolesPermitidos && !rolesPermitidos.includes(usuario.rol)) {
    return <div className="p-6 text-slate-600">No tienes permiso para ver esta sección.</div>
  }

  return children
}

export default RutaProtegida
