-- =============================================================================
-- 0065_demo_rebrand_vpai.sql
--
-- Qué resuelve:
--   La demo pasa a mostrarse bajo marca propia "VPAI" (ver también el nuevo
--   login /demo y el selector "Cambiar de rol" en el frontend), separada de
--   Didial. Todo acotado a la empresa demo -nunca toca el tenant real-:
--
--   1. Nombres ficticios para los 12 usuarios demo (0063 les había puesto
--      nombres reales del equipo de Didial; ya no corresponde para una demo
--      de marca propia).
--   2. El rol 'socia' se fusiona con 'admin' en la demo: no se puede quitar
--      del sistema (RLS y el tenant real dependen de él), así que la cuenta
--      demo-socia@example.com se reasigna a 'admin' y se desactiva como
--      login -el selector de rol de la demo ya no la ofrece, ver
--      src/lib/demo.js-.
-- =============================================================================

do $$
declare
  v_empresa_id uuid := 'b0000000-0000-4000-8000-000000000001';
begin
  update public.usuarios set nombre_completo = 'Carlos Mendoza' where empresa_id = v_empresa_id and correo = 'demo-admin@example.com';
  update public.usuarios set nombre_completo = 'Patricia Soto' where empresa_id = v_empresa_id and correo = 'demo-socia@example.com';
  update public.usuarios set nombre_completo = 'Marcelo Rojas' where empresa_id = v_empresa_id and correo = 'demo-asesor@example.com';
  update public.usuarios set nombre_completo = 'Sergio Palacios' where empresa_id = v_empresa_id and correo = 'demo-jefe-taller@example.com';
  update public.usuarios set nombre_completo = 'Rodrigo Fuentes' where empresa_id = v_empresa_id and correo = 'demo-presupuestos@example.com';
  update public.usuarios set nombre_completo = 'Cristian Morales' where empresa_id = v_empresa_id and correo = 'demo-tecnico@example.com';
  update public.usuarios set nombre_completo = 'Felipe Contreras' where empresa_id = v_empresa_id and correo = 'demo-detailer@example.com';
  update public.usuarios set nombre_completo = 'Camila Torres' where empresa_id = v_empresa_id and correo = 'demo-recepcionista@example.com';
  update public.usuarios set nombre_completo = 'Nicolás Herrera' where empresa_id = v_empresa_id and correo = 'demo-mecanico2@example.com';
  update public.usuarios set nombre_completo = 'Matías Silva' where empresa_id = v_empresa_id and correo = 'demo-mecanico3@example.com';
  update public.usuarios set nombre_completo = 'Joaquín Vergara' where empresa_id = v_empresa_id and correo = 'demo-lavador@example.com';
  update public.usuarios set nombre_completo = 'Francisco Gómez' where empresa_id = v_empresa_id and correo = 'demo-alineador@example.com';

  -- Fusión 'socia' -> 'admin': se retira como cuenta de login de la demo.
  update public.usuarios
  set rol = 'admin', activo = false
  where empresa_id = v_empresa_id and correo = 'demo-socia@example.com';
end $$;

-- ---------------------------------------------------------------------------
-- Verificación.
-- ---------------------------------------------------------------------------
select correo, nombre_completo, rol, activo
from public.usuarios
where empresa_id = 'b0000000-0000-4000-8000-000000000001'
order by correo;
