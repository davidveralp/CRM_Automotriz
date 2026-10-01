// Credenciales de la demo (tenant VPAI): usadas por LoginDemo.jsx para entrar
// eligiendo un rol, y por el selector "Cambiar de rol" de BarraSuperior.jsx
// para cambiar de cuenta sin pasar por /login ni /demo.
//
// IMPORTANTE: deben mantenerse sincronizadas a mano con
// scripts/crear-demo.mjs, que es el dueño real de estas cuentas en Supabase
// Auth (CONTRASENA_DEMO ahí es la misma constante). No son credenciales
// secretas: la demo es pública y compartida por quien quiera probarla.
//
// 'socia' no tiene correo acá a propósito: esa cuenta (demo-socia@example.com)
// se fusionó con 'admin' en la demo (migración 0065) y ya no se ofrece como
// rol para entrar.
export const CONTRASENA_DEMO = 'TallerDemo2026!'

export const CORREO_DEMO_POR_ROL = {
  admin: 'demo-admin@example.com',
  asesor: 'demo-asesor@example.com',
  jefe_taller: 'demo-jefe-taller@example.com',
  encargado_presupuestos: 'demo-presupuestos@example.com',
  tecnico: 'demo-tecnico@example.com',
  detailer: 'demo-detailer@example.com',
  recepcionista: 'demo-recepcionista@example.com',
}

export async function cambiarRolDemo(supabase, rol) {
  await supabase.auth.signOut()
  const { error } = await supabase.auth.signInWithPassword({
    email: CORREO_DEMO_POR_ROL[rol],
    password: CONTRASENA_DEMO,
  })
  if (error) throw error
}
