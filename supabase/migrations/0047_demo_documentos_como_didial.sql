-- =============================================================================
-- 0047_demo_documentos_como_didial.sql
--
-- Qué resuelve:
--   Los documentos del tenant demo (Orden de Ingreso, Presupuesto, Orden de
--   Egreso) deben verse igual que los de Servicio Automotriz Didial: mismo
--   encabezado y mismas políticas de presupuesto.
--   - Copia nombre, dirección, teléfono y correo de la empresa real a la demo
--     (son los datos que imprime EncabezadoDocumento y las cláusulas de las
--     órdenes). Se copian desde la fila real, no se escriben a mano, así que
--     lo que esté hoy en Didial es lo que queda en la demo.
--   - Copia los tres textos de politicas_presupuesto (con los datos de
--     transferencia reales) de la empresa real a la demo.
--   - NO copia datos tributarios (rut, giro, código de actividad, comuna,
--     ciudad): la demo no debe quedar con la identidad fiscal real del emisor.
--   Efecto colateral esperado: el nombre de la empresa que se ve en el panel y
--   en la barra superior de la cuenta demo pasa a ser el de Didial.
--   Se puede volver a correr.
-- =============================================================================

do $$
declare
  v_real constant uuid := 'aaf45e88-61f2-4aca-b16a-274462f90f5c';
  v_demo constant uuid := 'b0000000-0000-4000-8000-000000000001';
begin
  if not exists (select 1 from public.empresas where id = v_real)
     or not exists (select 1 from public.empresas where id = v_demo) then
    raise exception 'Falta la empresa real o la demo: no se copia nada.';
  end if;

  update public.empresas d
  set nombre = r.nombre,
      direccion = r.direccion,
      telefono = r.telefono,
      correo = r.correo
  from public.empresas r
  where r.id = v_real and d.id = v_demo;

  insert into public.politicas_presupuesto (empresa_id, condicion, texto)
  select v_demo, p.condicion, p.texto
  from public.politicas_presupuesto p
  where p.empresa_id = v_real
  on conflict (empresa_id, condicion) do update set texto = excluded.texto;
end $$;

-- ---------------------------------------------------------------------------
-- Verificación.
-- ---------------------------------------------------------------------------
select
  e.nombre,
  e.es_demo,
  e.direccion,
  e.telefono,
  e.correo,
  (select count(*) from public.politicas_presupuesto p where p.empresa_id = e.id) as textos_esperado_3,
  (select md5(string_agg(p.texto, '|' order by p.condicion)) from public.politicas_presupuesto p where p.empresa_id = e.id) as huella_textos
from public.empresas e
order by e.es_demo;
