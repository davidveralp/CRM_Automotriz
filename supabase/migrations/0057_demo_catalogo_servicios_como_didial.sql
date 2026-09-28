-- =============================================================================
-- 0057_demo_catalogo_servicios_como_didial.sql
--
-- Qué resuelve:
--   La demo tenía un catálogo de juguete (7 servicios, 4 repuestos, 0036) y la
--   empresa real tiene el catálogo completo de la planilla de precios
--   (0028: ~280 servicios, con precios de mano de obra por tipo de vehículo y
--   repuestos típicos). Para mostrar el flujo guiado de la OT y el bot de
--   agenda con datos realistas, se copia el catálogo real a la demo:
--   repuestos, servicios, precios y repuestos por servicio.
--   - Es una COPIA, no una referencia: la demo queda con sus propias filas
--     (empresa_id de la demo), así que editar el catálogo de una empresa
--     nunca toca al de la otra.
--   - Idempotente: se puede volver a correr después de cambiar el catálogo
--     real y la demo lo alcanza (los precios y repuestos por servicio de los
--     servicios copiados se reemplazan por los reales).
--   - Los 7 servicios de juguete de la demo que NO existen en el catálogo real
--     se DESACTIVAN en vez de borrarse: algunas citas demo los referencian
--     (citas.catalogo_servicio_id) y borrarlos las dejaría sin servicio. Así
--     dejan de aparecer para elegir (no duplican a los reales) y las citas
--     demo conservan su servicio. Reversible: activo = true.
-- =============================================================================

do $$
declare
  v_real constant uuid := 'aaf45e88-61f2-4aca-b16a-274462f90f5c';
  v_demo constant uuid := 'b0000000-0000-4000-8000-000000000001';
begin
  if not exists (select 1 from public.empresas e where e.id = v_real)
     or not exists (select 1 from public.empresas e where e.id = v_demo) then
    raise exception 'Falta la empresa real o la demo; revisa los ids de esta migración.';
  end if;

  -- Repuestos.
  insert into public.catalogo_repuestos (empresa_id, nombre, activo)
  select v_demo, r.nombre, r.activo
  from public.catalogo_repuestos r
  where r.empresa_id = v_real
  on conflict (empresa_id, nombre) do update set activo = excluded.activo;

  -- Servicios (misma clave única que la real: categoría + servicio).
  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio, activo)
  select v_demo, s.segmento, s.categoria, s.codigo, s.servicio, s.activo
  from public.catalogo_servicios s
  where s.empresa_id = v_real
  on conflict (empresa_id, categoria, servicio) do update
    set segmento = excluded.segmento, codigo = excluded.codigo, activo = excluded.activo;

  -- Precios: de los servicios copiados se reemplazan por los reales.
  delete from public.catalogo_servicio_precios p
  using public.catalogo_servicios sd, public.catalogo_servicios sr
  where p.servicio_id = sd.id and sd.empresa_id = v_demo
    and sr.empresa_id = v_real and sr.categoria = sd.categoria and sr.servicio = sd.servicio;

  insert into public.catalogo_servicio_precios
    (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
  select sd.id, p.tipo_vehiculo, p.combustible, p.horas_mo, p.valor_mo, p.repuestos_min, p.repuestos_max, p.insumos_clp, p.notas
  from public.catalogo_servicio_precios p
  join public.catalogo_servicios sr on sr.id = p.servicio_id and sr.empresa_id = v_real
  join public.catalogo_servicios sd on sd.empresa_id = v_demo and sd.categoria = sr.categoria and sd.servicio = sr.servicio;

  -- Repuestos típicos por servicio (mismo criterio: reemplazo).
  delete from public.catalogo_servicio_repuestos sp
  using public.catalogo_servicios sd, public.catalogo_servicios sr
  where sp.servicio_id = sd.id and sd.empresa_id = v_demo
    and sr.empresa_id = v_real and sr.categoria = sd.categoria and sr.servicio = sd.servicio;

  insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id)
  select sd.id, rd.id
  from public.catalogo_servicio_repuestos sp
  join public.catalogo_servicios sr on sr.id = sp.servicio_id and sr.empresa_id = v_real
  join public.catalogo_repuestos rr on rr.id = sp.repuesto_id and rr.empresa_id = v_real
  join public.catalogo_servicios sd on sd.empresa_id = v_demo and sd.categoria = sr.categoria and sd.servicio = sr.servicio
  join public.catalogo_repuestos rd on rd.empresa_id = v_demo and rd.nombre = rr.nombre
  on conflict do nothing;

  -- Servicios de juguete de la demo sin equivalente real: se desactivan (ver cabecera).
  update public.catalogo_servicios sd
  set activo = false
  where sd.empresa_id = v_demo
    and not exists (
      select 1 from public.catalogo_servicios sr
      where sr.empresa_id = v_real and sr.categoria = sd.categoria and sr.servicio = sd.servicio
    );
end $$;

-- ---------------------------------------------------------------------------
-- Verificación: real y demo deben coincidir (los "juguete" desactivados aparte).
-- ---------------------------------------------------------------------------
select
  (select count(*) from public.catalogo_servicios where empresa_id = 'aaf45e88-61f2-4aca-b16a-274462f90f5c') as servicios_real,
  (select count(*) from public.catalogo_servicios where empresa_id = 'b0000000-0000-4000-8000-000000000001' and activo) as servicios_demo_activos_igual_a_real,
  (select count(*) from public.catalogo_servicios where empresa_id = 'b0000000-0000-4000-8000-000000000001' and not activo) as servicios_demo_juguete_desactivados,
  (select count(*) from public.catalogo_servicio_precios p join public.catalogo_servicios s on s.id = p.servicio_id where s.empresa_id = 'aaf45e88-61f2-4aca-b16a-274462f90f5c') as precios_real,
  (select count(*) from public.catalogo_servicio_precios p join public.catalogo_servicios s on s.id = p.servicio_id where s.empresa_id = 'b0000000-0000-4000-8000-000000000001' and s.activo) as precios_demo_activos_igual_a_real,
  (select count(*) from public.catalogo_repuestos where empresa_id = 'aaf45e88-61f2-4aca-b16a-274462f90f5c') as repuestos_real,
  (select count(*) from public.catalogo_repuestos where empresa_id = 'b0000000-0000-4000-8000-000000000001') as repuestos_demo,
  (select count(*) from public.catalogo_servicio_repuestos sp join public.catalogo_servicios s on s.id = sp.servicio_id where s.empresa_id = 'aaf45e88-61f2-4aca-b16a-274462f90f5c') as servrep_real,
  (select count(*) from public.catalogo_servicio_repuestos sp join public.catalogo_servicios s on s.id = sp.servicio_id where s.empresa_id = 'b0000000-0000-4000-8000-000000000001' and s.activo) as servrep_demo_activos_igual_a_real;
