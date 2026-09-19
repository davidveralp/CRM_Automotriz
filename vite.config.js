import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      // Las rutas públicas (login, invitaciones, encuestas de postventa) y los
      // archivos estáticos deben quedar fuera del service worker: si se
      // interceptan, cualquier página que no sea la app queda rota.
      workbox: {
        navigateFallbackDenylist: [/^\/publico/, /^\/encuesta/, /^\/api/],
      },
      includeAssets: ['logo-didial.png'],
      manifest: {
        name: 'CRM Didial',
        short_name: 'Didial',
        description: 'Sistema de gestión — Servicio Automotriz Didial Ltda',
        theme_color: '#0f172a',
        background_color: '#0f172a',
        display: 'standalone',
        icons: [
          { src: '/logo-didial.png', sizes: '192x192', type: 'image/png' },
          { src: '/logo-didial.png', sizes: '512x512', type: 'image/png' },
        ],
      },
    }),
  ],
})
