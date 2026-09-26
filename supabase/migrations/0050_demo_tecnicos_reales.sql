-- =============================================================================
-- 0050_demo_tecnicos_reales.sql
--
-- Qué resuelve:
--   El equipo técnico de la demo usa los mismos nombres y funciones que el de
--   Didial:
--     Felipe Codoceo, Ignacio Heredia, Shelmy Belyzer  -> mecánicos master
--     Gabriel Cayo                                     -> lavador / servicios rápidos
--     Wilson Araya                                     -> detailer / pintura
--     Pablo Donoso                                     -> alineador / lavador
--   - Las cuentas demo de técnico y detailer pasan a llamarse Felipe Codoceo y
--     Wilson Araya (mismos correos de acceso de siempre).
--   - Se crean cuatro usuarios más (Ignacio, Shelmy, Gabriel y Pablo). Sus
--     cuentas de acceso se crean antes con scripts/crear-demo.mjs.
--   - Cada persona del equipo (personal_taller) queda ligada a su usuario.
--   - Cada puesto del plano queda a cargo del técnico de su función.
--   - Las tareas de las OT activas pasan al técnico del puesto donde está el
--     vehículo. Las OT ya entregadas quedan bloqueadas y conservan lo suyo.
--   Solo toca el tenant demo. Se puede volver a correr.
--
-- Antes de correr esto:  SUPABASE_SERVICE_ROLE_KEY=... node scripts/crear-demo.mjs
-- =============================================================================

do $$
declare
  emp constant uuid := 'b0000000-0000-4000-8000-000000000001';
  v_felipe constant uuid := 'a0000000-0000-4000-8000-000000000006';
  v_wilson constant uuid := 'a0000000-0000-4000-8000-000000000007';
  v_ignacio constant uuid := 'a0000000-0000-4000-8000-000000000009';
  v_shelmy constant uuid := 'a0000000-0000-4000-8000-00000000000a';
  v_gabriel constant uuid := 'a0000000-0000-4000-8000-00000000000b';
  v_pablo constant uuid := 'a0000000-0000-4000-8000-00000000000c';
begin
  if not exists (select 1 from public.empresas where id = emp) then
    raise notice 'No existe el tenant demo: no se cambia nada.';
    return;
  end if;

  if (select count(*) from auth.users where id in (v_ignacio, v_shelmy, v_gabriel, v_pablo)) < 4 then
    raise exception 'Faltan las cuentas de acceso de los técnicos nuevos: corre antes scripts/crear-demo.mjs.';
  end if;

  insert into public.usuarios (id, empresa_id, nombre_completo, correo, rol, activo) values
    (v_felipe, emp, 'Felipe Codoceo', 'demo-tecnico@example.com', 'tecnico', true),
    (v_wilson, emp, 'Wilson Araya', 'demo-detailer@example.com', 'detailer', true),
    (v_ignacio, emp, 'Ignacio Heredia', 'demo-mecanico2@example.com', 'tecnico', true),
    (v_shelmy, emp, 'Shelmy Belyzer', 'demo-mecanico3@example.com', 'tecnico', true),
    (v_gabriel, emp, 'Gabriel Cayo', 'demo-lavador@example.com', 'tecnico', true),
    (v_pablo, emp, 'Pablo Donoso', 'demo-alineador@example.com', 'tecnico', true)
  on conflict (id) do update set
    empresa_id = excluded.empresa_id, nombre_completo = excluded.nombre_completo, correo = excluded.correo,
    rol = excluded.rol, activo = excluded.activo;

  -- Cada persona del equipo, ligada a su usuario.
  update public.personal_taller p
  set usuario_id = u.id
  from public.usuarios u
  where p.empresa_id = emp and u.empresa_id = emp and lower(u.nombre_completo) = lower(p.nombre);

  -- Técnico a cargo de cada puesto del plano.
  update public.plano_elementos e
  set tecnico_id = x.tecnico
  from (values
    ('Elevador 1', v_felipe), ('Elevador 2', v_ignacio), ('Elevador 3', v_shelmy),
    ('Servicio rápido 1', v_gabriel), ('Servicio rápido 2', v_gabriel), ('Lavado', v_gabriel),
    ('Alineadora', v_pablo), ('Pintura', v_wilson)
  ) as x(nombre, tecnico)
  where e.empresa_id = emp and e.nombre = x.nombre;

  -- Las tareas de las OT activas pasan al técnico del puesto donde está el vehículo.
  update public.tareas_taller ta
  set tecnico_id = pe.tecnico_id
  from public.trabajos_taller o
  join public.plano_ocupacion po on po.trabajo_id = o.id
  join public.plano_elementos pe on pe.id = po.elemento_id
  where ta.trabajo_id = o.id
    and o.empresa_id = emp
    and o.estado not in ('entregado', 'anulado')
    and o.bloqueada_en is null
    and pe.tecnico_id is not null
    and ta.tecnico_id is not null;
end $$;

-- ---------------------------------------------------------------------------
-- Verificación.
-- ---------------------------------------------------------------------------
select
  (select count(*) from public.usuarios where empresa_id = 'b0000000-0000-4000-8000-000000000001' and rol in ('tecnico', 'detailer')) as tecnicos_esperado_6,
  (select count(*) from public.personal_taller where empresa_id = 'b0000000-0000-4000-8000-000000000001' and usuario_id is not null) as equipo_ligado_esperado_6,
  (select string_agg(e.nombre || '=' || u.nombre_completo, ', ' order by e.nombre)
     from public.plano_elementos e join public.usuarios u on u.id = e.tecnico_id
     where e.empresa_id = 'b0000000-0000-4000-8000-000000000001') as puestos_a_cargo;
