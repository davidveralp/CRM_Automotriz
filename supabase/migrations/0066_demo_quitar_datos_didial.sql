-- =============================================================================
-- 0066_demo_quitar_datos_didial.sql
--
-- Qué resuelve:
--   0047 había copiado nombre/dirección/teléfono/correo/logo de la empresa
--   REAL (Servicio Automotriz Didial) a la demo "para que los documentos se
--   vean igual", y sus políticas de presupuesto quedaron con los datos
--   BANCARIOS REALES de Didial (cuenta corriente, RUT, teléfono). Con la demo
--   ahora bajo marca propia (VPAI, ver 0065 y LoginDemo.jsx), esto ya no
--   corresponde: una demo pública no debe mostrar ni la identidad ni los
--   datos de transferencia reales de un cliente.
--
--   Todo acotado a la empresa demo (b0000000-...-001); no toca el tenant real.
--
--   1. empresas: nombre/dirección/teléfono/correo/logo_url pasan a datos
--      ficticios de marca VPAI (el logo es el archivo estático servido por el
--      propio frontend, /logo-vpai-completo.png -no hace falta subirlo a
--      Storage-).
--   2. politicas_presupuesto: los 3 textos (sin_encargo/encargo/importacion)
--      vuelven a ser genéricos -mismo texto base que ya existía en 0046 antes
--      de que 0047 los pisara con los de Didial-, con datos de transferencia
--      ficticios.
--   3. catalogo_servicio_precios.notas: 0057 había copiado tal cual el
--      catálogo real a la demo, incluida la frase "(cuando no es en Didial)"
--      en 8 filas -se reemplaza por una genérica, solo en las filas de la
--      demo-.
-- =============================================================================

do $$
declare
  v_demo constant uuid := 'b0000000-0000-4000-8000-000000000001';
  v_validez constant text := E'IMPORTANTE:\n*PRESUPUESTO VALIDO POR 5 DIAS CORRIDOS DESDE LA FECHA DE EMISIÓN. VENCIDO ESE PLAZO, DEBERÁ SOLICITAR ACTUALIZACIÓN.';
  v_horario constant text := E'*HORARIO DE ATENCION: LUNES A JUEVES DE LAS 08:30 A 18:30 HRS /VIERNES DE 08:30 A 18:00 HRS/ SABADO: 09:30 A 13:30 HRS.';
  v_modificacion constant text := E'*PRESUPUESTO SUJETO A MODIFICACION EN LA MEDIDA DE QUE DESMONTEN Y SE EVALUEN LOS COMPONENTES LA CUAL SERA INFORMADO A LA BREVEDAD, EN CASO DE HABER DEFECTOS DE REQUERIMIENTO SE REALIZARÁ UN PRESUPUESTO ADICIONAL.';
  v_pago constant text := E'*FORMA DE PAGO: EFECTIVO, TRANSFERENCIA, LINK DE PAGO (DEBITO O CREDITO)';
  v_coordinar constant text := E'AL APROBAR EL PRESUPUESTO DEBE COORDINAR SU VISITA AL +569 00000000';
  v_transferencia constant text := E'*DATOS DE TRANSFERENCIA:\nVPAI Taller Demo\n76.000.000-0\ndemo@vpai.example.com\nCta corriente Banco Demo: 00 00 00 00\nENVIAR COMPROBANTE AL +569 00000000';
begin
  if not exists (select 1 from public.empresas where id = v_demo) then
    raise exception 'No existe la empresa demo: no se cambia nada.';
  end if;

  update public.empresas
  set nombre = 'VPAI — Taller Demo',
      direccion = 'Av. Providencia 1234, Santiago',
      telefono = '+56 2 2345 6789',
      correo = 'demo@vpai.example.com',
      logo_url = '/logo-vpai-completo.png'
  where id = v_demo;

  insert into public.politicas_presupuesto (empresa_id, condicion, texto)
  values
    (
      v_demo, 'sin_encargo',
      v_validez || E'\n*' || v_coordinar || E'\n' || v_horario || E'\n' || v_modificacion || E'\n' || v_transferencia
    ),
    (
      v_demo, 'encargo',
      v_validez || E'\n*REPUESTOS POR ENCARGO DE 2 A 3 DIAS HABILES, SE SOLICITA EL ABONO DEL VALOR DE LOS REPUESTOS.\n' || v_pago
        || E'\n' || v_coordinar || E'\n' || v_horario || E'\n' || v_modificacion || E'\n' || v_transferencia
    ),
    (
      v_demo, 'importacion',
      v_validez || E'\n*REPUESTOS POR ENCARGO DE 30 A 40 DIAS HABILES, SE SOLICITA EL ABONO DEL VALOR DE LOS REPUESTOS.\n' || v_pago
        || E'\n' || v_coordinar || E'\n' || v_horario || E'\n' || v_modificacion || E'\n' || v_transferencia
    )
  on conflict (empresa_id, condicion) do update set texto = excluded.texto;

  update public.catalogo_servicio_precios p
  set notas = replace(p.notas, 'en Didial', 'acá')
  from public.catalogo_servicios s
  where s.id = p.servicio_id and s.empresa_id = v_demo and p.notas like '%Didial%';
end $$;

-- ---------------------------------------------------------------------------
-- Verificación.
-- ---------------------------------------------------------------------------
select
  e.nombre, e.direccion, e.telefono, e.correo, e.logo_url,
  (select count(*) from public.politicas_presupuesto p where p.empresa_id = e.id) as textos_esperado_3,
  (select count(*) from public.politicas_presupuesto p where p.empresa_id = e.id and p.texto like '%Didial%') as politicas_con_didial_esperado_0,
  (
    select count(*)
    from public.catalogo_servicio_precios p
    join public.catalogo_servicios s on s.id = p.servicio_id
    where s.empresa_id = e.id and p.notas like '%Didial%'
  ) as notas_con_didial_esperado_0
from public.empresas e
where e.id = 'b0000000-0000-4000-8000-000000000001';
