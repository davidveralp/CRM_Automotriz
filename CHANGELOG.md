# Registro de cambios

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
