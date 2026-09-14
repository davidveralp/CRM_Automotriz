# Registro de cambios

## 2026-09-14 — Bloque 7: postventa (encuestas de satisfacción)

**Qué se entrega:** al entregar una OT, se agenda sola una encuesta de
satisfacción para el día siguiente; un botón manual de administración la
envía por correo con un enlace público de una sola respuesta. Probado de
punta a punta contra producción: cliente → vehículo → ingreso → "marcar
como entregado" (dispara el trigger) → adelantar la fecha agendada a hoy →
botón "Enviar encuestas pendientes" → envío real via Brevo → responder desde
la página pública sin sesión → verificado que queda protegida contra
reenvío.

### Base de datos (`0008_postventa.sql`)
- `encuestas`: una por `trabajo_id` (constraint único — no se duplica si el
  estado pasa por `entregado` más de una vez), con `token` aleatorio propio
  (no reutiliza ningún id interno) y `calificacion` acotada a 1-5.
- Trigger `programar_encuesta_postventa` en `trabajos_taller` (AFTER UPDATE):
  si el estado cambia a `entregado`, agenda la encuesta para el día
  siguiente a la fecha de entrega. `on conflict (trabajo_id) do nothing` la
  hace segura ante reintentos.
- **Acceso público sin RLS:** el token es un secreto que el cliente trae en
  la URL, no algo que RLS pueda validar (RLS filtra por *quién* consulta, no
  por *qué valor* trae). Se resolvió con dos funciones `SECURITY DEFINER` de
  superficie mínima — `encuesta_obtener_por_token` (solo lectura, datos de
  presentación) y `encuesta_responder` (solo escribe calificación/comentario
  de esa fila) — con `execute` otorgado a `anon`, y **sin ningún grant
  directo de `anon` sobre la tabla `encuestas`**.
- `integraciones_brevo_errores`: mismo patrón que los errores de ClickUp del
  Bloque 4 — ninguna falla de envío queda en silencio.

### Edge Function (`enviar-encuestas-pendientes`)
- Recorre todas las empresas (usa `service_role` a propósito: es un job de
  sistema, no la acción de un usuario dentro de su tenant), manda las
  encuestas cuya fecha agendada ya llegó y no se han enviado, vía Brevo.
- **Disparo manual por ahora** (botón en Oportunidades, solo admin/socia).
  Automatizarlo con `pg_cron` + Supabase Vault es un paso aparte pendiente,
  a propósito no incluido en una migración — eso obligaría a dejar el
  `service_role key` escrito en un archivo versionado.

### Interfaz
- `EncuestaPublica.jsx`: ruta pública `/encuesta/:token`, fuera de
  `RutaProtegida` — sin sesión, sin menú. Calificación con emojis + comentario
  opcional; si ya fue respondida (o se reintenta responder), muestra el
  agradecimiento en vez del formulario.
- `Oportunidades.jsx`: listado de ítems postergados (ya existía el trigger
  del Bloque 5; nunca se le había puesto pantalla) + botón "Enviar encuestas
  de postventa pendientes".

### Bug real encontrado y corregido (preexistente desde el Bloque 4)
`invocarFuncion.js` devolvía el cuerpo completo de la respuesta de la Edge
Function (`{ data: {...} }`) sin desenvolver, pero tanto `Oportunidades.jsx`
como la sincronización con ClickUp en `TrabajoDetalle.jsx` leen los campos
como si vinieran en el nivel raíz (`resultado.enviadas`, no
`resultado.data.enviadas`). El síntoma con el que se encontró: el mensaje de
éxito se mostraba como "Encuestas enviadas: de revisadas." (números vacíos).
Corregido en el wrapper (`return data?.data ?? data`) en vez de en cada
pantalla, porque todas las Edge Functions de este proyecto siguen esa misma
convención de respuesta. La sincronización con ClickUp del Bloque 4 tenía el
mismo defecto y nunca se había notado porque no se había llegado a probar en
vivo hasta ahora.

### Encontrado al probar el envío real (no es un bug de código)
El primer envío lo rechazó Brevo por protección de IP nueva ("unrecognised
IP address" — normal la primera vez que una Edge Function llama desde una
IP que Brevo no había visto). El usuario desactivó esa restricción en su
cuenta de Brevo. El segundo intento sí devolvió éxito de la API, pero el
correo no llegó: el remitente (`serviciotecnico@didial.cl`) no estaba
verificado en Brevo. El usuario dio de alta el dominio `didial.cl` como
remitente — la verificación puede tardar hasta 48 horas.

### Pendiente para este bloque
- **Confirmar la entrega real del correo** una vez que Brevo termine de
  verificar el dominio `didial.cl` (hasta 48 h desde 2026-09-14) — el flujo
  completo ya quedó probado hasta el punto de envío; solo falta ver el
  correo llegar de verdad a una bandeja de entrada.
- Automatización con `pg_cron` + Supabase Vault para que el envío diario no
  dependa de que alguien apriete el botón.

---

## 2026-09-14 — Bloque 6: RADAR y circuito de venta cruzada

**Qué se entrega:** "se mide lo que hoy se pierde". El RADAR del técnico
(Tipo A) y la revisión del asesor (Tipo B) son la misma herramienta -una
tabla con columna `origen`, no dos-, diseñada para presentarse al cliente
con el vehículo todavía arriba: hallazgos con precio referencial, urgencia,
foto opcional, y una vista de presentación aparte (texto grande, sin ruido
de edición) para mostrar en la tablet frente al cliente. Probado de punta a
punta contra producción: sesión → hallazgo con precio → presentación →
"usar en presupuesto" → aparece en Valorización con el precio referencial
visible para comparar contra el precio final.

### Base de datos (`0007_radar.sql`)
- `radar_inspecciones` (la sesión, con `origen` = `radar_tecnico` o
  `revision_asesor`, derivado automáticamente del tipo de ingreso de la OT)
  y `radar_hallazgos` (los hallazgos, con `precio_referencial`, `urgencia`,
  `foto_path` opcional).
- `ot_detalle.hallazgo_radar_id`: cuando un hallazgo se convierte en ítem de
  presupuesto, queda vinculado — así el frontend puede avisar si el precio
  final que ponga el encargado de presupuestos (Bloque 5) se aleja del
  referencial que vio el cliente durante el RADAR, sin duplicar el dato.
- **Primer uso real de Supabase Storage** (bucket privado `radar-fotos`,
  políticas acotadas por empresa usando el primer segmento de la ruta del
  archivo) — la firma del Bloque 3 se había quedado en base64 a propósito
  por su bajo volumen; las fotos de RADAR sí lo ameritan.
- **Error real encontrado al aplicar la migración:** `CREATE OR REPLACE
  VIEW` no permite insertar columnas nuevas en medio de una vista existente
  -Postgres lo interpreta como un intento de renombrar la columna que queda
  desplazada y lo rechaza (`42P16`)-. Hubo que mover las columnas nuevas de
  `ot_detalle_con_permiso` al final de la lista. Aplica a cualquier vista
  futura que se extienda: las columnas nuevas siempre van al final.

### Interfaz (`RadarSesion.jsx`)
- Vista de captura: iniciar sesión, cronómetro en vivo (aviso visual pasados
  los 10 minutos, sin bloquear), alta de hallazgos con foto opcional
  (`capture="environment"` para abrir la cámara directo en el celular/tablet).
- Vista de presentación: se activa al finalizar la sesión, precios grandes y
  claros, sin controles de edición a la vista — pensada para girarla hacia
  el cliente, no para que el asesor siga trabajando en ella.
- `TrabajoDetalle.jsx`: la tabla de Valorización ahora muestra el precio
  referencial junto al precio final y marca con ⚠ cuando se alejan más de
  un 20%.

### Nota de sesión de pruebas (no relacionada con el código)
Una pestaña del navegador que llevaba varias horas abierta con muchas
recargas entró en un bucle de error 400 repetido (probablemente el service
worker de la PWA con estado acumulado) y se quedó pegada en "Cargando…".
Se confirmó que era un artefacto de la sesión de pruebas -no del código-
abriendo una pestaña nueva, donde todo cargó con normalidad.

### Pendiente para este bloque
- No se probó la subida de fotos a Storage (el hallazgo de prueba no llevó
  foto) — revisar el flujo de subida con una foto real antes de confiar en
  él del todo.

---

## 2026-09-14 — Bloque 5: valorización y cierre de OT

**Qué se entrega:** "el ciclo del dinero queda cerrado". El encargado de
presupuestos pone costo y precio a cada línea (mano de obra incluida), arma
un presupuesto con correlativo propio, el asesor registra la decisión del
cliente ítem por ítem, y la OT se cierra con el número de documento de
Dimasoft. Probado de punta a punta contra la base real: valorización →
presupuesto (**P-00001**) → decisión postergada con fecha → cierre con
documento — todo confirmado en el navegador, con recarga completa entre
pasos para descartar estado local falso.

### Base de datos (`0006_valorizacion_cierre.sql`)
- `presupuestos_taller` con correlativo propio (`P-00001`), mismo patrón que
  `numero_ot`: contador por empresa, incrementado atómicamente por trigger.
- `ot_detalle`: se agregan `decision` (pendiente/aceptado/rechazado/
  postergado), `motivo_rechazo`, `fecha_postergado`, `presupuesto_id`.
- **Mano de obra ahora tiene precio sin que nadie tenga que acordarse de
  cargarlo aparte:** un trigger en `tareas_taller` crea (y mantiene
  sincronizada) una fila `ot_detalle` (`area = 'mano_obra'`) por cada tarea,
  automáticamente, desde el Bloque 4 en adelante.
- `oportunidades`: un trigger crea una fila automáticamente cuando un ítem
  se marca `postergado` con fecha — "es una venta agendada, no una venta
  perdida", tal como pide el spec.
- **Protección de precios en dos capas, no solo RLS:** RLS filtra filas, no
  columnas, y todos los roles de la app comparten el mismo rol de Postgres
  (`authenticated`), así que "técnicos ven pero no editan precios" no se
  puede resolver solo con políticas de fila. Se resolvió con (1) un trigger
  que bloquea insertar/editar costo o precio sin `tiene_acceso_montos()`, y
  (2) revocar el `SELECT` de esas columnas en la tabla base y exponerlas
  solo a través de la vista `ot_detalle_con_permiso` (con
  `security_invoker` para que la RLS de tenant se siga evaluando con el
  usuario real). **El frontend lee `ot_detalle_con_permiso`, nunca
  `ot_detalle` directo, para que quien no tiene acceso ni reciba el dato.**

### Interfaz (`TrabajoDetalle.jsx`)
- Tabla de "Valorización y negociación": costo/precio editables (solo si
  `tiene_acceso_montos()`), total calculado por la base, decisión por ítem
  con motivo/fecha condicionales.
- Botón "Generar presupuesto": crea el presupuesto y vincula los ítems ya
  precificados que todavía no pertenecían a uno.
- Sección "Cierre": número de documento de Dimasoft + "Marcar como
  entregado".

### Bug real encontrado y corregido al probar
Después de guardar un costo/precio, la columna "Total" (calculada por la
base) se quedaba en blanco hasta recargar la página entera — el guardado sí
funcionaba, pero la pantalla no volvía a pedir el valor calculado. Se
corrigió haciendo que el guardado de precio siempre recargue los datos del
trabajo después de escribir.

### Pendiente para este bloque
- No se pudo confirmar por separado (fuera del código) que el trigger de
  `oportunidades` efectivamente insertó una fila al marcar un ítem como
  postergado — se validó el comportamiento visible (fecha guardada,
  reflejada tras recargar) pero no se llegó a leer la tabla `oportunidades`
  antes de la limpieza de datos de prueba.

---

## 2026-09-14 — Bloque 4: sincronización con ClickUp + credenciales reales cerradas

**Qué se entrega:** el esquema y la interfaz para que el taller cargue mano
de obra y repuestos/insumos/servicios de una OT, y los Edge Functions que
los sincronizan con ClickUp en ambos sentidos. Probado de punta a punta
contra la base de datos real de Didial (clientes, vehículos, ingreso, OT,
tareas y repuestos) — la sincronización con ClickUp en sí (los Edge
Functions) **todavía no está desplegada ni probada en vivo**, ver pendientes.

### Investigación contra el ClickUp real (antes de programar)
Con un token de API que compartió el usuario, se inspeccionó la lista real
"Vehiculos en Taller" (901324296305) en vez de asumir el spec al pie de la
letra. Hallazgos que cambiaron el diseño: la mano de obra son subtareas
**directas** de la OT (no anidadas bajo un contenedor "MANO DE OBRA" como
parecía sugerir una plantilla vieja sin uso real); repuestos/lubricantes e
insumos/servicio externo sí son checklists, tal como decía el spec; los IDs
de los campos personalizados reales (N° OT, Patente, Kilometraje, Tipo de
servicio, etc.) quedaron capturados en `supabase/functions/_shared/clickup.ts`.
Detalle completo en memoria del proyecto.

### Base de datos (`0004_clickup_sync.sql`, `0005_permisos_postgrest.sql`)
- `tareas_taller` (mano de obra) y `ot_detalle` (las cuatro áreas de la OT,
  con costo/precio nullable a propósito — se llenan en el Bloque 5).
  `tareas_taller.estado` guarda el texto tal como lo entrega ClickUp en vez
  de forzarlo a un CHECK fijo: esos estados los define y cambia ClickUp, no
  este esquema.
- `clickup_config`: qué lista de ClickUp usa cada empresa (multi-tenant); el
  token de la API nunca vive en la base, es secreto de Edge Function.
- `integraciones_clickup_errores`: ninguna falla de la API queda en
  silencio.
- **Hallazgo real corregido en 0005:** después de correr las migraciones a
  mano en el SQL Editor, PostgREST devolvía "tabla no encontrada" para
  tablas que sí existían (código `PGRST205`). No era un problema de caché
  (`NOTIFY pgrst, 'reload schema'` no lo resolvió) sino de permisos: las
  tablas creadas por SQL suelto no traen los `GRANT` que sí agrega el
  dashboard de Supabase automáticamente. `0005` deja esto versionado (con
  `ALTER DEFAULT PRIVILEGES` para que no vuelva a pasar con tablas futuras),
  en vez de que quede como un paso manual que alguien olvida repetir.

### Edge Functions (`supabase/functions/clickup-sincronizar`,
### `supabase/functions/clickup-webhook`)
- `clickup-sincronizar`: crea la tarjeta si no existe, sube tareas
  pendientes como subtareas y repuestos/insumos/servicios pendientes como
  ítems de checklist. Cruza el asignado por correo contra los miembros
  reales del equipo de ClickUp.
- `clickup-webhook`: recibe cambios desde ClickUp (incluida una subtarea
  creada directamente ahí por el jefe de taller) y los refleja en la base,
  verificando la firma HMAC del webhook.
- Se instaló Deno localmente para poder tipar y lintear estos archivos
  (`npm run verificar:edge`) — encontró y corrigió errores reales de tipos
  antes de entregarlos (no se pudieron probar en ejecución real, ver
  pendientes).

### Interfaz
- `Trabajos.jsx` (buscar OT por número o patente) y `TrabajoDetalle.jsx`
  (agregar tareas/repuestos, botón "Sincronizar con ClickUp").

### Credenciales de Supabase — cerradas
Proyecto real conectado (`ywdozovkhnnvlpckstsd`), `.env` local con
credenciales reales. Las migraciones 0001-0005 corrieron contra la base
real con resultados verificados independientemente (no solo por reporte del
usuario). Probado en el navegador con la cuenta admin real de David: alta
de cliente, vehículo, ingreso completo (asignó **OT 14000**, confirmando
que el contador de numeración arranca donde se pidió) y carga de
tareas/repuestos, todo contra la base de producción. Los datos de prueba
usados se limpiaron después.

### Pendiente para este bloque
- **Desplegar los Edge Functions** (`supabase functions deploy
  clickup-sincronizar` / `clickup-webhook`) — un push al repo no los
  despliega, hay que hacerlo a mano.
- Configurar los secretos de Edge Function: `CLICKUP_API_TOKEN` y
  `CLICKUP_WEBHOOK_SECRET`.
- Registrar la suscripción del webhook en ClickUp apuntando a la URL del
  Edge Function ya desplegado (requiere la URL real, que solo existe
  después de desplegar).
- Probar el botón "Sincronizar con ClickUp" — no se probó todavía a
  propósito, para no escribir una tarjeta de prueba en el ClickUp real de
  producción del taller sin que el usuario lo decida.

---

## 2026-09-13 — Bloque 3: Nuevo Ingreso (Tipo A/B) con firma

**Qué se entrega:** el taller puede recibir un vehículo. Ingreso Tipo A
(diagnóstico) o Tipo B (servicio agendado), con inspección de ingreso y
firma digital del cliente, más un comprobante imprimible.

**Definición resuelta con el cliente:** numeración de OT — serie nueva,
propia del CRM, empieza en **14000**. Las OT anteriores de Dimasoft no se
numeran en el CRM.

### Base de datos (`supabase/migrations/0003_ingresos.sql`)
- `empresas.siguiente_numero_ot`: cada empresa lleva su propio contador
  (no una secuencia global de Postgres), porque el esquema es multi-tenant
  y una secuencia compartida filtraría el volumen entre talleres distintos.
  El trigger `asignar_numero_ot()` hace un `UPDATE` atómico sobre esa fila
  al crear el trabajo (nunca al cerrarlo, y nunca con `count(*) + 1`).
- `trabajos_taller`: la OT. Todavía sin columnas de costo/precio a
  propósito — el asesor carga el "qué" sin precios; el "cuánto" lo agrega
  el encargado de presupuestos en el Bloque 5 (`ot_detalle`).
- `inspecciones_ingreso`: daños visibles, accesorios, observaciones,
  preguntas de descubrimiento (solo Tipo A) y firma (PNG en base64, no
  Storage — volumen bajo hoy, revisar cuando el Bloque 6 agregue fotos).
- Alta de OT e inspección restringida a asesor/admin/socia (según el spec:
  "1 · RECEPCIÓN asesor"); lectura y avance de estado abiertos a cualquier
  persona activa de la empresa.
- **Sin ejecutar contra Postgres real**, igual que el Bloque 2 — revisada
  línea por línea, falta correrla contra el Supabase real del cliente.

### Interfaz
- `NuevoIngreso.jsx`: busca vehículo por patente; si existe, confirma
  cliente (o pregunta cuál si tiene más de uno vinculado); si no existe,
  da de alta vehículo y cliente nuevos in place (con el mismo aviso de
  duplicados del Bloque 2). Formulario de inspección + firma, y al guardar
  actualiza también `vehiculos.kilometraje` (con aviso, no bloqueo, si el
  valor nuevo es menor al último registrado).
- `FirmaCanvas.jsx`: firma a mano alzada en un `<canvas>`, sin librería
  externa.
- El "documento" del ingreso es una vista imprimible (`window.print()`),
  no un PDF generado en el servidor — el asesor o el cliente lo guardan
  como PDF desde el navegador. Evita depender de una librería o Edge
  Function de PDF que hoy no hace falta.

### Corrección de robustez encontrada al probar (no un bug del Bloque 3 solo)
Ninguna pantalla tenía `try/catch` alrededor de las llamadas a Supabase: si
la conexión fallaba a mitad de una consulta, el botón podía quedar
"Guardando…"/"Buscando…" sin recuperarse nunca, y en el caso de
`AuthContext`, un fallo de red al cargar el perfil mostraba el mensaje
equivocado ("cuenta sin rol asignado") en vez del error real. Se corrigió
en `AuthContext.jsx`, `RutaProtegida.jsx`, `Clientes.jsx`,
`ClienteDetalle.jsx` y `NuevoIngreso.jsx`: todas las llamadas ahora usan
`try/catch/finally`, así el estado de carga siempre se libera y se muestra
un mensaje real. Se verificó en el navegador simulando una caída de red
real (dominio de Supabase inexistente): con esto, el flujo se recupera
solo, sin quedar nunca colgado.

### Pendiente para este bloque
- Probar el flujo completo (buscar → crear vehículo/cliente → firmar →
  guardar) contra el Supabase real: en este entorno solo se pudo probar
  hasta donde llega sin credenciales reales (la búsqueda por patente falla
  por red antes de llegar a los pasos siguientes).

---

## 2026-09-12 — Bloque 2: clientes y vehículos

**Qué se entrega:** el núcleo del CRM — alta, búsqueda y edición de clientes,
con vehículos vinculados. "Cartera completa y consultable" en el sentido de
pantallas y esquema; la carga real de datos de Didial (histórico de
Dimasoft) queda pendiente hasta tener los archivos de exportación.

### Base de datos (`supabase/migrations/0002_clientes_vehiculos.sql`)
- `clientes`: `rut_norm`/`telefono_norm`/(patente ya cubierta en `vehiculos`)
  como columnas `GENERATED ALWAYS`, con validación de dígito verificador
  chileno (`rut_valido`, módulo 11) como `CHECK`. Índice único de RUT
  **deliberadamente no incluido todavía** — hoy solo el 8,7% de los clientes
  tiene RUT y es esperable que haya duplicados sin resolver; se agrega en una
  migración posterior, después de fusionar duplicados (definición pendiente
  del spec original).
- `vehiculos`: `patente_norm` generado (solo alfanumérico, mayúsculas) con
  índice **único por empresa** desde el día 1, como pide el spec.
- `clientes_vehiculos`: tabla puente muchos-a-muchos (no una FK simple
  `vehiculo.cliente_id`) para vehículos con más de un dueño/conductor —
  idea tomada de la documentación de arquitectura de la plataforma, no
  estaba en el spec original pero cubre casos reales (flotas de empresas).
- `clientes_buscar_posibles_duplicados()`: función que el frontend llama
  ANTES de insertar (por RUT exacto, teléfono exacto o similitud de nombre
  vía `pg_trgm`) para avisar, no bloquear.
- Borrado lógico de clientes/vehículos restringido a `admin` mediante un
  trigger (`impedir_eliminacion_logica_sin_admin`), porque RLS no puede
  distinguir "edité un campo" de "anulé la ficha" dentro del mismo `UPDATE`.
- `ON DELETE RESTRICT` (nunca `CASCADE`) entre clientes/vehículos y la tabla
  puente — un `DELETE` físico accidental no debe poder arrastrar historial.

**Nota de honestidad:** esta migración se revisó línea por línea pero no se
ejecutó contra un Postgres real (no hay Docker/psql disponible en este
entorno). Hay que correrla contra el proyecto Supabase real antes de
confiar en ella en producción.

### Interfaz
- `Clientes.jsx`: búsqueda por nombre/RUT/teléfono, listado, alta de cliente
  nuevo con aviso de posibles duplicados (checkbox explícito para crear
  igual si el usuario confirma que es una persona distinta).
- `ClienteDetalle.jsx`: edición de los datos del cliente y gestión de sus
  vehículos — alta de vehículo nuevo, con manejo explícito del error de
  patente duplicada (código `23505` de Postgres) ofreciendo vincular el
  vehículo existente en vez de fallar en seco.

### Corrección a una verificación automática existente
`scripts/verificar-columnas.mjs` tenía un bug real: cuando un archivo hace
varias llamadas `.from(tabla)` seguidas, le atribuía a la primera tabla el
`.insert()/.update()` que en realidad pertenecía a una llamada posterior
del archivo (la ventana de búsqueda no se detenía en el siguiente `.from(`).
Apareció al construir `ClienteDetalle.jsx`, que sí tiene ese patrón. Corregido
y probado con casos sembrados a propósito (columna inventada, tablas
mezcladas) antes de seguir.

### Pendiente para este bloque
- Falta el criterio de fusión de clientes duplicados (definición pendiente
  del spec original) para la migración real de datos históricos.
- Falta la carga real de datos de Didial — se necesitan los archivos de
  exportación de Dimasoft para poder migrar de verdad.

---

## 2026-09-12 (corrección) — Multi-tenant desde el Bloque 1

**Qué cambió:** se agregó la tabla `empresas` (un tenant por taller) y
`empresa_id` en `usuarios`, con RLS acotado por empresa además de por rol.
Servicio Automotriz Didial Ltda. queda sembrada como la primera empresa.

**Por qué:** este CRM es la base de una plataforma que va a tener más de un
taller como cliente (documentación de arquitectura "VPAI"), con Didial como
primer cliente. Construir el esquema single-tenant primero y agregarle
tenant después habría significado re-escribir cada policy de RLS que se
fuera creando en los bloques siguientes. Se decidió explícitamente **no**
adoptar todavía la taxonomía de roles genérica R00-R09 de esa documentación:
Didial tiene roles reales (`encargado_presupuestos`, `detailer`, una
recepcionista separada del asesor) que esa taxonomía no cubre limpiamente
hoy. Se mantienen los roles con nombre de función real y se revisa una
generalización cuando exista un segundo tenant con necesidades distintas.

**Detalle técnico:**
- `mi_empresa_id()`: función auxiliar (mismo patrón que `auth_rol()`) para
  acotar RLS por tenant sin repetir el JOIN en cada policy.
- El alta automática de usuario (trigger `on_auth_user_created`) asigna la
  empresa desde `raw_user_meta_data->>'empresa_id'` si se especifica: así
  deberá invocarse la futura Edge Function de invitación. Mientras Didial
  sea el único tenant, usa como resguardo "la primera empresa activa" —
  documentado en el propio SQL como temporal, se elimina en cuanto exista un
  segundo tenant.
- `AuthContext` ahora trae también `empresa_id` y el nombre de la empresa
  (`empresas(nombre)`); el menú lo muestra en vez de un nombre de taller
  fijo en el código.
- Verificado de nuevo: `npm run build` (lint + 3 verificaciones a medida +
  build de producción) pasa completo.

---

## 2026-09-12 — Bloque 1: verificación, esquema base, auth y roles

**Qué se entrega:** el andamiaje completo del proyecto y un login funcionando
contra Supabase Auth con los 8 roles reales del equipo (`socia`, `admin`,
`asesor`, `jefe_taller`, `encargado_presupuestos`, `tecnico`, `detailer`,
`recepcionista`).

**Por qué en este orden:** la especificación pide que este bloque quede
usable antes de tocar clientes, vehículos o ingresos — sin auth y roles
reales, cualquier RLS que se escriba después habría que rehacerlo.

### Proyecto
- React 18 + Vite + Tailwind + PWA (`vite-plugin-pwa`), en español.
- `App.jsx` separa el login (sin menú) del resto de la app (menú + contenido
  envuelto en `ErrorBoundary`), para que un error en una pantalla no tumbe el
  menú — es un requisito explícito de la especificación.

### Base de datos (`supabase/migrations/0001_esquema_roles.sql`)
- Tabla `usuarios`: perfil 1:1 con `auth.users`, con `nombre_completo`,
  `correo` (identificador de cruce con ClickUp), `rol` y `activo`.
- Trigger `on_auth_user_created`: al crear una cuenta en Supabase Auth, se
  crea automáticamente el perfil en `usuarios` (inactivo, sin rol) para que
  un admin lo complete desde el CRM.
- Funciones auxiliares para RLS: `auth_rol()`, `es_socia()`, `es_admin()`,
  `es_asesor()`, `es_jefe_taller()`, `es_encargado_presupuestos()`,
  `es_tecnico()`, `es_detailer()`, `es_recepcionista()`,
  `tiene_acceso_montos()` (socia/admin/encargado de presupuestos/jefe de
  taller) y `puede_eliminar_fichas()` (solo admin).
- RLS activo en `usuarios`: cada persona ve su propia fila; admin y socia ven
  todas; solo admin puede modificar roles.

### Verificaciones automáticas (`npm run verificar`, corre antes de `build`)
1. `no-undef` y `react/jsx-no-undef` vía ESLint (`eslint.config.js`).
2. `no-use-before-define` (variables, funciones y clases) — cubre el caso de
   un hook o callback escrito antes de la variable que usa.
3. `scripts/verificar-columnas.mjs`: compara las columnas usadas en
   `.insert()/.update()/.upsert()` del frontend contra las columnas reales
   de las migraciones.
4. `scripts/verificar-catalogos-como-texto.mjs`: detecta `.map(item => ...
   {item} ...)` cuando el mismo callback también usa `item.algo` en otro
   punto — señal de que se olvidó la propiedad y se va a renderizar
   `[object Object]`.
5. `scripts/verificar-indices-sql.mjs`: detecta `CREATE INDEX` sobre
   columnas que no existen en ningún `CREATE TABLE` de las migraciones.

Las tres verificaciones a medida se probaron a propósito con errores
sembrados (columna inventada, objeto renderizado suelto, índice sobre
columna inexistente) para confirmar que efectivamente fallan antes de
confiar en ellas como parte del build.

### Interfaz
- `ErrorBoundary`: envuelve cada página; si truena, muestra tipo, mensaje y
  traza copiable en vez de dejar la pantalla en blanco, y el menú sigue
  funcionando porque vive fuera del boundary.
- `AuthContext` / `useAuth()`: sesión + fila de `usuarios` (rol incluido).
- `RutaProtegida`: exige sesión, cuenta activa y rol asignado; acepta
  `rolesPermitidos` para restringir por rol en los siguientes bloques.
- `Login`: email + contraseña contra Supabase Auth.
- `invocarFuncion()` (`src/lib/invocarFuncion.js`): wrapper para Edge
  Functions que lee el cuerpo de la respuesta de error en vez de quedarse
  con el mensaje genérico de Supabase — se usará desde el bloque de
  sincronización con ClickUp en adelante.

### Pendiente para que el login funcione con personas reales
No se sembraron cuentas de prueba con datos inventados. Para activar a cada
persona del equipo:
1. Crear su cuenta en Supabase Auth (dashboard o Edge Function de invitación)
   con su correo real.
2. El trigger crea automáticamente su fila en `usuarios` (inactiva, sin rol).
3. Un admin completa `nombre_completo`, `rol` y pone `activo = true`.

Necesito los correos reales del equipo (hoy la especificación solo da el
correo general de la empresa) antes de poder dejar esto operativo.

### Cómo correr esto
```
npm install
cp .env.example .env   # completar con la URL y anon key del proyecto Supabase
npm run dev
```
Antes de cada build: `npm run verificar` (o `npm run build`, que ya lo
incluye).

> Nota: un push a este repositorio no despliega Edge Functions — se
> desplegarán manualmente cuando existan (bloque de sincronización con
> ClickUp en adelante).
