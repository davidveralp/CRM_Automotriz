-- =============================================================================
-- 0030_seed_radar_checklist_didial.sql
--
-- Qué resuelve:
--   Carga los 48 puntos reales de la lista de inspección de Didial
--   (compartida 2026-09-20, archivo radar.xlsx) a radar_checklist_items,
--   creada en 0029_radar_checklist.sql. La planilla original traía un
--   bloque de 5 filas de "TREN TRASERO" duplicado al final (copiado y
--   pegado dos veces) -se cargan una sola vez, no 53-.
-- =============================================================================

do $$
declare
  v_empresa_id uuid;
begin
  select id into v_empresa_id from public.empresas where nombre = 'Servicio Automotriz Didial Ltda.' limit 1;
  if v_empresa_id is null then
    raise exception 'No se encontró la empresa Didial; ajusta el nombre en esta migración.';
  end if;

  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN TRASERO', 'Amortiguadores traseros', 0) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN TRASERO', 'Bandejas traseras', 1) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN TRASERO', 'Bujes barra estabilizadora trasera', 2) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN TRASERO', 'Fuelles traseros', 3) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN TRASERO', 'Bieletas traseras', 4) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'PRUEBA EN RUTA', 'Vibración', 0) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'PRUEBA EN RUTA', 'Desviación de dirección', 1) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'PRUEBA EN RUTA', 'Ruidos anormales', 2) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'PRUEBA EN RUTA', 'Testigos encendidos en tablero', 3) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'LUCES', 'Altas', 0) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'LUCES', 'Bajas', 1) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'LUCES', 'Neblineros', 2) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'LUCES', 'Intermitentes', 3) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'LUCES', 'Posición', 4) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'LUCES', 'Patente', 5) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'LUCES', 'Freno', 6) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'LUCES', 'Reversa', 7) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'INTERIOR DEL VEHÍCULO', 'Bocina', 0) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'INTERIOR DEL VEHÍCULO', 'Plumillas', 1) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'INTERIOR DEL VEHÍCULO', 'Ventilación / flujo de aire', 2) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'INTERIOR DEL VEHÍCULO', 'Aire acondicionado', 3) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'INTERIOR DEL VEHÍCULO', 'Calefacción', 4) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'INTERIOR DEL VEHÍCULO', 'Freno de estacionamiento (¿largo?)', 5) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Nivel aceite motor', 0) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Nivel refrigerante', 1) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Estado líquido de frenos', 2) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Nivel limpiaparabrisas', 3) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Nivel dirección hidráulica', 4) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Estado filtro de aire', 5) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Estado filtro de cabina', 6) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Estado correa(s) de accesorios', 7) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'COMPARTIMIENTO MOTOR', 'Posibles fugas', 8) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'VEHÍCULO LEVANTADO — FRENOS Y NEUMÁTICOS', 'Estado de neumáticos (si está en mal estado, indicar medida)', 0) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'VEHÍCULO LEVANTADO — FRENOS Y NEUMÁTICOS', '% vida útil pastillas DELANTERAS', 1) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'VEHÍCULO LEVANTADO — FRENOS Y NEUMÁTICOS', 'Estado discos DELANTEROS', 2) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'VEHÍCULO LEVANTADO — FRENOS Y NEUMÁTICOS', '% vida útil pastillas TRASERAS (si aplica)', 3) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'VEHÍCULO LEVANTADO — FRENOS Y NEUMÁTICOS', 'Estado discos TRASEROS (si aplica)', 4) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'VEHÍCULO LEVANTADO — FRENOS Y NEUMÁTICOS', '% vida útil balatas (si aplica)', 5) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'VEHÍCULO LEVANTADO — FRENOS Y NEUMÁTICOS', 'Estado de tambores (si aplica)', 6) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Amortiguadores delanteros', 0) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Terminales', 1) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Axiales', 2) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Bieletas', 3) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Bujes barra estabilizadora', 4) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Bandejas', 5) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Holgura de masas', 6) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Rótulas', 7) on conflict (empresa_id, area, item) do nothing;
  insert into public.radar_checklist_items (empresa_id, area, item, orden) values (v_empresa_id, 'TREN DELANTERO', 'Fuelles homocinéticas', 8) on conflict (empresa_id, area, item) do nothing;
end $$;

select
  (select count(*) from public.radar_checklist_items) as items_esperado_48;