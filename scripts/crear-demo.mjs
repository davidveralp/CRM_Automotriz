// Script de un solo uso: crea las 12 cuentas de autenticación del tenant demo
// (una por rol, ver 0036_tenant_demo.sql) y sube el logo
// al bucket público logos-empresa, en la ruta que esa migración espera
// -determinística a propósito, para no tener que capturar la salida del
// script y pegarla de vuelta en el SQL-.
//
// Requiere SUPABASE_SERVICE_ROLE_KEY (Dashboard → Settings → API): un
// secreto real, nunca se guarda en este repo. Se lee de una variable de
// entorno pasada al momento de correr el script, no de un archivo.
//
// Se puede volver a correr: si la cuenta existe, actualiza correo y contraseña; el logo se sobrescribe.
//
// Uso: SUPABASE_SERVICE_ROLE_KEY=... node scripts/crear-demo.mjs

import { createClient } from '@supabase/supabase-js'
import { readFile } from 'node:fs/promises'

const SUPABASE_URL = 'https://ywdozovkhnnvlpckstsd.supabase.co'
const EMPRESA_ID = 'b0000000-0000-4000-8000-000000000001'
const CONTRASENA_DEMO = 'TallerDemo2026!'

const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY
if (!serviceRoleKey) {
  console.error('Falta SUPABASE_SERVICE_ROLE_KEY en el entorno.')
  process.exit(1)
}

const supabase = createClient(SUPABASE_URL, serviceRoleKey, {
  auth: { autoRefreshToken: false, persistSession: false },
})

const USUARIOS_DEMO = [
  { id: 'a0000000-0000-4000-8000-000000000001', correo: 'demo-admin@example.com', rol: 'admin' },
  { id: 'a0000000-0000-4000-8000-000000000002', correo: 'demo-socia@example.com', rol: 'socia' },
  { id: 'a0000000-0000-4000-8000-000000000003', correo: 'demo-asesor@example.com', rol: 'asesor' },
  { id: 'a0000000-0000-4000-8000-000000000004', correo: 'demo-jefe-taller@example.com', rol: 'jefe_taller' },
  { id: 'a0000000-0000-4000-8000-000000000005', correo: 'demo-presupuestos@example.com', rol: 'encargado_presupuestos' },
  { id: 'a0000000-0000-4000-8000-000000000006', correo: 'demo-tecnico@example.com', rol: 'tecnico' },
  { id: 'a0000000-0000-4000-8000-000000000007', correo: 'demo-detailer@example.com', rol: 'detailer' },
  { id: 'a0000000-0000-4000-8000-000000000008', correo: 'demo-recepcionista@example.com', rol: 'recepcionista' },
  // Resto del equipo técnico (ver 0050_demo_tecnicos_reales.sql).
  { id: 'a0000000-0000-4000-8000-000000000009', correo: 'demo-mecanico2@example.com', rol: 'tecnico' },
  { id: 'a0000000-0000-4000-8000-00000000000a', correo: 'demo-mecanico3@example.com', rol: 'tecnico' },
  { id: 'a0000000-0000-4000-8000-00000000000b', correo: 'demo-lavador@example.com', rol: 'tecnico' },
  { id: 'a0000000-0000-4000-8000-00000000000c', correo: 'demo-alineador@example.com', rol: 'tecnico' },
]

async function crearUsuarios() {
  for (const usuario of USUARIOS_DEMO) {
    const { data, error } = await supabase.auth.admin.createUser({
      id: usuario.id,
      email: usuario.correo,
      password: CONTRASENA_DEMO,
      email_confirm: true,
    })

    if (error) {
      // Ya existe la cuenta (por ejemplo al renombrar correos o cambiar la
      // contraseña de la demo): se actualiza por id en vez de fallar.
      const { error: errorUpdate } = await supabase.auth.admin.updateUserById(usuario.id, {
        email: usuario.correo,
        password: CONTRASENA_DEMO,
        email_confirm: true,
      })
      if (errorUpdate) {
        console.error(`Error con ${usuario.correo}:`, error.message, '/', errorUpdate.message)
        continue
      }
      console.log(`Actualizado: ${usuario.correo}`)
      continue
    }
    console.log(`Creado: ${usuario.correo} (${data.user.id})`)
  }
}

async function subirLogo() {
  const archivo = await readFile(new URL('../public/logo-didial.png', import.meta.url))
  const ruta = `${EMPRESA_ID}/logo-didial.png`

  const { error } = await supabase.storage.from('logos-empresa').upload(ruta, archivo, {
    contentType: 'image/png',
    upsert: true,
  })

  if (error) {
    console.error('Error subiendo el logo:', error.message)
    return
  }
  console.log(`Logo subido: ${SUPABASE_URL}/storage/v1/object/public/logos-empresa/${ruta}`)
}

await crearUsuarios()
await subirLogo()
console.log('Listo. Ahora corre la migración 0036_tenant_demo.sql en el SQL Editor.')
