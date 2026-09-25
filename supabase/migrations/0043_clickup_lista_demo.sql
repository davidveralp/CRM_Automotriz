-- =============================================================================
-- 0043_clickup_lista_demo.sql
--
-- Qué resuelve:
--   El tenant de demostración se sincroniza con su PROPIA lista de ClickUp,
--   separada de la lista real de Didial, para que las pruebas nunca toquen las
--   tarjetas del taller real.
--
--   - Didial (real): lista de trabajos 901324296305 (ya configurada en 0004;
--     esta migración solo la verifica, no la cambia).
--   - Demo: lista de trabajos 901329160662, en el mismo espacio de trabajo de
--     ClickUp (90132937173), así que el mismo token de API la alcanza. No tiene
--     lista de RADAR: la sincronización de RADAR no usa esa columna todavía.
--
--   clickup-sincronizar ya lee la lista por empresa (clickup_config), así que
--   una OT de la demo crea su tarjeta en la lista demo sin cambios de código.
--   Para los eventos de vuelta (ClickUp hacia el CRM), la lista demo necesita
--   su propio webhook y su secreto (CLICKUP_WEBHOOK_SECRET_DEMO), que la
--   función clickup-webhook acepta además del secreto de la lista real.
--
--   Los IDs de lista no son secretos (el token y los secretos de webhook sí lo
--   son y viven solo en los secretos de las Edge Functions).
-- =============================================================================

insert into public.clickup_config (empresa_id, lista_trabajos_id, lista_radar_id)
values ('b0000000-0000-4000-8000-000000000001', '901329160662', null)
on conflict (empresa_id) do update set lista_trabajos_id = excluded.lista_trabajos_id, lista_radar_id = null, activo = true;

-- ---------------------------------------------------------------------------
-- Verificación.
-- ---------------------------------------------------------------------------
select
  (select cc.lista_trabajos_id from public.clickup_config cc join public.empresas e on e.id = cc.empresa_id
   where not e.es_demo and e.nombre = 'Servicio Automotriz Didial Ltda.') as lista_real_esperado_901324296305,
  (select cc.lista_trabajos_id from public.clickup_config cc join public.empresas e on e.id = cc.empresa_id
   where e.es_demo) as lista_demo_esperado_901329160662,
  (select count(*) from public.clickup_config) as configuraciones_esperado_2,
  (select count(distinct lista_trabajos_id) from public.clickup_config) as listas_distintas_esperado_2;
