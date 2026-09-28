-- =============================================================================
-- 0062_coordinador_repuestos.sql
--
-- Qué resuelve:
--   Los ítems que se agregan a las listas de control de Repuestos y
--   Lubricantes e insumos (desde el Kanban, función clickup-item) se asignan
--   solos al coordinador de repuestos -hoy Víctor Tello-, para que prepare
--   todo antes de la reparación y/o compre lo que falte. Servicios externos
--   no lleva asignación automática -son terceros, no bodega-.
--
--   Se guarda en clickup_config (no hardcodeado en el código ni por nombre):
--   si el día de mañana cambia quién coordina repuestos, se actualiza con un
--   UPDATE, sin tocar ninguna función.
-- =============================================================================

alter table public.clickup_config
  add column if not exists responsable_repuestos_id uuid references public.usuarios (id) on delete set null;

comment on column public.clickup_config.responsable_repuestos_id is 'A quién se le asignan solos los ítems nuevos de Repuestos y Lubricantes e insumos (coordinador de repuestos, hoy Víctor Tello). NULL = no se asigna nadie automáticamente.';

-- Se completa solo donde ya existe un usuario activo con apellido Tello
-- (real y demo, ver 0050 -la demo usa los nombres reales del equipo-).
update public.clickup_config cc
set responsable_repuestos_id = (
  select u.id from public.usuarios u
  where u.empresa_id = cc.empresa_id and u.activo and u.nombre_completo ilike '%tello%'
  order by u.nombre_completo
  limit 1
)
where exists (
  select 1 from public.usuarios u
  where u.empresa_id = cc.empresa_id and u.activo and u.nombre_completo ilike '%tello%'
);

-- ---------------------------------------------------------------------------
-- Verificación.
-- ---------------------------------------------------------------------------
select
  (select count(*) from information_schema.columns where table_name = 'clickup_config' and column_name = 'responsable_repuestos_id') as columna_esperado_1,
  (select u.nombre_completo from public.clickup_config cc join public.usuarios u on u.id = cc.responsable_repuestos_id
     where cc.empresa_id = 'aaf45e88-61f2-4aca-b16a-274462f90f5c') as coordinador_real_esperado_victor_tello,
  (select u.nombre_completo from public.clickup_config cc join public.usuarios u on u.id = cc.responsable_repuestos_id
     where cc.empresa_id = 'b0000000-0000-4000-8000-000000000001') as coordinador_demo_esperado_victor_tello;
