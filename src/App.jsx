import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { AuthProvider } from './context/AuthContext'
import ErrorBoundary from './components/ErrorBoundary'
import Menu from './components/Menu'
import RutaProtegida from './components/RutaProtegida'
import Login from './pages/Login'
import Inicio from './pages/Inicio'
import Clientes from './pages/Clientes'
import ClienteDetalle from './pages/ClienteDetalle'
import NuevoIngreso from './pages/NuevoIngreso'
import Trabajos from './pages/Trabajos'
import TrabajoDetalle from './pages/TrabajoDetalle'

function Layout({ children }) {
  return (
    <div className="flex min-h-screen bg-slate-50">
      <Menu />
      <main className="flex-1">
        <ErrorBoundary>{children}</ErrorBoundary>
      </main>
    </div>
  )
}

function paginaProtegida(elemento) {
  return (
    <Layout>
      <RutaProtegida>{elemento}</RutaProtegida>
    </Layout>
  )
}

function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/" element={paginaProtegida(<Inicio />)} />
          <Route path="/clientes" element={paginaProtegida(<Clientes />)} />
          <Route path="/clientes/:id" element={paginaProtegida(<ClienteDetalle />)} />
          <Route path="/ingresos/nuevo" element={paginaProtegida(<NuevoIngreso />)} />
          <Route path="/trabajos" element={paginaProtegida(<Trabajos />)} />
          <Route path="/trabajos/:id" element={paginaProtegida(<TrabajoDetalle />)} />
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  )
}

export default App
