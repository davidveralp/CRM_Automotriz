-- =============================================================================
-- 0028_seed_catalogo_didial.sql
--
-- Qué resuelve:
--   Carga el catálogo real de servicios/precios de Didial (planilla
--   "Base de datos de precios Didial", compartida 2026-09-20) a las tablas
--   creadas en 0027_catalogo_servicios.sql. Generado por un script de
--   reconciliación (no a mano): la planilla original tenía 13 variantes de
--   "Tipo Vehículo" (tamaño y combustible mezclados) que se redujeron a las 4
--   categorías de carrocería que ya existen x bencina/diésel, según decidió
--   el cliente. El reporte completo de las decisiones tomadas (promedios,
--   fallbacks a "TODOS", servicios sin precio para algún tipo) quedó en
--   `reconciliar_catalogo.js` / su reporte, revisado con el cliente antes de
--   generar este archivo.
-- =============================================================================

do $$
declare
  v_empresa_id uuid;
  v_servicio_id uuid;
  v_repuesto_id uuid;
begin
  select id into v_empresa_id from public.empresas where nombre = 'Servicio Automotriz Didial Ltda.' limit 1;
  if v_empresa_id is null then
    raise exception 'No se encontró la empresa Didial; ajusta el nombre en esta migración.';
  end if;

  -- Repuestos (117)
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Accesorio GPS') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Accesorio turbo timer') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Aceite de caja de cambios') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Aceite de diferencial') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Aceite de dirección hidráulica') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Aceite de motor') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Aceite de transmisión automática') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Actuador ABS') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Actuador de airbag (pasajero)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Actuador de tracción 4x4') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'AdBlue') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Aditivo para filtro de partículas (FAP)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Agua/líquido limpiaparabrisas') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Alarma de retroceso') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Alarma de vehículo') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Alternador') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Amortiguador') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Ampolleta (bombilla)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Ampolleta de foco de carretera') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Ampolletas LED') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Arnés eléctrico (ramal)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Balatas de freno') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Baliza') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bandeja de suspensión') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Batería') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bieletas (barra estabilizadora)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bobina de encendido') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bocina') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bomba de agua') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bomba de alta presión (common rail)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bomba de dirección hidráulica') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bomba de embrague') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bomba de limpiaparabrisas') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bomba/cilindro maestro de frenos') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Boquillas lava-parabrisas (sapitos)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Botonera de alzavidrios') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Brazo de suspensión') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bujes de suspensión') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bujías') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Bujías de precalentamiento (diésel)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cable de freno de estacionamiento') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cadena de distribución') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Caja auxiliar de dirección') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Caja de transferencia') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Caliper (mordaza) de freno') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cardán') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cilindro de rueda (freno trasero)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cilindro esclavo de embrague') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cinta espiral (reloj) de airbag') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cinturón de seguridad') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Collarín de embrague (rodamiento de empuje)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Componente de caja de transferencia') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Compresor de aire acondicionado') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Condensador de A/C') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Correa auxiliar (poly-V o trapezoidal)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Correa de distribución') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Corta corriente (seguridad)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cremallera de dirección') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cruceta') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Cuna de suspensión (buje pivote)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Disco de embrague') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Discos de freno') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Eje palier/homocinético') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Espejo con cámara de retroceso') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Estanque de combustible') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Evaporador de A/C') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Filtro de aceite') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Filtro de aire') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Filtro de alta presión de combustible') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Filtro de combustible') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Filtro de partículas diésel (DPF)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Filtro de polen/habitáculo') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Focos faeneros') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Focos neblineros') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Gas refrigerante (A/C)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Guías/patines de cadena de distribución') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Intercooler') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Inyectores de combustible') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Líquido de frenos') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Líquido refrigerante') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Manguera flexible') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Manguera flexible de dirección hidráulica') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Manguera flexible de freno') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Mangueta (muñón) de dirección') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Motor completo') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Motor de arranque') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Motor/actuador EPS de dirección asistida') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Panel/control de ventilación') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Pastillas de freno') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Piola de embrague') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Piolas/cables de control de ventilación') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Plato de embrague (prensa)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Plumillas/escobillas limpiaparabrisas') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Pulmón de suspensión (neumática)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Punta/fuelle homocinético') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Radiador') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Radiador de calefacción') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Radio/equipo de audio') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Retén (sello)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Rodamiento de masa (rueda)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Rótula de suspensión') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Sensor de impacto') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Sensor de oxígeno (sonda lambda)') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Sensor de temperatura') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Sensor de velocidad de rueda') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Sensor de ángulo de dirección') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Sensores de retroceso') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Tambores de freno') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Tensor de cadena de distribución') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Tensor de correa de distribución') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Terminal regulador de freno') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Terminales axiales de dirección') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Triceta') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Turbocompresor') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Válvula SCV') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Yugo/soporte de suspensión trasera') on conflict (empresa_id, nombre) do nothing;
  insert into public.catalogo_repuestos (empresa_id, nombre) values (v_empresa_id, 'Golilla tapón de cárter') on conflict (empresa_id, nombre) do nothing;

  -- Servicios (340), con sus precios y repuestos sugeridos
  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC1', 'Diagnostico electronico A/C')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC10', 'Cambio piolas control ventilacion')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Piolas/cables de control de ventilación';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC11', 'Diagnostico electrico ventilacion')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC12', 'Ext y mont de flexible')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Manguera flexible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC2', 'Carga aire acondicionado')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.8, 38080, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.8, 38080, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.8, 38080, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.8, 38080, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Gas refrigerante (A/C)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC3', 'Diagnostico express')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC4', 'Reparacion de ramal')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 3, 142800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3, 142800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 3, 142800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Arnés eléctrico (ramal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC5', 'Cambio compresor A/C')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Compresor de aire acondicionado';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC6', 'Cambio condensador A/C')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Condensador de A/C';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC7', 'Cambio evaporador A/C')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 8, 380800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 8, 380800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 8, 380800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 8, 380800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Evaporador de A/C';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC8', 'Cambio sensor temperatura del evaporador (debe preguntar su ubicacion)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 8, 380800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 8, 380800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 8, 380800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 8, 380800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Sensor de temperatura';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'A/C y Calefacción', 'AC9', 'Cambio radiador calefaccion')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 8, 380800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 8, 380800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 8, 380800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 8, 380800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Radiador de calefacción';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'ABS', 'ABS1', 'Diagnostico electronico ABS')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'ABS', 'ABS2', 'Cambio actuador ABS')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Actuador ABS';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'ABS', 'ABS3', 'Cambio sensor de velocidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Sensor de velocidad de rueda';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'ABS', 'ABS4', 'Reparacion de ramal')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 3, 142800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3, 142800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 3, 142800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Arnés eléctrico (ramal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'ABS', 'ABS5', 'Cambio liquido de frenos')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.5, 23800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Líquido de frenos';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'ABS', 'ABS6', 'Escaner  funciones especiales')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Air Bag', 'AB1', 'Diagnostico electronico AIRBAG')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Air Bag', 'AB2', 'Cambio cinta airbag')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cinta espiral (reloj) de airbag';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Air Bag', 'AB3', 'Cambio sensor impacto frontal')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Sensor de impacto';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Air Bag', 'AB4', 'Cambio actuador acompañante')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Actuador de airbag (pasajero)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Air Bag', 'AB5', 'Cambio cinturon de seguridad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cinturón de seguridad';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Air Bag', 'AB6', 'Escaner  funciones especiales')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Arranque y Alternador', 'AA1', 'Desmontaje y montaje arranque O alternador baja complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.58, 27700, 60000, 120000, 9000, 'Solo si aplica, Mantención/ reparación arranque | $30.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.68, 32400, 60000, 120000, 9000, 'Solo si aplica, Mantención/ reparación arranque | $30.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.68, 32400, 60000, 120000, 9000, 'Solo si aplica, Mantención/ reparación arranque | $30.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, 60000, 120000, 9000, 'Solo si aplica, Mantención/ reparación arranque | $30.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Motor de arranque';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Alternador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Arranque y Alternador', 'AA2', 'Desmontaje y montaje arranque O alternador media complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Motor de arranque';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Alternador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Arranque y Alternador', 'AA3', 'Desmontaje y montaje arranque alta complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.09, 51884, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.09, 51900, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Motor de arranque';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Arranque y Alternador', 'AA4', 'Desmontaje y montaje alternador alta complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, 60000, 120000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Alternador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Arranque y Alternador', 'AA5', 'Mantencion Arranque')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, 60000, 120000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, 60000, 120000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 60000, 120000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.68, 32400, 60000, 120000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Motor de arranque';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Arranque y Alternador', 'AA6', 'Mantencion Alternador')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 60000, 120000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 60000, 120000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 60000, 120000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, 60000, 120000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Alternador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Correas Auxiliares', 'CA1', '1 Tipo pk sin complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.34, 16200, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.34, 16200, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16200, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 20000, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa auxiliar (poly-V o trapezoidal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Correas Auxiliares', 'CA2', '1 tipo  pk media complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 20000, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.58, 27700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa auxiliar (poly-V o trapezoidal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Correas Auxiliares', 'CA3', '1 Tipo pk alta complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 8000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa auxiliar (poly-V o trapezoidal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Correas Auxiliares', 'CA4', '1 Tipo V')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.34, 16200, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.34, 16184, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16200, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.34, 16200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa auxiliar (poly-V o trapezoidal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Correas Auxiliares', 'CA5', '1 Tipo V media complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 20000, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.58, 27700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa auxiliar (poly-V o trapezoidal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Correas Auxiliares', 'CA6', '1 Tipo V Alta complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.68, 32368, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.68, 32400, 6000, 20000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa auxiliar (poly-V o trapezoidal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Dirección', 'DI1', 'Cambio cremallera direccion mecanica')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2.5, 119000, null, null, null, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, null, null, null, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cremallera de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Dirección', 'DI2', 'Cambio cremallera direccion electro-asistida')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2.5, 119000, null, null, null, '1 | SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, '1 | SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, null, null, null, '1 | SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 3, 142800, null, null, null, '1 | SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cremallera de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Dirección', 'DI3', 'Cambio cremallera direccion hidraulica')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2.5, 119000, null, null, null, '1 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3, 142800, null, null, null, '1 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, null, null, null, '1 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 3, 142800, null, null, null, '1 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cremallera de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Dirección', 'DI4', 'Cambio flexible hidraulico')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '1 | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | $45.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, '1 | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | $45.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '1 | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | $45.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '1 | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | $45.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Manguera flexible de dirección hidráulica';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Dirección', 'DI5', 'Escaner funciones especiales')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Dirección', 'DI6', 'Cambio bomba de direccion hidraulica')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2, 95200, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de dirección hidráulica';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Dirección', 'DI7', 'Cambio sensor angulo de direccion')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Sensor de ángulo de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Dirección', 'DI8', 'Cambio amortiguador EPS')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 3, 142800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3, 142800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 3, 142800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Motor/actuador EPS de dirección asistida';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Distribución', 'DI1*', 'Kit correa distribucion express (BASICA)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 60000, 150000, 15000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 65000, 180000, 5000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 65000, 180000, 5000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Tensor de correa de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Distribución', 'DI2', 'Kit correa distribucion s/b. agua s/retenes')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3.75, 178500, 65000, 180000, 5000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, 65000, 180000, 5000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 4, 190400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Tensor de correa de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Distribución', 'DI3', 'kit correa distribucion  c/b. agua comp. Std')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2.5, 119000, null, null, null, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 4, 190400, 165000, 300000, 77000, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.75, 130900, 165000, 300000, 77000, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 4.25, 202300, null, null, null, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Tensor de correa de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de agua';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Distribución', 'DI4', 'kit correa distribucion  c/b. agua comp. Media')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2.75, 130900, null, null, null, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 4.25, 202300, 165000, 300000, 77000, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, 165000, 300000, 77000, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 4.5, 214200, null, null, null, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Correa de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Tensor de correa de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de agua';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Distribución', 'DI5', 'kit cadena distribucion s/sacar motor')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 6, 285600, null, null, null, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 10, 476000, 200000, 350000, 77000, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 10, 476000, 200000, 350000, 77000, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 13, 618800, null, null, null, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cadena de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Tensor de cadena de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Guías/patines de cadena de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Distribución', 'DI6', 'kit cadena distribucion sacar motor')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 9, 428400, null, null, null, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 14, 666400, 200000, 350000, 77000, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 14, 666400, 200000, 350000, 77000, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 17, 809200, null, null, null, '1 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cadena de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Tensor de cadena de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Guías/patines de cadena de distribución';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Ejes', 'EJ1', 'Ext y mont cardan')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.68, 32400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.68, 32400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.68, 32400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cardán';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Ejes', 'EJ2', 'Cambio cruceta (1 unidad)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 15000, 60000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 15000, 60000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cruceta';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Ejes', 'EJ3', 'Ext y mont eje palier (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 50000, 300000, 36000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 80000, 250000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 80000, 250000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Eje palier/homocinético';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Ejes', 'EJ4', 'Cambio punta y/o fuelle homocinetica (1 unidad)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 30000, 130000, 9000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 35000, 130000, 9000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 35000, 130000, 9000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Punta/fuelle homocinético';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Ejes', 'EJ5', 'Cambio triceta (1 unidad)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 30000, 130000, 36000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 45000, 150000, 9000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 45000, 150000, 9000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Triceta';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL1', 'Escaner')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL10', 'Limpieza admision escape y egr alta comp')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 15, 714000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 7, 333200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 7, 333200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 8, 380800, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL11', 'DIAGNOSTICO EXPRESS + SCANNER')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL2', 'Diagnostico')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL3', 'Regeneracion forzada')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL4', 'Limpieza quinto inyector')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL5', 'Mantension SCV')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.34, 63784, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.34, 63784, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.34, 63784, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Válvula SCV';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL6', 'Limpieza de MAF')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL7', 'Cambio de sensor de oxigeno')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Sensor de oxígeno (sonda lambda)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL8', 'Limpieza Admision escape y EGR')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 4, 190400, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 4, 190400, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 6, 285600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Electrónica Motor', 'EL9', 'Limpieza Admision escape y EGR media comp')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 12, 571200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 6, 285600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 6, 285600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 7, 333200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM1', 'Kit embrague cuna corta y sale')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 3.34, 159000, 63000, 180000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 5, 238000, 138000, 370000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 5, 238000, null, null, null, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Disco de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plato de embrague (prensa)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Collarín de embrague (rodamiento de empuje)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM10', 'Cilindro esclavo (+Insumos)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, 20000, 60000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, 20000, 60000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 20000, 60000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.83, 39600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cilindro esclavo de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM11', 'Piola de embrague')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, 30000, 100000, 9000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Piola de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM2', 'kit embrague cuna larga y sale')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 4, 190400, 63000, 180000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 5.5, 261800, 138000, 370000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 5, 238000, null, null, null, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Disco de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plato de embrague (prensa)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Collarín de embrague (rodamiento de empuje)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM3', 'kit de embrague extraccion cuna')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 7, 333200, 63000, 180000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 8, 380800, 138000, 370000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 10, 476000, null, null, null, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Disco de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plato de embrague (prensa)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Collarín de embrague (rodamiento de empuje)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM4', 'kit embrague alta dificultad extracción motor-caja')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 8, 380800, 63000, 180000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 10, 476000, 138000, 370000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 12, 571200, null, null, null, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Disco de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plato de embrague (prensa)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Collarín de embrague (rodamiento de empuje)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM6', 'Kit de embrague 4x2 Tracc trasera')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3, 142800, 140000, 395000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, 138000, 370000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, null, null, null, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Disco de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plato de embrague (prensa)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Collarín de embrague (rodamiento de empuje)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM7', 'kit de embrague 4x4 Tracc trasera')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 4.75, 226100, 140000, 395000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 4.25, 202300, 138000, 370000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 6, 285600, null, null, null, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Disco de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plato de embrague (prensa)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Collarín de embrague (rodamiento de empuje)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM8', 'kit de embrague extraccion barras')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 6, 285600, 140000, 395000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 6, 285600, 138000, 370000, 115000, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 6, 285600, null, null, null, '1 | 1 | SI | SI | SI | Rectificado de volante de inercia (solo si aplica) | $65.000 | Solo si aplica, reparación de deslizante de caja | $140.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Disco de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plato de embrague (prensa)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Collarín de embrague (rodamiento de empuje)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Embrague', 'EM9', 'Bomba de embrague (+Insumos)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 40000, 100000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 40000, 100000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.83, 39600, 40000, 100000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.09, 51900, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de embrague';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN1', 'Bujias')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.34, 16200, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16200, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujías';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN2', 'Bujias extracción cubre motor, bobinas o cables')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.34, 16200, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.34, 16200, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16200, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.34, 16200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujías';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN3', 'Bujias extracción de multiple de admisión')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.09, 51900, 15000, 120000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujías';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN4', 'Bujias incandescentes NI-terrano-navara actyon 13-18')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujías de precalentamiento (diésel)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN5', 'Bujias incandescentes TY-hilux 05-10')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujías de precalentamiento (diésel)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN6', 'Bujias incandescentes TY-hilux 11-15')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 5, 238000, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 6, 285600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujías de precalentamiento (diésel)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN7', 'Cables de bujias')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8100, 20000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4300, 20000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4300, 20000, 50000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8100, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujías';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN8', 'Bobina de encendido (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.34, 16200, 30000, 100000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, 30000, 100000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, 30000, 100000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bobina de encendido';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN9', 'Bobina de encendido extracción multiple')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 30000, 100000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, 30000, 100000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.09, 51900, 30000, 100000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.5, 71400, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bobina de encendido';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN9', 'Bateria')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.12, 5800, 50000, 90000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4300, 50000, 90000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4300, 50000, 90000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4300, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Batería';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN9', 'Limpieza de cuerpo de aceleración')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 20000, 50000, 90000, 5000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 20000, 50000, 90000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 20000, 50000, 90000, 5000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 20000, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Encendido', 'EN9*', 'Limpieza de extractor de ventilación bateria hibrida')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.58, 27700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.58, 27700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.58, 27700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.58, 27700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR1', 'Mantencion  frenos de discos delanteros')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 20000, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 20000, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 20000, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.42, 20000, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1, 47600, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR10', 'Mantencion  frenos de discos traseros')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.58, 27700, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.58, 27700, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1, 47600, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR11', 'Pastillas traseras')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, 30000, 65000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.58, 27700, 35000, 75000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, 30000, 80000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.58, 27700, 35000, 75000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1, 47600, 45000, 155000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR12', 'Pastillas Traseras C/herramienta (+Insumos)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, 30000, 65000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, 35000, 75000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 30000, 80000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.75, 35700, 35000, 75000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.25, 59500, 45000, 155000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR13', 'Pastillas Traseras ELECTRICO con escaner (+Insumos)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.92, 43800, 30000, 65000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.92, 43800, 35000, 75000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.92, 43800, 30000, 80000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.92, 43800, 35000, 75000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.5, 71400, 45000, 155000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR14', 'Discos flot y pastillas traseras (para cambio o rectificado)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 100000, 155000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 155000, 205000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 140000, 180000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.25, 59500, 155000, 205000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.75, 83300, 175000, 350000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR15', 'Discos flot y pastillas traseras c/herramienta')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 100000, 135000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.42, 67600, 155000, 205000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.09, 51900, 140000, 180000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.42, 67600, 155000, 205000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 175000, 35000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR16', 'Discos flot (rod masa a presion)  y pastillas traseras c/escaner')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 135000, 175000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, 155000, 205000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 160000, 220000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.5, 71400, 155000, 205000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2.5, 119000, 175000, 350000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR17', 'Balatas y tambores (+Insumos)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 93000, 138000, 7000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 150000, 200000, 7000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 100000, 150000, 7000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1, 47600, 150000, 200000, 7000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 225000, 325000, 7000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Tambores de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Balatas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR18', 'Mantencion  2 calipers traseros')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 30000, 50000, 22000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.75, 83300, 30000, 50000, 22000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.75, 83300, 30000, 50000, 22000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.75, 83300, 30000, 50000, 22000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.75, 83300, 50000, 100000, 22000, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Caliper (mordaza) de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR19', 'Mantencion  2 calipers traseros electronico')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 60000, 80000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, 60000, 80000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, 60000, 80000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 2, 95200, 60000, 80000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 70000, 100000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Caliper (mordaza) de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR2', 'Pastillas delanteras')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 20000, 25000, 60000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 20000, 35000, 70000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, 30000, 70000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.42, 20000, 35000, 70000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1, 47600, 55000, 110000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR20', 'Extrac y mont de caliper traseros para reparacion (+ serv. tornería)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 20000, 55000, 55000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 20000, 55000, 55000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 20000, 55000, 55000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.42, 20000, 55000, 55000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1, 47600, 55000, 55000, 20000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Caliper (mordaza) de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR21', 'Extrac y mont de caliper elec/herramienta traseros para reparacion (+ serv. tornería)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, 55000, 55000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 20000, 55000, 55000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 55000, 55000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.42, 20000, 55000, 55000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1, 47600, 55000, 55000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Caliper (mordaza) de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR22', 'Regulacion de frenos por detrás')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.34, 16200, 0, 0, 0, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.34, 16200, 0, 0, 0, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16200, 0, 0, 0, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.34, 16200, 0, 0, 0, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 0.42, 20000, 0, 0, 0, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR23', 'Regulacion de frenos (mantension) desmontar tambores y consola')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 0, 0, 7000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 0, 0, 7000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 0, 0, 7000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1, 47600, 0, 0, 7000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 0, 0, 7000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Tambores de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Balatas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR24', 'Bomba de frenos')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1, 47600, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1, 47600, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba/cilindro maestro de frenos';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR25', 'Bomba de frenos alta complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.5, 71400, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.5, 71400, 0, 0, 20000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba/cilindro maestro de frenos';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR26', '1 Piola lateral (freno estacionamiento)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 45000, 120000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 45000, 120000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 45000, 120000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.25, 59500, 45000, 120000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.5, 71400, 65000, 155000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cable de freno de estacionamiento';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR27', 'Ext y montaje de cilindros de frenos traseros (para cambiar o reparar)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 12000, 36000, 20000, 'IN3 | 1 | AGREGAR 1 LIQUIDO DE FRENOS | Reparacion de 1 cilindro de frenos | $20.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 12000, 36000, 20000, 'IN3 | 1 | AGREGAR 1 LIQUIDO DE FRENOS | Reparacion de 1 cilindro de frenos | $20.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, 12000, 36000, 20000, 'IN3 | 1 | AGREGAR 1 LIQUIDO DE FRENOS | Reparacion de 1 cilindro de frenos | $20.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.25, 59500, 12000, 36000, 20000, 'IN3 | 1 | AGREGAR 1 LIQUIDO DE FRENOS | Reparacion de 1 cilindro de frenos | $20.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 160000, 225000, 30000, 'IN3 | 1 | AGREGAR 1 LIQUIDO DE FRENOS | Reparacion de 1 cilindro de frenos | $20.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cilindro de rueda (freno trasero)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR3', 'Discos flot. y pastillas delanteras para cambiar.')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.83, 39600, 100000, 155000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 155000, 280000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.83, 39600, 140000, 220000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1, 47600, 155000, 280000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.5, 71400, 195000, 330000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR4', 'Discos flot. y pastillas delanteras para rectificar')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.83, 39600, 55000, 85000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 60000, 90000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.83, 39600, 60000, 90000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1, 47600, 60000, 90000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.5, 71400, 80000, 135000, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR5', 'Discos flot APERNADO y pastillas delanteras (para cambiar o para rectificar)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 100000, 155000, 7000, '1 | AGREGAR RODAMIENTOS DE MASAS')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.75, 83300, 155000, 280000, 7000, '1 | AGREGAR RODAMIENTOS DE MASAS')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.75, 83300, 140000, 220000, 7000, '1 | AGREGAR RODAMIENTOS DE MASAS')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.75, 83300, 155000, 280000, 7000, '1 | AGREGAR RODAMIENTOS DE MASAS')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.5, 71400, 140000, 330000, 7000, '1 | AGREGAR RODAMIENTOS DE MASAS')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR6', 'Rectificado de discos delanteros, traseros y tambores')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 24000, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.5, 23800, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 0.75, 35700, 0, 0, 2000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Discos de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pastillas de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR7', 'Extrac y mont de porta caliper delanteros para reparacion (+ S. EXT)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 20000, 55000, 55000, 2000, '1 | Reparación de caliper de freno 2 Unidades | 45000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 20000, 55000, 55000, 2000, '1 | Reparación de caliper de freno 2 Unidades | 45000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 20000, 55000, 55000, 2000, '1 | Reparación de caliper de freno 2 Unidades | 45000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.42, 20000, 55000, 55000, 2000, '1 | Reparación de caliper de freno 2 Unidades | 45000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 0.75, 35700, 55000, 55000, 2000, '1 | Reparación de caliper de freno 2 Unidades | 45000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Caliper (mordaza) de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR8', 'Mantension  2 calipers delanteros (+Insumos)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, 30000, 50000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.75, 83300, 45000, 65000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, 30000, 50000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.75, 83300, 45000, 65000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 45000, 65000, 22000, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Caliper (mordaza) de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Frenos', 'FR9', '1 Flexible (+Insumos)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, 30000, 45000, 22000, '1 | AGREGAR LIQUIDO DE FRENOS | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | 16')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, 35000, 60000, 22000, '1 | AGREGAR LIQUIDO DE FRENOS | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | 16')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, 30000, 45000, 22000, '1 | AGREGAR LIQUIDO DE FRENOS | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | 16')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.5, 23800, 35000, 60000, 22000, '1 | AGREGAR LIQUIDO DE FRENOS | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | 16')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 0.5, 23800, 35000, 80000, 22000, '1 | AGREGAR LIQUIDO DE FRENOS | Solo si aplica, Confección 1 flexibles hidraulicos, Valor aprox dependiendo de que tipo de material a usar | 16')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Manguera flexible de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC1', 'Extracción y montaje inyectoresTY-hilux 05-10 Ni-Navara')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Inyectores de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC10', 'Extraccion y montaje bomba alta presión TY-hilux 10-15 NI-navara MT-L200')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 5.5, 261800, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de alta presión (common rail)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC11', 'Extraccion y montaje bomba alta presión TY-hilux 16-24 MT-L200')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 6.5, 309400, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 6.5, 309400, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 3.5, 166600, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de alta presión (common rail)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC12', 'Escaner funciones especiales')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC2', 'Extracción y montaje inyectores TY-hilux 11-15 Ni-Navara GM-dmax')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3.5, 166600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Inyectores de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC3', 'Extracción y montaje inyectores TY-hilux 16-21 MI-L200 10-21')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2.75, 130900, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Inyectores de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC4', 'Ext y montaje de inyectores bencineros de facil acceso (S. EXT $ 40.000 4 UNIDADES)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '2 | Mantencion de inyectores bencineros por ultrasonido | $40.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, '2 | Mantencion de inyectores bencineros por ultrasonido | $40.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '2 | Mantencion de inyectores bencineros por ultrasonido | $40.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, '2 | Mantencion de inyectores bencineros por ultrasonido | $40.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Inyectores de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC5', 'Ext y montaje de inyectores bencineros de dificil acceso V6')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, '2 | Mantencion de inyectores bencineros por ultrasonido | $40.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, '2 | Mantencion de inyectores bencineros por ultrasonido | $40.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Inyectores de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC6', 'Mantención bomba alta presión TY-hilux HP3-4 NI-TY-MT (05-15 NO INCLUYE EXTRACCION)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2, 95200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de alta presión (common rail)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC7', 'Extracción y montaje de estanque combustible')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2, 95200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Estanque de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC8', 'Limpieza de estaque fuera del vehiculo')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Estanque de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Inyección Combustible', 'IC9', 'Extracción y montaje bomba alta presión TY-hilux 05-10')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3, 142800, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, null, null, null, '2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de alta presión (common rail)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M1', 'Cambio motor')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 6, 285600, null, null, null, '1 | 1 | 2 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 8, 380800, null, null, null, '1 | 1 | 2 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 7, 333200, null, null, null, '1 | 1 | 2 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 8, 380800, null, null, null, '1 | 1 | 2 | 2')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Motor completo';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M10', 'Cambio radiador ( solo para vehiculos que aun funcionan bien)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Radiador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M2', 'Ext y mont intercooler (superior)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, null, null, null, '1 | 1 | Sellado de intercooler | $65.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, null, null, null, '1 | 1 | Sellado de intercooler | $65.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.5, 23800, null, null, null, '1 | 1 | Sellado de intercooler | $65.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Intercooler';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M2', 'Ext y mont intercooler (frontal)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Intercooler';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M3', 'Ext y mont DPF')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3.5, 166600, null, null, null, '1 | 1 | Limpieza de DPF | $105.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3.5, 166600, null, null, null, '1 | 1 | Limpieza de DPF | $105.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 3.5, 166600, null, null, null, '1 | 1 | Limpieza de DPF | $105.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de partículas diésel (DPF)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M4', 'Cambio turbo hilux 05-11')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Turbocompresor';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M5', 'Cambio turbo hilux 12-15')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 4, 190400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 4, 190400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Turbocompresor';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M6', 'Cambio turbo hilux 16-')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 4, 190400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 4, 190400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Turbocompresor';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M7', 'Limpieza admision-EGR hilux 05-11')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3, 142800, null, null, null, '1 | 1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, null, null, null, '1 | 1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M8', 'Limpieza admision-EGR hilux 12-15')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 6, 285600, null, null, null, '1 | 1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 6, 285600, null, null, null, '1 | 1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Mecánica Motor', 'M9', 'Limpieza admision-EGR hilux 16-24')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 8, 380800, null, null, null, '1 | 1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 8, 380800, null, null, null, '1 | 1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Sistema Tracción 4x4', 'ST1', 'Diagnostico electronico 4WD')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Sistema Tracción 4x4', 'ST2', 'Cambio actuador caja transferencia')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Actuador de tracción 4x4';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Sistema Tracción 4x4', 'ST3', 'Cambio actuador caja dif delantero')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Actuador de tracción 4x4';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Sistema Tracción 4x4', 'ST4', 'Reparacion de ramal')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3, 142800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Arnés eléctrico (ramal)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Sistema Tracción 4x4', 'ST5', 'Ext y mont de caja transferencia')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, null, null, null, '1')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Caja de transferencia';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Sistema Tracción 4x4', 'ST6', 'Diagnostico y cambio comp caja transfer.')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 6, 285600, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 6, 285600, null, null, null, '3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Componente de caja de transferencia';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Suspensión', 'SU1', 'amortiguador 2 del- ojo-punta delanteros o traseros')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 80000, 250000, 9000, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 130000, 220000, 9000, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Amortiguador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Suspensión', 'SU2*', 'Amortiguador 2 del. Macpearson Y/O cazoletas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.75, 83300, 90000, 150000, 9000, 'SI, ver tabla | Cambio de amortiguadores (cuando no es en Didial) | $35.000 C/U | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 120000, 260000, 9000, 'SI, ver tabla | Cambio de amortiguadores (cuando no es en Didial) | $35.000 C/U | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 100000, 260000, 9000, 'SI, ver tabla | Cambio de amortiguadores (cuando no es en Didial) | $35.000 C/U | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.25, 59500, null, null, null, 'SI, ver tabla | Cambio de amortiguadores (cuando no es en Didial) | $35.000 C/U | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Amortiguador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Suspensión', 'SU3', 'Amortiguador 2 del. Macpearson Alta complejidad')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2, 95200, 90000, 150000, 9000, 'SI, ver tabla | Cambio de amortiguadores (cuando no es en Didial) | $35.000 C/U')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, 120000, 260000, 9000, 'SI, ver tabla | Cambio de amortiguadores (cuando no es en Didial) | $35.000 C/U')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2, 95200, 100000, 260000, 9000, 'SI, ver tabla | Cambio de amortiguadores (cuando no es en Didial) | $35.000 C/U')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.75, 83300, null, null, null, 'SI, ver tabla | Cambio de amortiguadores (cuando no es en Didial) | $35.000 C/U')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Amortiguador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Suspensión', 'SU4', 'amortiguador tras, Macpearson')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.75, 83300, 60000, 150000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.75, 83300, 90000, 240000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.75, 83300, null, null, null, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Amortiguador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Suspensión', 'SU5', 'Amortiguador tras ojo-ojo')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.92, 43800, 40000, 90000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 80000, 160000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 40000, 100000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Amortiguador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Suspensión', 'SU6', 'Amortiguador tras, ojo-punta')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 40000, 90000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.09, 51900, 8000, 160000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.09, 51900, 90000, 240000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.09, 51900, null, null, null, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Amortiguador';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Suspensión', 'SU7', 'Pulmon suspension')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 3, 142800, null, null, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, null, 0, null, null, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3, 142800, null, null, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, null, 0, null, null, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Pulmón de suspensión (neumática)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD1', 'Axiales 2, terminales 2')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 60000, 80000, 9000, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 60000, 90000, 9000, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 60000, 90000, 9000, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, 60000, 90000, 9000, 'SI, ver tabla | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Terminales axiales de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD10', 'Rotula superior a presion(1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, 35000, 60000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 35000, 50000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, 35000, 60000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Rótula de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD11', 'Bieletas (2) con ext de ruedas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.68, 32400, 30000, 45000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.58, 27700, null, null, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.68, 32400, 35000, 60000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.58, 27700, null, null, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bieletas (barra estabilizadora)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD12', 'Bujes barra estabilizadora (2)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, 10000, 25000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.83, 39600, 15000, 35000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 10000, 25000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.83, 39600, 15000, 35000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujes de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD13', 'Bujes barras tensoras')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.92, 91400, 15000, 35000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.92, 91400, 15000, 35000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujes de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD14', 'Cremallera direccion y alineacion')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 3, 142800, 120000, 220000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 4, 190400, 200000, 300000, 27000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 4, 190400, 250000, 400000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 4, 190400, 200000, 300000, 27000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cremallera de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD15', 'Cuna corta')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 3, 142800, 120000, 220000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 4, 190400, 250000, 400000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cuna de suspensión (buje pivote)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD16', 'Cuna larga')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 3.75, 178500, 120000, 220000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 5.4, 257100, 250000, 400000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cuna de suspensión (buje pivote)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD17', 'Caja auxiliar de direccion')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, null, null, null, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 35000, 70000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, null, null, null, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Caja auxiliar de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD18', 'Rodamiento masa  Y masa delantero a presión (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.17, 55700, 50000, 80000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.34, 63800, 140000, 180000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 40000, 70000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.34, 63800, 140000, 180000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Rodamiento de masa (rueda)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD19', 'Rodamiento de masa ajustable  delantero (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 45000, 70000, 14000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.34, 63800, 100000, 150000, 14000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 45000, 70000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.34, 63800, 100000, 150000, 14000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 150000, 180000, 14000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Rodamiento de masa (rueda)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD2*', 'Terminales y/o fuelles de direccion (2)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.83, 39600, 38000, 60000, 9000, 'SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.83, 39600, 25000, 45000, 9000, 'SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.83, 39600, 38000, 60000, 9000, 'SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 0.83, 39600, 25000, 45000, 9000, 'SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.83, 87200, 50000, 90000, 9000, 'SI, ver tabla | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Terminales axiales de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD20', 'Muñón 1 por lado')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.17, 55700, 105000, 220000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.34, 63800, 120000, 280000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 120000, 250000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.34, 63800, 120000, 280000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 150000, 300000, 30000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Mangueta (muñón) de dirección';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD3', 'Bandeja inferior (PAR)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.25, 59500, 80000, 130000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2, 95200, 180000, 300000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, 120000, 220000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2, 95200, 180000, 300000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bandeja de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD4', 'Bandeja superior (PAR)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.75, 83300, 90000, 150000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.75, 83300, 60000, 120000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.75, 83300, 90000, 150000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bandeja de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD5', 'Bandeja inferior c/barra torcion (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2.5, 119000, 60000, 120000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, 60000, 120000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bandeja de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD6', 'Bandeja superior c/barra torcion (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2.5, 119000, 90000, 150000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2.5, 119000, 90000, 150000, 9000, 'IN3 | Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bandeja de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD7', 'Rotula inferior Apernada (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.68, 32400, 28000, 40000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, 35000, 60000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 35000, 50000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, 35000, 60000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Rótula de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD8', 'Rotula superior apernada (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, 35000, 60000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 35000, 50000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, 35000, 60000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Rótula de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Delantero', 'TD9', 'Rotula inferior a presion (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 28000, 40000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 35000, 60000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 35000, 50000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.25, 59500, 35000, 60000, 9000, 'IN3 | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Rótula de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT1', 'Rodamiento de masa a presion (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, 30000, 45000, 9000, '1 | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 30000, 50000, 9000, '1 | Alineacion auto-suv-camioneta | 24000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Rodamiento de masa (rueda)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT10', 'Cambio yugo o cuna semi-chasis')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2.75, 130900, 60000, 9000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 3.75, 178500, 1200000, 1400000, 36000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 3.25, 154700, 80000, 150000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 3.75, 178500, 1200000, 1400000, 36000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Yugo/soporte de suspensión trasera';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT2', 'Rodamiento-masa Conjunto (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, 60000, 90000, 9000, '1 | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 60000, 120000, 9000, '1 | Alineación con cuadratura de chasis | 70000 | por cada rueda de cuadratura (la alineación es aparte)')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Rodamiento de masa (rueda)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT2', 'Cambio reten manga diferencial (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 18000, 35000, 36000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, 18000, 35000, 36000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.25, 59500, 18000, 35000, 36000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 2, 95200, 30000, 60000, 14000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Retén (sello)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT3', 'Cambio reten pinon de ataque')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 25000, 50000, 36000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 25000, 50000, 36000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'bencina', 1.25, 59500, 25000, 50000, 36000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', 'diesel', 1.5, 71400, 40000, 100000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Retén (sello)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT4', 'Cambio bujes tras paquete resorte')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, 40000, 60000, 9000, 'IN3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.25, 59500, 40000, 60000, 9000, 'IN3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bujes de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT5', 'Cambio brazo arrastre (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 50000, 80000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Brazo de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT6', 'cambio Brazo control (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 50000, 80000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Brazo de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT7', 'Cambio bandeja inferior (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, 50000, 80000, 9000, 'Solo si aplica, Confección de buje (gomero) $25.000 C/U | SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bandeja de suspensión';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT8', 'cambio bieletas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, 35000, 50000, 9000, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bieletas (barra estabilizadora)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Tren Trasero', 'TT9', 'Cambio terminal regulador')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, 50000, 80000, 9000, 'SI, ver tabla')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Terminal regulador de freno';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC1', 'GPS')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Accesorio GPS';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC10', 'ALARMA RETROCESO')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Alarma de retroceso';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC11', 'SENSORES RETROCESO')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Sensores de retroceso';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC12', 'ESPEJO CON CAMARA')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Espejo con cámara de retroceso';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC13', 'BALIZA')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Baliza';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC14', 'FOCOS FAENEROS')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Focos faeneros';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC15', 'Panel control ventilacion (consultar)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Panel/control de ventilación';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC16', 'Revision electrica de 1 cto de luces (consultar)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC17', 'Ext y montaje de botoneras de alzavidrio (para cambio o reparacion)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, null, null, null, 'Reparación de botoneras de alzavidrio 1 unid | $15.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, null, null, null, 'Reparación de botoneras de alzavidrio 1 unid | $15.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, null, null, null, 'Reparación de botoneras de alzavidrio 1 unid | $15.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.5, 23800, null, null, null, 'Reparación de botoneras de alzavidrio 1 unid | $15.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Botonera de alzavidrios';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC2', 'TURBO TIMER')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Accesorio turbo timer';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC3', 'CORTA CORRIENTE')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Corta corriente (seguridad)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC4', 'RADIO')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 11, 523600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Radio/equipo de audio';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC5', 'ALARMA')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Alarma de vehículo';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC6', 'NEBLINEROS')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.25, 59500, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.25, 59500, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.25, 59500, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Focos neblineros';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC7', 'AMPOLLETAS LED CARRETERA')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolletas LED';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC8', 'Luz de carretera  HB11 (1) acceso dificutuoso')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta de foco de carretera';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Accesorios', 'ACC9', 'CAMBIO BOCINA')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bocina';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Alineación', 'ALIN-1', 'Alineación auto/SUV')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Alineación', 'ALIN-2', 'Alineación camioneta')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Alineación', 'ALIN-3', 'Alineación minibús')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Alineación', 'ALIN-4', 'Cuadratura')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM1', 'Trasera por lado (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM10', 'Posicion Frontal acceso superior (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM11', 'Posicion Frontal acceso inferior (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM12', 'Posicion frontal extracciòn de foco (2)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM13', 'Plafonier o mapa')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM14', 'Panel de instrumentos (consultar)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM15', 'Panel control ventilacion (consultar)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.83, 39508, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Panel/control de ventilación';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM16', 'Revision electrica de 1 cto de luces (consultar)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.5, 23800, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM2', 'Patente desmontable (2)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM3', 'Patente desmontar panel interior (2)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM4', '3º luz de frenos')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, 'Existe la posibilidad de que 1 de cada 10 autos utilice rostoff y limpia contacto')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, 'Existe la posibilidad de que 1 de cada 10 autos utilice rostoff y limpia contacto')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, 'Existe la posibilidad de que 1 de cada 10 autos utilice rostoff y limpia contacto')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, 'Existe la posibilidad de que 1 de cada 10 autos utilice rostoff y limpia contacto')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM5', '3º luz de frenos desm. panel interior')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.25, 11900, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM6', 'Intermitente lateral (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM7', 'Luz de carretra H4 (1) acceso libre')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM8', 'Luz de carretera  HB11 (1) acceso dificutuoso')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta de foco de carretera';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Ampolletas', 'AM9', 'Neblinero H7-H11 (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Ampolleta (bombilla)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI1', 'Aire  con grillete')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.04, 1904, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de aire';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI10', 'Filtro de combustible interior estanque (sin desmontar)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, 'IN7')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, 'IN7')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.25, 59500, null, null, null, 'IN7')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, 'IN7')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI11', 'Filtro de combustible interior estanque (desmontar estanque)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 2, 95200, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 2.5, 119000, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 2.5, 119000, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 2, 95200, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI2', 'Aire con tornillos')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.1, 4760, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.1, 4760, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.1, 4760, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de aire';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI3*', 'Filtro petroleo elemento')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI4', 'Filtro petroleo  y bencina metalico')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI5', 'Filtro de petroleo racor')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI6', '1 Filtro de polen detrás  guantera')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de polen/habitáculo';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI7', '2 filtro de polen detrás guantera')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de polen/habitáculo';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI8', 'Filtro de polen costado reposapies')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de polen/habitáculo';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Filtros', 'FI9', 'Filtro de alta presión combustible HILUX-FORTUNER SW4')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de alta presión de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL1', 'Aceite motor y filtro (lata o elemento  0,34)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, '15000 | Si el cliente trae aceite motor y filtro')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, '15000 | Si el cliente trae aceite motor y filtro')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, '15000 | Si el cliente trae aceite motor y filtro')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.3, 14280, null, null, null, '15000 | Si el cliente trae aceite motor y filtro')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de motor';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de aceite';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL10', 'Aceite direcciòn hidraulica')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 19992, null, null, null, '5')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, '5')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 19992, null, null, null, '5')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, '5')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de dirección hidráulica';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL11', 'Engrase cardanes y crucetas 4x2')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.26, 12376, null, null, null, 'IN3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, null, null, null, 'IN3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.26, 12376, null, null, null, 'IN3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cardán';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL12', 'Engrase cardanes y crucetas 4x4')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.34, 16184, null, null, null, 'IN3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16184, null, null, null, 'IN3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.34, 16184, null, null, null, 'IN3')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Cardán';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL13', 'Llenado limpiaparabrisas y/o agua desmineralizada')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.02, 952, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.02, 952, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.02, 952, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.02, 952, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Agua/líquido limpiaparabrisas';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL14', 'Llenado deposito auxiliar  refrigerante')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.02, 952, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.02, 952, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.02, 952, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.02, 952, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Líquido refrigerante';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL15', 'Extaccion de combustible (sin desmontar estanque)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.34, 63784, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.34, 63784, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.34, 63784, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1.34, 63784, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL16', 'Carga de adblue')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'AdBlue';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL17', 'Carga de aditivo FAP')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aditivo para filtro de partículas (FAP)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL18', 'Cambio refrigerante motor (TOYOTA LCC 62.000 4L)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, 'IN7')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, 'IN7')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, 'IN7')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Líquido refrigerante';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL19', 'Cambio aceite A/T Con tapones (SOLO TOYOTA T-IV 30.000 1L')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de transmisión automática';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL19', 'Cambio aceite A/T Y FILTRO (SOLO TOYOTA WS 35.000 1L')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, 'IN8')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de transmisión automática';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL2', 'Aceite Caja de cambios manual acceso directo')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.34, 16184, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de caja de cambios';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL3', 'Aceite Caja de cambios manual dificultad de acceso')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.34, 16184, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.34, 16184, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16184, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de caja de cambios';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL4', 'Aceite caja Transferencia 4x4')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16184, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de caja de cambios';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL5', 'Aceite diferencial delantero')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de diferencial';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL6', 'Aceite diferencial delantero o trasero con carter')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de diferencial';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL7', 'Aceite diferencial trasero')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.25, 11900, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de diferencial';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL8', 'Liquido de frenos')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.5, 23800, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.5, 23800, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.5, 23800, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.5, 23800, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Líquido de frenos';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Fluidos (Lubricación y Engrase)', 'FL9', 'Liquido de frenos con escaner')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1, 47600, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1, 47600, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1, 47600, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, 'IN6')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Líquido de frenos';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN1', 'Revisión preventiva general (con informe en tablet 3 hojas)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.75, 35700, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN10', 'Liquidos compartimiento motor')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN11', 'inspección audio cargador de celular')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.21, 9996, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.21, 9996, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.21, 9996, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.21, 9996, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN2*', 'Revisión express (Solo observaciones al final de la OT)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN3*', 'Revisión específica (Ej. Ruido, frenos o rechazo PRT)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.34, 16184, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.34, 16184, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.34, 16184, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.34, 16184, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN4', 'Escaner')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN5', 'Rev. Aceite Caja de cambios manual / dificultad de acceso')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de caja de cambios';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN6*', 'Rev Aceite caja Transferencia 4x4')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.1, 4760, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.1, 4760, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de caja de cambios';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN7', 'Rev Aceite diferencial delantero')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.17, 8092, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de diferencial';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN8', 'Rev Aceite diferencial delantero o trasero con carter')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de diferencial';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Inspecciones', 'IN9', 'Rev.Aceite diferencial trasero')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.1, 4760, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.1, 4760, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de diferencial';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Plumillas', 'PL1', '2 Plumillas STD')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.05, 2380, null, null, null, 'NOTA:Ofrecer limpiaparabrisas de 1L o de 5L')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.05, 2380, null, null, null, 'NOTA:Ofrecer limpiaparabrisas de 1L o de 5L')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.05, 2380, null, null, null, 'NOTA:Ofrecer limpiaparabrisas de 1L o de 5L')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, 'NOTA:Ofrecer limpiaparabrisas de 1L o de 5L')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plumillas/escobillas limpiaparabrisas';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Plumillas', 'PL2', '1 Plumilla trasera  UNIVERSAL')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.05, 2380, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.05, 2380, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.05, 2380, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plumillas/escobillas limpiaparabrisas';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Plumillas', 'PL3', 'Mantencion mecanismo plumillas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 1.5, 71400, null, null, null, 'Reparacion brazo articulacion plumilla (1) | $45.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 1.5, 71400, null, null, null, 'Reparacion brazo articulacion plumilla (1) | $45.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 1.5, 71400, null, null, null, 'Reparacion brazo articulacion plumilla (1) | $45.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 1, 47600, null, null, null, 'Reparacion brazo articulacion plumilla (1) | $45.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plumillas/escobillas limpiaparabrisas';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Plumillas', 'PL4', '2 Destapar sapitos lanza agua')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.09, 4284, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Boquillas lava-parabrisas (sapitos)';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Plumillas', 'PL5', 'Rev. Elec. bomba limpiaparabrisas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'furgon', null, 0.42, 19992, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Bomba de limpiaparabrisas';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Plumillas', 'PL6', 'Cambio repuestos de plumillas (NO SE REALIZA)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Plumillas/escobillas limpiaparabrisas';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'BAL-NE', 'Balanceo 1 neumático')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'CAM-NE', 'Cambio de neumático (1) sin balanceo (sin sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'CAM-NE-BAL', 'Cambio de neumático (1) con balanceo (sin sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'CAM-NE-BAL-S', 'Cambio de neumático (1) con balanceo (con sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'CAM-NE-S', 'Cambio de neumático (1) sin balanceo (con sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'CAM-VAL', 'Cambio de válvula (válvula STD incluida)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'PARCHE', 'Parche adicional')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'ROT-NE', 'Rotación de neumáticos (4) sin balanceo')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'ROT-NE-BAL', 'Rotación de neumáticos (4) con balanceo')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VALVULA', 'Válvula VTR413N negra (adicional)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-B-S', 'Vulcanización rueda por mano, sin balanceo (con sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-M', 'Vulcanización rueda por mano, sin balanceo (sin sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-MB', 'Vulcanización rueda por mano, con balanceo (sin sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-MB-S', 'Vulcanización rueda por mano, con balanceo (con sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-ME', 'Vulcanización media sin balanceo (sin sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-ME-BAL', 'Vulcanización media con balanceo (sin sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-ME-BAL-S', 'Vulcanización media con balanceo (con sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-ME-S', 'Vulcanización media sin balanceo (con sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-PC', 'Vulcanización parche en caliente (sin sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Servicio Rápido', 'Vulcanización', 'VUL-PC-S', 'Vulcanización parche en caliente (con sensor)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP1', 'Pintura y desabolladura por unidad - Pieza 1')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '3 días | IN4: $20.000 por pieza')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP10', 'Cambio vidrio ventana (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '45 min')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP11', 'Cambio vidrio aleta (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '45 min')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP12', 'Cambio foco posterior (trasero) c/u')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '10 min')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP13', 'Cambio foco frontal (delantero) c/u')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '20 min')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP14', 'Cambio focos neblineros (par)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '45 min')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP15', 'Cambio guardafango')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '20 min')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP16', 'Pulido carrocería completa auto')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '2 días')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP17', 'Pulido carrocería completa SUV')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '3 días')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP18', 'Pulido carrocería completa camioneta')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '3 días')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP19', '[Servicio externo] Extracción de luneta o parabrisas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP2', 'Pintura y desabolladura por unidad - Pieza 2')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '5 días | IN8: $35.000 por pieza')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP20', '[Servicio externo] Montaje de luneta o parabrisas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP3', 'Pintura tapa espejo por unidad - Pieza 3')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '3 días | IN7: $10.000 por pieza')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP4', 'Pintura tapa rueda por unidad - Pieza 4')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '3 días | IN7: $10.000 por pieza')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP5', 'Pintura completa auto (14 piezas)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '20 días | IN4: $20.000 x 14 piezas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP6', 'Pintura completa SUV (15 piezas)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '25 días | IN4: $20.000 x 15 piezas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP7', 'Pintura completa camioneta (16 piezas)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '30 días | IN4: $20.000 x 16 piezas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP8', 'Pulido de focos (par)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '45 min')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Desabolladura y Pintura', 'DYP9', 'Cambio espejo retrovisor (1)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '30 min')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Limpieza', 'LIM1', 'Limpieza interior del vehículo')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '40 min aprox, aspirado y limpieza general básica')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Limpieza', 'LIM2', 'Limpieza exterior del vehículo')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, '50 min, limpieza exterior con vidrios y renovador de neumáticos')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Limpieza', 'LIM3', 'Pulido de 2 focos')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Limpieza', 'LIM4', 'Lavado de motor')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Limpieza', 'LIM5', 'Lavado de tapiz (semi sucio)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, 'Incluye limpieza interior')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Limpieza', 'LIM6', 'Lavado de tapiz (extremo sucio)')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, 'Incluye limpieza interior')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Limpieza', 'LIM7', '[Servicio externo] Lavado de chasis')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, 'Para detectar fugas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'DyP', 'Limpieza', 'LIM8', '[Servicio externo] Lavado de motor')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, null, null, null, 0, null, null, null, 'Para detectar fugas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-01', 'Realizar Revisión y relleno de niveles')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, 3500, 'Insumos: agua desmineralizada 1L $1.600 + limpiaparabrisas 1L $1.900')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, 3500, 'Insumos: agua desmineralizada 1L $1.600 + limpiaparabrisas 1L $1.900')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, 3500, 'Insumos: agua desmineralizada 1L $1.600 + limpiaparabrisas 1L $1.900')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, 3500, 'Insumos: agua desmineralizada 1L $1.600 + limpiaparabrisas 1L $1.900')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, 3500, 'Insumos: agua desmineralizada 1L $1.600 + limpiaparabrisas 1L $1.900')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-02', 'Realizar Servicio preventivo de frenos')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 30000, null, null, 5000, 'Frenos delanteros $15.000 + traseros $15.000. Insumo: solvente $5.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 30000, null, null, 5000, 'Frenos delanteros $15.000 + traseros $15.000. Insumo: solvente $5.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 30000, null, null, 5000, 'Frenos delanteros $15.000 + traseros $15.000. Insumo: solvente $5.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 30000, null, null, 5000, 'Frenos delanteros $15.000 + traseros $15.000. Insumo: solvente $5.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 30000, null, null, 5000, 'Frenos delanteros $15.000 + traseros $15.000. Insumo: solvente $5.000')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-03', 'Realizar Rotación de neumáticos + Balanceo')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 10000, null, null, null, 'Rotación y balanceo 2 ruedas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 10000, null, null, null, 'Rotación y balanceo 2 ruedas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 10000, null, null, null, 'Rotación y balanceo 2 ruedas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 10000, null, null, null, 'Rotación y balanceo 2 ruedas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 10000, null, null, null, 'Rotación y balanceo 2 ruedas')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-04', 'Realizar Alineación')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'Incluida sin costo en el pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'Incluida sin costo en el pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'Incluida sin costo en el pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'Incluida sin costo en el pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'Incluida sin costo en el pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-05', 'Cambio de Filtro de aceite')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 5000, 8000, 25000, null, 'MO $5.000 cubre P360-05, P360-06 y P360-07')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 5000, 8000, 25000, null, 'MO $5.000 cubre P360-05, P360-06 y P360-07')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 5000, 8000, 25000, null, 'MO $5.000 cubre P360-05, P360-06 y P360-07')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 5000, 8000, 25000, null, 'MO $5.000 cubre P360-05, P360-06 y P360-07')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 5000, 8000, 25000, null, 'MO $5.000 cubre P360-05, P360-06 y P360-07')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de aceite';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-06', 'Cambio de Aceite motor')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, 48000, 138000, null, 'Aceite 5w30 4L. Insumo del pack, cargado en repuestos por tener precio alt/orig. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, 84000, 138000, null, 'Aceite 5w30 7L. Insumo del pack, cargado en repuestos por tener precio alt/orig. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, 84000, 138000, null, 'Aceite 5w30 7L. Insumo del pack, cargado en repuestos por tener precio alt/orig. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, 84000, 138000, null, 'Aceite 5w30 7L. Insumo del pack, cargado en repuestos por tener precio alt/orig. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, 84000, 138000, null, 'Aceite 5w30 7L. Insumo del pack, cargado en repuestos por tener precio alt/orig. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Aceite de motor';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-07', 'Cambio de Golilla tapón de cárter')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, 500, 500, null, 'Golilla 12x18. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, 500, 500, null, 'Golilla 12x18. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, 500, 500, null, 'Golilla 12x18. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, 500, 500, null, 'Golilla 12x18. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, 500, 500, null, 'Golilla 12x18. MO en P360-05')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Golilla tapón de cárter';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-08', 'Cambio de Filtro de aire')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 2000, 9000, 40500, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 2000, 9000, 40500, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 2000, 9000, 40500, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 2000, 9000, 40500, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 2000, 9000, 40500, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de aire';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-11', 'Inspección de tren delantero y reaprete')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 10000, null, null, null, 'Item Inspeccionar $10.000: cubre P360-11 a P360-21')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 10000, null, null, null, 'Item Inspeccionar $10.000: cubre P360-11 a P360-21')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 10000, null, null, null, 'Item Inspeccionar $10.000: cubre P360-11 a P360-21')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 10000, null, null, null, 'Item Inspeccionar $10.000: cubre P360-11 a P360-21')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 10000, null, null, null, 'Item Inspeccionar $10.000: cubre P360-11 a P360-21')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-12', 'Inspección de suspensión delantera y trasera')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-13', 'Inspección de funcionamiento del sistema de embrague')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-14', 'Inspección de correas de accesorios y ajuste')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-15', 'Inspección de carga de batería y alternador')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-16', 'Inspección de funcionamiento de aire acondicionado')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-17', 'Inspección de plumillas y eyectores lanza agua')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-18', 'Inspección de funcionamiento de bocina')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-19', 'Inspección de ampolletas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-20', 'Inspección de posibles fugas')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-21', 'Inspección de tren trasero')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'MO agrupada en P360-11')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-22', 'Inspección de filtro de polen')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 2000, null, null, null, 'En bencinero el filtro de polen solo se inspecciona, no se cambia')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 2000, null, null, null, 'En bencinero el filtro de polen solo se inspecciona, no se cambia')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 2000, null, null, null, 'En bencinero el filtro de polen solo se inspecciona, no se cambia')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 2000, null, null, null, 'En bencinero el filtro de polen solo se inspecciona, no se cambia')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-23', 'Control de códigos de fallas + escáner')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 0, null, null, null, 'Incluido en el pack, sin MO adicional')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 0, null, null, null, 'Incluido en el pack, sin MO adicional')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 0, null, null, null, 'Incluido en el pack, sin MO adicional')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 0, null, null, null, 'Incluido en el pack, sin MO adicional')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 0, null, null, null, 'Incluido en el pack, sin MO adicional')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-24', 'Limpieza interior y exterior')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 20000, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 20000, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 20000, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 20000, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 20000, null, null, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-25', 'Bono de acción')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'auto', null, null, 20000, null, null, null, 'Bono comercial del pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'bencina', null, 20000, null, null, null, 'Bono comercial del pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 20000, null, null, null, 'Bono comercial del pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'bencina', null, 20000, null, null, null, 'Bono comercial del pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 20000, null, null, null, 'Bono comercial del pack')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-09', 'Cambio de Filtro de polen')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 2000, 7000, 39000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 2000, 7000, 39000, null, null)
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de polen/habitáculo';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

  insert into public.catalogo_servicios (empresa_id, segmento, categoria, codigo, servicio)
    values (v_empresa_id, 'Taller Mecánico', 'Pack Mantención 360°', 'P360-10', 'Cambio de Filtro de combustible')
    on conflict (empresa_id, categoria, servicio) do update set segmento = excluded.segmento, codigo = excluded.codigo
    returning id into v_servicio_id;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'pickup', 'diesel', null, 15000, 17000, 35000, null, 'Filtro de petróleo')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  insert into public.catalogo_servicio_precios (servicio_id, tipo_vehiculo, combustible, horas_mo, valor_mo, repuestos_min, repuestos_max, insumos_clp, notas)
    values (v_servicio_id, 'suv', 'diesel', null, 15000, 17000, 35000, null, 'Filtro de petróleo')
    on conflict (servicio_id, tipo_vehiculo, combustible) do update set valor_mo = excluded.valor_mo;
  select id into v_repuesto_id from public.catalogo_repuestos where empresa_id = v_empresa_id and nombre = 'Filtro de combustible';
  if v_repuesto_id is not null then insert into public.catalogo_servicio_repuestos (servicio_id, repuesto_id) values (v_servicio_id, v_repuesto_id) on conflict do nothing; end if;

end $$;

select
  (select count(*) from public.catalogo_repuestos) as repuestos_esperado_117,
  (select count(*) from public.catalogo_servicios) as servicios_esperado_340,
  (select count(*) from public.catalogo_servicio_precios) as precios_esperado_1137,
  (select count(*) from public.catalogo_servicio_repuestos) as vinculos_repuestos;