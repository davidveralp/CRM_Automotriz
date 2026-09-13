# Registro de cambios

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
