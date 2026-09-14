import { NavLink } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'

const ETIQUETAS_ROL = {
  socia: 'Socia',
  admin: 'Administrador',
  asesor: 'Asesor',
  jefe_taller: 'Jefe de taller',
  encargado_presupuestos: 'Encargado de presupuestos',
  tecnico: 'Técnico',
  detailer: 'Detailer',
  recepcionista: 'Recepcionista',
}

function claseEnlace({ isActive }) {
  return `block rounded px-3 py-2 text-sm ${
    isActive ? 'bg-slate-900 text-white' : 'text-slate-600 hover:bg-slate-100'
  }`
}

// Vive fuera del ErrorBoundary de cada página: si el contenido revienta,
// el menú (y el botón de cerrar sesión) debe seguir funcionando.
function Menu() {
  const { usuario, cerrarSesion } = useAuth()

  return (
    <nav className="flex w-60 flex-col justify-between border-r border-slate-200 bg-white p-4 print:hidden">
      <div>
        <p className="text-lg font-semibold text-slate-800">CRM</p>
        <p className="mb-6 truncate text-xs text-slate-400">{usuario?.empresas?.nombre}</p>
        <div className="flex flex-col gap-1">
          <NavLink to="/" end className={claseEnlace}>
            Inicio
          </NavLink>
          <NavLink to="/clientes" className={claseEnlace}>
            Clientes
          </NavLink>
          <NavLink to="/ingresos/nuevo" className={claseEnlace}>
            Nuevo ingreso
          </NavLink>
          <NavLink to="/trabajos" className={claseEnlace}>
            Trabajos
          </NavLink>
          <NavLink to="/oportunidades" className={claseEnlace}>
            Oportunidades
          </NavLink>
        </div>
      </div>
      {usuario && (
        <div className="border-t border-slate-200 pt-4 text-sm">
          <p className="font-medium text-slate-800">{usuario.nombre_completo || usuario.correo}</p>
          <p className="text-slate-500">{ETIQUETAS_ROL[usuario.rol] ?? usuario.rol}</p>
          <button
            type="button"
            onClick={cerrarSesion}
            className="mt-2 text-slate-500 underline hover:text-slate-700"
          >
            Cerrar sesión
          </button>
        </div>
      )}
    </nav>
  )
}

export default Menu
