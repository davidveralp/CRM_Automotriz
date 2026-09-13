import { useAuth } from '../context/AuthContext'

function Inicio() {
  const { usuario } = useAuth()

  return (
    <div className="p-6">
      <h1 className="text-xl font-semibold text-slate-900">
        Hola, {usuario?.nombre_completo || usuario?.correo}
      </h1>
      <p className="mt-2 text-slate-500">
        Bloque 1 listo: autenticación y roles funcionando. Los módulos de clientes, vehículos e
        ingreso se agregan en los siguientes bloques.
      </p>
    </div>
  )
}

export default Inicio
