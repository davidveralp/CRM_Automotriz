-- =============================================================================
-- 0063_demo_nombres_reales_equipo.sql
--
-- Qué resuelve:
--   Ajuste puntual de datos del tenant demo (no toca el real): los 5 técnicos
--   ya tenían el nombre real del equipo de Didial desde 0050, pero el resto de
--   los usuarios demo seguían con nombres de relleno (Ana Administradora,
--   Andrés Asesor, etc.). Se completan con los nombres reales, por rol -nunca
--   se tocan correos ni roles, la demo sigue entrando con sus propias
--   cuentas-:
--     admin                  -> David Vera
--     asesor                 -> Diego Leyton
--     jefe_taller            -> Andrés Aracena
--     encargado_presupuestos -> Víctor Tello (coordinador de repuestos)
--     socia                  -> Jessica Díaz (la empresa real tiene dos
--       socias -Alexis Díaz y Jessica Díaz-; la demo solo tiene un cupo de
--       socia, se eligió Jessica Díaz con el cliente el 2026-09-28)
--   recepcionista se deja como estaba ("Rocío Recepción"): hoy no existe
--   ningún usuario con ese rol en la empresa real, no hay a quién copiar.
--
--   De paso, ahora que la demo también tiene un "Tello", se completa
--   clickup_config.responsable_repuestos_id ahí (0062 no lo había podido
--   completar: en ese momento nadie se llamaba así en la demo).
-- =============================================================================

do $$
declare
  emp constant uuid := 'b0000000-0000-4000-8000-000000000001';
begin
  if not exists (select 1 from public.empresas where id = emp) then
    raise notice 'No existe el tenant demo: se omite.';
    return;
  end if;

  update public.usuarios set nombre_completo = 'David Vera' where empresa_id = emp and rol = 'admin';
  update public.usuarios set nombre_completo = 'Diego Leyton' where empresa_id = emp and rol = 'asesor';
  update public.usuarios set nombre_completo = 'Andrés Aracena' where empresa_id = emp and rol = 'jefe_taller';
  update public.usuarios set nombre_completo = 'Víctor Tello' where empresa_id = emp and rol = 'encargado_presupuestos';
  update public.usuarios set nombre_completo = 'Jessica Díaz' where empresa_id = emp and rol = 'socia';

  update public.clickup_config cc
  set responsable_repuestos_id = (
    select u.id from public.usuarios u
    where u.empresa_id = cc.empresa_id and u.activo and u.nombre_completo ilike '%tello%'
    order by u.nombre_completo
    limit 1
  )
  where cc.empresa_id = emp;
end $$;

-- ---------------------------------------------------------------------------
-- Verificación.
-- ---------------------------------------------------------------------------
select nombre_completo, rol
from public.usuarios
where empresa_id = 'b0000000-0000-4000-8000-000000000001'
order by rol, nombre_completo;

select u.nombre_completo as coordinador_repuestos_demo_esperado_victor_tello
from public.clickup_config cc
join public.usuarios u on u.id = cc.responsable_repuestos_id
where cc.empresa_id = 'b0000000-0000-4000-8000-000000000001';
