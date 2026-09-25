# Registro de cambios

## 2026-09-25 — Barra superior, buscador global, modo nocturno y menú lateral contraíble (`0042_perfil_propio.sql`)

**Qué se entrega:** barra superior en todas las pantallas del panel y un menú lateral que se contrae a solo íconos.

- **Barra superior** (`BarraSuperior.jsx`): buscador global, botón "Nuevo ingreso", campana de notificaciones con contador de no leídas (lleva a Inicio, donde vive la lista completa), interruptor de modo nocturno y menú "Mi cuenta" (nombre, correo, rol y empresa; "Editar perfil", "Correos de prueba" solo en la demo y "Cerrar sesión", que salió del pie del menú lateral). Sticky, oculta al imprimir.
- **Buscador global** (`BuscadorGlobal.jsx`): pantallas y reportes filtrados por el rol de la persona (lista y sinónimos en `src/lib/navegacion.js`, compartida con el menú) más búsqueda en vivo de clientes (nombre, razón social, RUT, teléfono), vehículos (patente sin importar espacios ni mayúsculas, marca, modelo) y OT (por número). Espera de 280 ms, descarta respuestas tardías, cada consulta dentro de `try/catch`. Ctrl/Cmd+K o "/" lo enfocan; flechas, Enter y Esc; roles ARIA de combobox/listbox.
- **Menú lateral contraíble** (`Menu.jsx`): botón "Contraer menú" al pie; contraído, es una barra de 76 px con un ícono por grupo (Inicio, Recepción, Comercial, Gestión) y, al pasar el cursor o enfocar con el teclado, un panel flotante con las subáreas (fixed, para no quedar recortado por el scroll del menú; Esc lo cierra; al tocar se abre en pantallas táctiles). La preferencia se recuerda; sin preferencia arranca contraído bajo 1024 px. El menú ahora es sticky de alto completo.
- **Modo nocturno** (`src/lib/tema.jsx`, reglas al final de `index.css`): la clase `dark` vive SOLO en la envoltura del panel (Layout de App.jsx), así que el login y la encuesta pública que ve el cliente nunca cambian (pedido explícito). Sin elegir, sigue la preferencia del sistema; la elección se recuerda en el navegador. En vez de reescribir cada pantalla, se reasignan las utilidades de Tailwind que usa el proyecto (slate, blanco y tintes de estado); no se invirtió la escala slate porque hay 41 botones `bg-slate-900` y 36 `bg-slate-800` con texto blanco. Todo va dentro de `@media screen`: lo impreso sale siempre claro. Auditoría automática de contraste en 12 pantallas: sin problemas reales.
- **Editar perfil** (`/perfil`, `Perfil.jsx`): cambia el propio nombre (función `perfil_actualizar_nombre`, `security definer`, solo `nombre_completo` de `auth.uid()`, valida 2 a 100 caracteres; hacía falta porque `usuarios_update` solo deja escribir a un admin) y la contraseña (`auth.updateUser`). El correo y el rol son de solo lectura (el correo es único y cruza con ClickUp). En la demo no se puede cambiar la contraseña: las cuentas son compartidas.
- **Verificado en el navegador** con la cuenta real: menú expandido y contraído, panel flotante al pasar el cursor, buscador (sugerencias, informes, "vencidas", clientes, vehículos con `PR UE 89` y OT), Enter navega, Esc cierra, menú de cuenta, interruptor de tema (recuerda y no toca la encuesta pública), celular de 390 px sin desborde horizontal. La función de perfil se probó por REST: acepta el nombre válido, rechaza uno de 1 carácter y rechaza sin sesión. No se guardó ningún cambio al perfil real.
- **Trampa de Vite:** al renombrar `tema.js` a `tema.jsx` el servidor de desarrollo siguió sirviendo el módulo compilado antiguo con la ruta vieja (página en blanco, 404 de `tema.js`); se resolvió tocando el archivo que lo importa.

## 2026-09-25 — Correos de prueba de la demo sin guardar en la base (`0041_demo_correos_sin_persistir.sql`)

**Qué se entrega:** reemplaza el enfoque de `0040`. Los correos de prueba se piden en **cada inicio de sesión** de la demo y ya no se guardan en la base: no hay nada que limpiar entre pruebas.

- **Dónde viven:** solo en la pestaña (`sessionStorage`, `src/lib/correosDemo.js`). Cada inicio de sesión se reconoce por `sesion.user.last_sign_in_at`, que no cambia al recargar ni al refrescar el token; con otro inicio de sesión se vuelve a preguntar. Al enviar, el navegador manda los correos en el cuerpo de la llamada.
- **Aviso de encuesta negativa (otra pantalla, incluso otro dispositivo):** el correo del asesor viaja en el enlace de la encuesta (`?da=correo&ds=firma`) con una firma HMAC-SHA256 que lo ata a ese token (`_shared/demo.ts`). `notificar-encuesta-negativa` solo envía con firma válida, así nadie puede fabricar un enlace que escriba a una dirección ajena. Probado localmente: firma válida, y rechaza otro correo, otro token, firma alterada y sin firma.
- **Demo repetible sin limpiar:** en una empresa demo, `enviar-encuestas-pendientes` toma la encuesta de la OT entregada más reciente y la **reinicia** (sin respuestas, token nuevo, sin el aviso anterior) antes de enviarla; cada prueba parte de cero. Envía 1 correo por prueba (antes eran 4). Sin correos válidos en la llamada responde 400.
- **Migración `0041`:** elimina `demo_guardar_correos` y las columnas `demo_correo_cliente` / `demo_correo_asesor` de `0040` (y los correos de prueba que hubieran quedado ahí). `empresas.es_demo` se mantiene. Va DESPUÉS de desplegar las funciones nuevas.
- **El job automático** (service role) se salta las empresas demo: sus clientes son ficticios.
- **Hallazgo al probar:** al correr `scripts/crear-demo.mjs` (cambia contraseña y correos con la API admin) Supabase cierra las sesiones de esas cuentas. El navegador conserva un token que aún no vence -la app se ve normal, porque PostgREST solo verifica la firma-, pero las Edge Functions que validan la sesión con `auth.getUser` responden "Auth session missing!" (401). Después de correr ese script hay que cerrar sesión y volver a entrar.
- Desplegadas: `enviar-encuestas-pendientes` v11 y `notificar-encuesta-negativa` v4 (`verify_jwt` sin cambios). Verificado en el navegador: el modal aparece al entrar, "Ahora no" lo recuerda, otro inicio de sesión lo vuelve a pedir, y enviar sin correos lo pide sin llamar a la función. **No probado:** el envío real por Brevo de punta a punta (requiere sesión nueva y una dirección real).

## 2026-09-25 — Correos de prueba en la demo (`0040_demo_correos_de_prueba.sql`)

**Qué se entrega:** al probar la demo se pide el correo del cliente y el del asesor (pueden ser el mismo) para recibir de verdad los correos del sistema, sin que la demo le escriba jamás a un cliente real ni a las direcciones ficticias de los datos de ejemplo.

- **Modal al entrar a la demo** (`ModalCorreosDemo.jsx`, solo si `empresas.es_demo`): correo del cliente, casilla "usar el mismo correo para el asesor" y, si se desmarca, correo del asesor. Se pregunta una vez por sesión del navegador (`sessionStorage`), con opción "Ahora no", y queda el botón "Correos de prueba" en el menú lateral para cambiarlos. No se precargan desde la base: el tenant demo es compartido y se filtraría el correo de quien probó antes.
- **Dónde se guardan:** `empresas.es_demo`, `demo_correo_cliente` y `demo_correo_asesor`, escritos por la función `demo_guardar_correos()` (valida el formato y falla fuera de un tenant demo). No se toca `usuarios.correo` (es `unique` y cruza con ClickUp: un correo real repetido lo rompería) ni `clientes.email`.
- **Funciones de correo** (desplegadas: `enviar-encuestas-pendientes` v7, `notificar-encuesta-negativa` v3, `verify_jwt` sin cambios): en una empresa demo, la encuesta de postventa va al correo del cliente de prueba y el aviso de encuesta negativa al del asesor de prueba; los asuntos llevan `[Demo]` y la patente sale como `XX XX XX` (`_shared/patente.ts`). Si falta el correo de prueba, la función lo registra en `integraciones_brevo_errores` con un mensaje claro y no envía nada.
- **Riesgo cerrado en la función real:** `enviar-encuestas-pendientes` recorría las encuestas pendientes de TODAS las empresas con el service role, así que apretar el botón desde la demo podía escribirle a clientes reales de otro taller. Ahora, con la sesión de una persona, solo procesa las de su propia empresa (`trabajos_taller!inner` + filtro por `empresa_id`); solo el service role -el futuro job automático- recorre todas; sin sesión ni service role responde 401 (verificado con la clave pública: HTTP 401).
- **Orden de despliegue:** la migración va antes que las funciones y que el frontend, porque el login (`AuthContext`) y las funciones leen las columnas nuevas.
- **No probado de extremo a extremo:** el envío real por Brevo no se ejecutó desde acá para no escribir a direcciones ajenas; se verificó el modal, la función RPC, el despliegue y el rechazo sin sesión. El aviso "listo para entrega" al asesor lo dispara ClickUp y no es probable en la demo.

## 2026-09-25 — Formato de patente XX XX XX y demo sin marca ajena (rama limpia)

**Qué se entrega:** dos ajustes pedidos antes de publicar la rama de la demo.

- **Formato de patente `XX XX XX` (a petición del cliente), solo de presentación:** nuevo `src/lib/patente.js` (`formatearPatente`, `formatearPatenteEntrada`, `normalizarPatente`). Se aplica en las 17 pantallas que muestran patente (Inicio, Trabajos, Taller, Agenda, Mensajes, Presupuestos, Cuentas por cobrar, Encuestas, Oportunidades, RADAR, egreso, facturación, encuesta pública, etc.) y como máscara mientras se escribe en Nuevo ingreso y Agregar vehículo. Lo guardado en la base no cambia: los vehículos nuevos se guardan limpios (mayúsculas, sin espacios) y todas las búsquedas siguen usando `patente_norm`, así que tampoco cambia lo que se envía a ClickUp ni los datos del tenant real.
- **Demo neutra y con los logos de Didial:** el tenant demo ya no usa ningún nombre, logo, dominio de correo ni patente ajenos al proyecto. Se restauran los logos de Didial en `public/`, la empresa demo usa el logo de Didial, las patentes de la demo son `PRUE01` a `PRUE29`, los correos son `demo-*@example.com` y la contraseña de demostración cambió. Los archivos se renombran (`0036_tenant_demo.sql`, `scripts/crear-demo.mjs`); el script ahora se puede volver a correr y actualiza correos y contraseña de cuentas ya creadas.
- **Rama:** la rama subida antes se reemplaza por una recreada desde `main` con un solo commit limpio.

## 2026-09-25 — Datos de demostración ampliados en el tenant demo (`0039_datos_demo_ampliados.sql`)

**Qué se entrega:** el tenant demo de `0036` (12 clientes, 10 OT) quedaba corto para mostrar la app completa. `0039` lo amplía sin tocar el tenant real de Didial (todo cuelga del `empresa_id` fijo de la demo).

- **Contenido:** 10 clientes y vehículos nuevos (patentes `PRUE20` a `PRUE29`, RUT válidos calculados con `rut_dv_calculado`); 24 OT entregadas en ~6 meses con clientes recurrentes, diagnósticos con RADAR y checklist, presupuestos aceptados/parciales, ítems rechazados, 6 postergados que alimentan Oportunidades (una contactada, una convertida, una descartada), 2 retrabajos, 3 facturas pendientes (2 vencidas), 20 encuestas respondidas (2 negativas) y 4 pendientes; 5 OT activas nuevas (una con un repuesto sin precio que dispara la notificación real); bodega con 6 productos más, 2 proveedores, compras con fecha pasada, ajuste y devolución (4 productos bajo su mínimo); punto de venta con 5 ventas cerradas y 1 abierta; 19 citas en pasado y próximos 7 días hábiles; 7 contactos de WhatsApp en distintos pasos del bot (uno en pausa por un humano); técnicos asignados a islas y el plano del taller dibujado con 10 vehículos en sus puestos (capacidades iguales a las de `0036`, la Agenda no cambia).
- **Los triggers reales hacen su trabajo:** encuestas al entregar, notificaciones de cita nueva y de repuesto pendiente, oportunidades por postergado, descuento de stock al verificar y en cada venta, liberación de puestos. Solo se limpian a mano las notificaciones de citas ya terminadas (mismo criterio que `0036`).
- **No re-ejecutable a propósito:** aborta con un mensaje claro si detecta la patente `PRUE20`, en vez de duplicar datos.
- **Error propio corregido en la primera ejecución real:** `v_areas || 'texto'` con un literal sin tipo lo interpreta Postgres como array (`malformed array literal`). Se usa `array_append(v_areas, 'texto'::text)`. El bloque es atómico, así que la ejecución fallida no dejó nada.
- **Corrección de un dato de `0036`:** su verificación decía 14 vehículos; los correctos son 13 (ese número venía mal escrito en el comentario, los datos estaban bien).
- Verificado por SQL con la consulta final de la migración: clientes 22, vehículos 23, OT 39, entregadas 28, encuestas respondidas 23, oportunidades 6, productos 12 (4 bajo mínimo), ventas 6, citas 24, contactos WA 10, plano 14, ocupación 10.

## 2026-09-25 — Plano del taller en vivo, reemplaza "Taller por islas" (`0038_plano_taller.sql`)

**Qué se entrega:** la pantalla `/taller` deja de ser una lista de cargas por técnico y pasa a ser un plano (layout) dibujable del taller, con dos modos: **En vivo** y **Editar plano**.

- **Figuras:** isla con elevador, sin elevador, con pozo, alineadora, vulcanización, espacio de pulmón, desabolladura y pintura, isla de lavado y oficina, cada una con su dibujo interno. Grilla de 40x24 celdas, sin superposiciones.
- **Editor** (admin, socia, jefe de taller): arrastrar, redimensionar con la esquina, girar 90 grados (intercambia ancho y alto, por eso no hay columna de rotación), flechas del teclado, campos numéricos de columna/fila/ancho/alto, nombre, técnico responsable y vehículos a la vez. Cada cambio se guarda al soltar y se revierte si el servidor lo rechaza. Botón "Cargar plano de ejemplo" cuando está vacío.
- **En vivo:** cada puesto muestra patente, marca/modelo, estado de ClickUp y tiempo de la OT que tiene encima; desde el panel se ubica una OT activa en un puesto o se libera. Una OT que pasa a entregada/anulada se libera sola (trigger). Resumen de puestos libres/ocupados y lista de OT activas sin puesto.
- **Agenda:** cada puesto se asocia a un tipo de isla y la capacidad de ese tipo (`tipos_isla.capacidad`) pasa a ser la cantidad de puestos dibujados. Solo se sobreescribe con al menos un puesto, así que un plano vacío no deja la Agenda sin capacidad.
- **Base de datos:** `plano_elementos` y `plano_ocupacion` (tabla aparte para no chocar con el bloqueo de OT entregadas de 0026), RLS (lectura para toda la empresa, escritura solo jefe de taller/admin/socia) y triggers de capacidad de puesto, de sincronización con la Agenda y de liberación al cerrar la OT. Verificada por SQL: 2 tablas, RLS en ambas, 7 políticas, 4 triggers.
- **Retirado:** la asignación de técnicos por tipo de isla (`usuarios_islas`) ya no tiene pantalla; la tabla queda intacta. El responsable ahora se asigna por puesto.
- **Ajuste general:** el `<main>` del layout con `min-w-0`, para que un contenido ancho (el lienzo) haga scroll dentro de su contenedor y no ensanche toda la página.
- **Probado en el navegador contra el tenant real** (solo con figuras sin tipo de isla, para no alterar la capacidad de la Agenda): crear, mover, colisión rechazada, redimensionar, girar, renombrar, eliminar, persistencia tras recargar y ubicar dos OT en un pulmón. Las figuras de prueba se limpian con un script aparte. La capacidad de la Agenda y la liberación automática se prueban por SQL dentro de una transacción que se revierte.
- `npm run verificar` y `npx vite build` sin errores. El heurístico de catálogos-como-texto dio un falso positivo con `elemento={elemento}` dentro de un `.map`; se resolvió extrayendo el cuerpo del `.map` a una función.

## 2026-09-22 — Revisión del bug de modal `items-center` en Bodega/Clientes/ClienteDetalle (tarea pendiente de la sesión de Agenda)

**Qué se entrega:** la sesión de Agenda dejó como pendiente confirmar si el mismo bug de `items-center` (formulario centrado con Flexbox que queda parcialmente inalcanzable con scroll cuando crece más alto que la pantalla) también afectaba a los otros 3 modales del proyecto con el patrón `fixed inset-0 flex items-center justify-center`. No se asumió que sí o que no -se revisó cada uno.

- **Reproducido sin necesidad de sesión real:** en vez de iniciar sesión contra producción para cada modal, se armó una página estática con el mismo HTML/Tailwind exacto de cada formulario (mismos campos, mismas clases) servida en local y abierta en el navegador con el viewport achicado (375-390px de ancho × 600-700px de alto, rango de celular en el taller). El mecanismo del bug es puro CSS (Flexbox `items-center` + `overflow-y-auto`), no depende de datos reales, así que esto confirma el comportamiento igual de bien que probar contra producción, sin crear datos de prueba.
- **Bodega.jsx (`FormularioProducto`, `FormularioMovimiento`): NO tenían el bug.** Ambos formularios tienen una cantidad fija de campos (7 y hasta 6 respectivamente) que caben cómodamente incluso en 600px de alto -se midió con el navegador, sobra margen-. Se dejaron sin tocar.
- **ClienteDetalle.jsx (`FormularioVehiculo`, "Agregar vehículo"): NO tenía el bug.** Solo 4 campos, cabe con margen de sobra incluso en 600px. Sin tocar.
- **Bodega.jsx (`PanelProveedores`): SÍ tenía el bug, confirmado.** La lista de proveedores se trae completa sin límite (`supabase.from('proveedores')...`, sin `.limit()`). Con pocos proveedores no se nota, pero un taller real acumula muchos (repuestos, neumáticos, baterías, pintura, lubricantes, cada uno con más de un proveedor) -se confirmó el bug reproduciendo con una lista larga: el encabezado del panel quedaba inalcanzable con `scrollTop` en su mínimo (0). Corregido igual que Agenda: `items-center` → `items-start`.
- **Clientes.jsx (`FormularioNuevoCliente`, "Nuevo cliente"): SÍ tenía el bug, y uno más grave que el de Agenda.** Este modal ni siquiera tenía `overflow-y-auto` -a diferencia de los otros tres, que sí lo traían-. La lista de "posibles duplicados" (RPC `clientes_buscar_posibles_duplicados`, tope real de 10 filas por un `limit 10` en la función SQL) puede aparecer con varios clientes de apellidos comunes en un taller con años de fichas. Sin `overflow-y-auto`, cuando el contenido supera la pantalla no hay forma de hacer scroll en absoluto -confirmado en el navegador con los 10 duplicados reales que puede devolver el RPC: no solo el encabezado quedaba inalcanzable, el botón "Guardar" también, sin ningún error en consola-. Corregido agregando `overflow-y-auto` y usando `items-start` (no solo `items-start` a secas, que no habría arreglado nada sin el scroll).
- **Regla general ya anotada en Agenda.jsx, confirmada de nuevo acá:** cualquier modal `fixed inset-0` cuyo contenido pueda crecer (lista sin límite, buscador, etc.) necesita `items-start` en vez de `items-center`, siempre junto con `overflow-y-auto` -uno sin el otro no resuelve nada-.
- Verificado con `npm run verificar` (lint + las 3 verificaciones automáticas del proyecto) y `npx vite build`, ambos sin errores. No se tocó ningún otro código del proyecto.

## 2026-09-22 — Calendario de Agenda por bloques + bot de agendamiento en WhatsApp (`0034_agenda_calendario_y_bot.sql`, `0035_fix_rls_horario_atencion.sql`)

**Qué se entrega:** rediseño de Agenda de "cupos por día" a un calendario visual real por bloques de 30 minutos, con la capacidad medida por isla y duración del servicio -y una conexión directa con Mensajes: un bot conversacional (menú guiado, sin IA) que agenda directo apenas encuentra un horario que encaja según el servicio que el cliente elige.

- **Horario real del taller confirmado con el cliente:** lunes a jueves 09:00-18:00, viernes y sábado 09:00-17:30, domingo cerrado, con un corte de mediodía (13:00-15:00) donde solo "Servicio rápido" sigue operando -el resto de las islas no ofrecen horarios en ese rango-.
- **La duración de cada servicio ya estaba importada** (`horas_mo` en `catalogo_servicio_precios`, Bloque de precios del 2026-09-20) pero nunca se había conectado a la Agenda -se usa por primera vez acá-. El cálculo de cupos por solapamiento de horario tampoco es nuevo (`citas_cupos_disponibles`, migración previa a esta sesión): este bloque agrega el calendario visual y el buscador de "próximo horario disponible" sobre esa base ya construida.
- **Mapeo real segmento+categoría (planilla de precios) → isla del taller**, verificado contra los datos ya importados: no es 1:1 -"Servicio Rápido" se reparte entre la isla "Servicio rápido" y "Alineación" según la categoría, "DyP" entre "Pintura" y "Lavado"-.
- El formulario manual de "Nueva cita" ahora tiene un buscador opcional por catálogo (categoría → servicio → "buscar próximos horarios disponibles"), mismo mecanismo que usa el bot, para que Recepción pueda agendar por teléfono con la misma inteligencia.
- **Bot de WhatsApp** (menú numerado: tipo de servicio → categoría → servicio → horario, sin interpretar texto libre): agenda directo y reutiliza la notificación "cita nueva" ya existente. Se pausa solo apenas un humano responde (desde el panel o desde la app del celular) para no contestar por encima de Recepción; se reactiva con un botón en Mensajes. Si el cliente no tiene ficha en el CRM, el bot crea una mínima automáticamente (mismo criterio que "+ Cliente nuevo" del formulario manual).
- **Bug propio encontrado y corregido probando en el navegador (no evidente solo en el código):** el modal de "Nueva cita" centraba el formulario con `items-center`; al crecer con el buscador de catálogo, el contenido quedó más alto que la pantalla y la parte de arriba se volvió inalcanzable con scroll -clásico problema de Flexbox centrado + overflow, el contenido se centra con desplazamiento negativo que `overflow-y-auto` no puede alcanzar-. Corregido a `items-start`. El mismo patrón existe en otros 3 modales del proyecto (Bodega, Clientes, ClienteDetalle) sin confirmar si ya les pasa lo mismo -queda como tarea aparte a revisar-.
- **Bug propio encontrado y corregido antes de que el cliente lo viera:** `horario_atencion` quedó sin `enable row level security` ni policy de lectura en la migración original -el calendario mostraba "El taller no atiende este día" todos los días pese a que los datos sí estaban cargados, confirmado comparando una consulta directa por SQL Editor (6 filas) contra la misma consulta desde el navegador (0 filas)-. Corregido en una migración aparte (`0035`).
- Probado de punta a punta contra producción: verificado por SQL que el mapeo segmento→isla resuelve correctamente en los 5 casos reales, y que el buscador de horarios respeta el horario de atención y el corte de mediodía exacto (Taller mecánico corta en 12:00 para un servicio de 60 min, no 12:30, porque a esa hora ya invadiría el corte; Servicio rápido sigue ofreciendo horarios durante todo el corte). Luego, de punta a punta en el navegador: categoría "Frenos" → servicio "Pastillas delanteras" → 6 horarios sugeridos → cliente nuevo creado al vuelo → cita agendada → el bloque de 60 min ocupó correctamente los DOS bloques de 30 min en el calendario → notificación "cita nueva" recibida en Inicio con el texto correcto. Dato de prueba limpiado (cliente "PruebaCalendario").
- **No probado todavía (bloqueante fuera de esta sesión):** la conversación real del bot por WhatsApp -no hay número conectado (Tech Provider de Meta pendiente)-. Se verificaron por separado, vía SQL directo, las tres funciones de las que depende (`catalogo_isla_para_servicio`, `catalogo_horas_servicio`, `citas_buscar_horarios`) y el tipo de la función (`deno check`), pero no el intercambio de mensajes en sí.

## 2026-09-22 — Formato tomado de un prototipo anterior del mismo proyecto

**Qué se entrega:** el cliente compartió el zip de una versión anterior, mucho más avanzada, del mismo CRM Didial (construida por él mismo antes de retomar este repo con arquitectura multi-tenant) y pidió tomar tres cosas puntuales: la paleta de colores, el login, y el panel lateral con íconos.

- **Paleta de marca** (rojo `#E73C32`/ámbar `#F9C847`, tema "carbón" con textura) vía variables CSS + tokens de Tailwind (`didial-red`, `deep`, `steel`, `sky`, etc.), reutilizando la sintaxis de opacidad de Tailwind (`bg-deep/40`).
- `Login.jsx` rediseñado: panel de marca partido (textura + swoosh SVG) a la izquierda, formulario a la derecha, sin tocar la lógica de autenticación existente.
- `Menu.jsx` reescrito como sidebar oscura con íconos SVG inline (sin librería nueva) agrupados por área, adaptado a las rutas/roles reales de este proyecto -no una copia de las rutas del prototipo, que eran de otro alcance-. Se agregó un detalle propio: el ícono de Inicio muestra el conteo de notificaciones no leídas del panel ya construido, en vez de portar el componente de notificaciones del prototipo (que dependía de una tabla que no existe acá).
- Fuente Inter vía Google Fonts + script de recuperación automática si una pestaña vieja queda apuntando a un build de Vercel que ya no existe (limpia caché y recarga una vez) -tomado del prototipo, directamente relevante después de la saga de despliegue de esta sesión-.
- El resto del contenido de ese prototipo (Pipeline/Gestiones/Campañas, buscador global, campanita persistente, benchmarks de KPI, etc.) se evaluó y se guardó como pendiente, no se portó en esta ronda -ver memoria del proyecto para el detalle completo-.
- Probado visualmente en el navegador: login con el panel de marca y el formulario lado a lado en pantallas ≥1024px, panel lateral con los 4 grupos de navegación y el contador de notificaciones funcionando.

## 2026-09-22 — Notificación de repuestos pendientes de presupuesto (`0033_notificacion_repuestos.sql`)

**Qué se entrega:** sexto tipo de notificación. Cada vez que se agrega un repuesto a una OT que todavía necesita precio, le llega un aviso al encargado de presupuestos -antes nada avisaba de forma activa, había que ir revisando OT por OT-. El cliente fue explícito en que esto pasa por dos caminos: a mano en la ficha de la OT, y también cuando el taller agrega repuestos directo en ClickUp (sin pasar por el CRM).

- **Un solo trigger en `ot_detalle` cubre los tres orígenes** (formulario manual, catálogo de servicios, sync de ClickUp) sin duplicar la notificación en cada punto del código por separado -los triggers de Postgres no distinguen quién hizo el INSERT, a diferencia de RLS-.
- Se dispara solo para repuestos sin precio que el cliente no trae por su cuenta (`provisto_por_cliente = false`); se resuelve sola cuando alguien le pone precio o resulta que sí lo trae el cliente.
- Probado de punta a punta con 4 casos en paralelo (pendiente, ya con precio, otra área, provisto por cliente) para confirmar que solo el caso correcto notifica, más las dos vías de resolución (precio puesto / resultó provisto por cliente). **Nota de sesión:** correr un `insert`/`update` con precio directo desde el SQL Editor de Supabase choca con la protección de precios del Bloque 5 (`tiene_acceso_montos()` no existe sin una sesión real) -se resolvió con el mismo flag de bypass de sesión que ya usa `agregar_servicio_catalogo` (`app.bypass_precio_protegido`), no hizo falta nada nuevo-. Datos de prueba limpiados (cliente "PruebaNotifRepuestos", vehículo "PRUE85").

## 2026-09-21/22 — Módulo de Recepción por WhatsApp (`0032_whatsapp_recepcion.sql`, sin conectar a un número real todavía)

**Qué se entrega:** el cliente compartió un documento de preparación de base de otro proyecto de Recepción/WhatsApp (con los dos números reales de Didial, Toyota y Multimarca) y pidió adaptarlo a este CRM: panel de bandeja de mensajes, vínculo con clientes/vehículos del CRM y categorización por estado de atención.

- **Adaptado, no copiado:** nombres de tabla en español completo y `empresa_id` en todas -el documento original no era multi-tenant-. Antes de programar nada, se verificó contra la documentación oficial de Meta (no se asumió) la forma exacta de los payloads de los 4 campos de webhook de Coexistencia -un hallazgo real: `history` usa el mismo sobre `entry[].changes[].field/value` que `messages`, no uno distinto como asumía el documento original-.
- **El envío de mensajes se protege distinto al documento original a propósito:** el documento proponía un secreto compartido (`CRM_SECRET`), pero este frontend es una SPA pública -cualquier secreto en el bundle deja de ser secreto-. Se verifica en su lugar la sesión real de Supabase de quien llama (mismo criterio que cualquier otra pantalla protegida del CRM).
- Cinco tablas nuevas (`whatsapp_cuentas`, `whatsapp_contactos`, `whatsapp_mensajes`, `whatsapp_sincronizaciones`, `whatsapp_eventos_cuenta`) + Edge Function `whatsapp` (despacho por campo, firma HMAC de Meta verificada, match automático de contacto por teléfono reutilizando `normalizar_telefono` del Bloque 2) + pantalla nueva `/mensajes` (bandeja filtrable por estado, vínculo a cliente/vehículo, envío de texto).
- `PARTNER_REMOVED` (WhatsApp desconectado de la API) se agregó como un tipo más del panel de notificaciones recién construido, no solo una fila en una tabla que nadie revisa.
- **Bloqueante real, fuera de alcance de esta sesión:** la cuenta de Meta sigue esperando aprobación de estatus "Tech Provider" para conectar Toyota/Multimarca en modo Coexistencia -nada de esto se ha probado todavía contra un webhook real-. El cliente encontró un atajo real: un número **nuevo** (nunca usado en la app de WhatsApp Business) no pasa por la restricción de Coexistencia, se registra por el camino estándar de Cloud API sin requerir Tech Provider -confirmado por referencias públicas del error "Register endpoint is not available for SMB businesses", específico de números que ya estaban en la app-. Queda pendiente conectar ese número de prueba (datos del número todavía no compartidos).
- Google review link (`empresas.google_review_url`) sigue pendiente del cliente, sin relación con este bloque.

## 2026-09-21 — Notificaciones en el panel de inicio (`0031_notificaciones.sql`)

**Qué se entrega:** el panel de inicio (Bloque 1) no pasaba del saludo. El cliente pidió que liste las notificaciones que le competen a quien inició sesión -con patente y OT, o solo con los datos de la cita cuando es un agendamiento de Recepción, que todavía no tiene OT en ese momento-, y que administración (admin/socia) vea todas sin filtro de rol.

- **Cinco eventos con destinatario propio:** presupuesto pendiente de aprobación (asesor + encargado_presupuestos), encuesta postventa negativa (admin/socia, mismo destinatario que ya usa el correo de alerta del Bloque 7), cita nueva agendada por Recepción (asesor), y "listo para entrega"/"compra reptos" -estos dos ya disparaban correo desde `clickup-webhook` al detectar la transición de estado en ClickUp, ahora también quedan en el panel-.
- **Cita nueva sin forzar un OT que no existe:** una cita recién agendada no tiene `trabajo_id` hasta que el vehículo llega de verdad (se vincula a mano en Nuevo Ingreso, ver `0009_agenda.sql`) -se decidió con el cliente mostrar fecha/hora/cliente en el aviso en vez de cambiar ese flujo para adelantar la creación de la OT-.
- **Se resuelven solas, no quedan como historial muerto:** un trigger borra la notificación de presupuesto cuando deja de estar "enviado", la de cita cuando se vincula a una OT real o se cancela, y las de "listo para entrega"/"compra reptos" cuando la OT se marca entregada. La única excepción es la encuesta negativa -evento puntual, sin un "estado normal" al que volver-.
- **Deliberadamente fuera de esta tabla:** facturas vencidas de Cuentas por Cobrar. No hay un evento que las dispare (se vencen por el simple paso del tiempo) y el proyecto no tiene un job programado todavía -se calculan en vivo contra `trabajos_taller.fecha_vencimiento_pago` en cada carga del panel, sin marca de "leída" -una factura vencida debe seguir apareciendo hasta que se pague, no hasta que alguien la mire-.
- Lectura por persona (`notificaciones_lecturas`, una notificación con `roles_destino` la puede ver más de un usuario, cada quien la marca leída por su cuenta) vía botón "Marcar leída" en el panel.
- Probado de punta a punta contra producción, en dos rondas: (1) presupuesto enviado + cita agendada + simulación de "listo para entrega"/"compra reptos" → las 4 notificaciones aparecieron correctamente; (2) presupuesto aceptado + cita vinculada a la OT + OT entregada + encuesta respondida con "Atención del asesor" en 1 estrella → las 4 primeras se borraron solas y quedó únicamente la de encuesta negativa, exactamente como se esperaba. Confirmado también visualmente en el panel ya desplegado. Datos de prueba limpiados (cliente "PruebaNotificaciones", vehículo "PRUE95").

## 2026-09-21 — Primer despliegue a producción (Vercel) + favicon oficial

**Qué se entrega:** primer lanzamiento real de la app, fuera del entorno de desarrollo local.

- El repo nunca había tenido un push real a GitHub (el remoto estaba configurado pero sin refs) — se hizo el push inicial y se conectó a Vercel.
- **Lección para la próxima vez que se conecte un repo a Vercel:** el webhook de GitHub↔Vercel solo dispara builds para pushes *posteriores* a que se conectó la integración — si se conecta después del primer push, hay que forzar un commit vacío (`git commit --allow-empty`) para que arranque el primer deploy, tal como lo sugiere la propia UI de Vercel.
- **Lección importante:** llegaron a existir dos proyectos de Vercel para el mismo repo (`crm-automotriz-dos`, nunca desplegado con éxito, y `crm-automotriz-two`, el que sí construye) — un dominio mostrando `404 DEPLOYMENT_NOT_FOUND` pese a que el otro proyecto muestra "Ready" es señal de que el dominio que se está probando pertenece a un proyecto distinto del que realmente construyó. Confirmar siempre el hostname propio del deployment (que incluye el nombre del team/proyecto) contra el dominio que se está probando antes de configurar variables de entorno.
- **Vercel bloquea el tipo "Secret" para variables `VITE_`-prefijadas** (se hornean en el bundle del cliente igual, la distinción solo afecta si se puede volver a ver el valor en el dashboard) **y una vez guardada como Secret no se puede cambiar a Config** -hay que borrarla y volver a crearla eligiendo "Config" desde el principio-.
- Favicon/logo de la PWA (`public/logo-didial.png`) actualizado con el diseño oficial final que pasó el cliente.
- Confirmado en producción real (`crm-automotriz-two.vercel.app`): login, favicon nuevo y (en la ronda siguiente) el panel de notificaciones, todos verificados contra el dominio público, no solo en local.

## 2026-09-20 — Lista de inspección del RADAR (`0029_radar_checklist.sql`, `0030_seed_radar_checklist_didial.sql`)

**Qué se entrega:** el RADAR (Bloque 6) era 100% texto libre -el técnico solo registraba un hallazgo cuando encontraba algo, sin ninguna guía de qué revisar-. El cliente compartió su lista real de inspección (7 áreas, 48 puntos) para que el técnico la recorra punto por punto durante la sesión.

- **Tablas nuevas** `radar_checklist_items` (catálogo de puntos, multi-tenant) y `radar_checklist_respuestas` (una respuesta por punto y por sesión: bien/requiere atención/no aplica + nota opcional). Se mantienen separadas de `radar_hallazgos` a propósito: la lista es "qué se revisó y cómo quedó", los hallazgos siguen siendo "qué se le va a cobrar al cliente", con su propio precio referencial y urgencia.
- **Conexión entre ambas, sin duplicar el dato a mano:** un punto marcado "Requiere atención" muestra un botón "Convertir en hallazgo" que precarga el formulario de hallazgo ya existente (con el área+punto como detalle) — el técnico solo completa precio/urgencia, no tiene que escribirlo de nuevo.
- La lista de inspección solo aparece en la vista de captura (la del técnico); el modo presentación (pantalla para el cliente) sigue mostrando únicamente los hallazgos, sin el ruido de 48 puntos.
- **La planilla original traía un bloque de 5 filas duplicado** ("TREN TRASERO" copiado y pegado dos veces al final) — se cargaron los 48 puntos únicos, no 53.
- Probado de punta a punta: sesión RADAR iniciada → "Nivel aceite motor" marcado "Atención" con nota → contador de avance actualizado (2/48) → "Convertir en hallazgo" precargó el formulario correctamente → hallazgo agregado con precio → al finalizar y presentar, la pantalla de cliente mostró solo el hallazgo, sin el checklist. Datos de prueba limpiados (OT 14031, cliente "PruebaRadar Checklist", vehículo "PRUE88").

## 2026-09-20 — Catálogo de servicios y precios (`0027_catalogo_servicios.sql`, `0028_seed_catalogo_didial.sql`)

**Qué se entrega:** el cliente compartió su planilla real de precios ("Base de datos de precios Didial") y pidió un flujo guiado: tipo de vehículo → categoría → servicio, con precio de mano de obra automático y repuestos sugeridos cargados solos a la OT.

- **Reconciliación de datos, no carga directa.** La planilla original tenía 13 variantes de "Tipo Vehículo" (tamaño y combustible mezclados: AUTO 4L/5L, SUV GRANDE BENCINERO/DIESEL, PICK UP/VAN/FURGON combinado, VAN/FURGON/CAMION DOBLE RODADO, TODOS...). El cliente decidió simplificar a las 4 categorías de carrocería que ya existían (`tipo_carroceria`, agrupando sedán/hatchback como "auto") cruzadas con `tipo_combustible` (bencina/diésel) -ambas columnas ya existían en `vehiculos` desde el Bloque 2, nunca se habían usado en ninguna pantalla-. Un script de reconciliación (no carga a mano) redujo las 13 variantes con una cadena de prioridad clara y documentada -precio específico por combustible primero, luego genérico del tipo, luego el compartido "PICK UP/VAN/FURGON", luego "TODOS" como último recurso-, respetando siempre la columna "Aplica" (una fila en "No" nunca se usa como precio ni de respaldo). Resultado: 340 servicios, 1137 combinaciones de precio, 117 repuestos, 277 vínculos servicio→repuesto. Solo 2 servicios quedaron sin precio resoluble, y ambos son casos reales de "No aplica a nada" en la propia planilla.
- **Esquema nuevo multi-tenant** (`catalogo_servicios`, `catalogo_servicio_precios`, `catalogo_repuestos`, `catalogo_servicio_repuestos`): con `empresa_id` como cualquier otro catálogo del proyecto -el precio de Didial no queda hardcodeado en el código-.
- **RPC `agregar_servicio_catalogo`**: dado un servicio y la OT, resuelve el precio más específico para el vehículo real (tipo+combustible exacto, si no tipo solo, si no universal), crea la tarea de mano de obra con ese precio ya cargado, agrega los repuestos típicos como ítems pendientes de presupuesto (editables/eliminables, sin precio -se cotizan caso a caso-), y si el servicio trae un insumo estimado lo agrega también con su precio.
- **El precio de catálogo es un precio ya aprobado por la empresa, no una edición manual de costo/margen** -la protección de precios del Bloque 5 (nadie sin `tiene_acceso_montos()` puede cargar costo/precio) se mantiene intacta para cualquier edición manual; el RPC usa una bandera de sesión (`app.bypass_precio_protegido`) que solo él enciende, para que un técnico o asesor sin acceso a montos pueda igual agregar un servicio del catálogo con su precio ya fijado.
- Interfaz nueva en la ficha de la OT ("Agregar servicio del catálogo"): categoría (agrupada por segmento/isla) → servicio → técnico opcional, con aviso de para qué tipo/combustible se calculó el precio. El formulario libre de "Agregar tarea"/"Agregar ítem" sigue disponible debajo, sin cambios, para lo que no está en el catálogo.
- `NuevoIngreso.jsx` ahora pide el combustible del vehículo (select bencina/diésel, junto al tipo de carrocería) — campo que existía en la base desde el Bloque 2 pero nunca se había preguntado en ninguna pantalla.
- **Bug propio encontrado y corregido antes de correr la migración:** el RPC usaba `select * into v_precio from ... record` para el precio resuelto; si un servicio no tenía precio para cierto tipo/combustible (0 filas), intentar `v_precio.campo := valor` sobre un `record` sin asignar habría lanzado un error real de Postgres la primera vez que alguien probara un servicio "no aplica" para su vehículo. Corregido usando variables escalares en vez de un `record`, donde un `SELECT INTO` sin resultados simplemente deja `NULL` sin error.
- Probado de punta a punta: OT con un SUV diésel → categoría "Embrague" → servicio "Cilindro esclavo (+Insumos)" → se creó la tarea de mano de obra con $35.700 (precio SUV, sin distinción de combustible para ese servicio específico -verificado contra el análisis manual de la planilla-), se agregó el repuesto "Cilindro esclavo de embrague" pendiente de presupuesto, y se agregó el insumo con $20.000 ya cargado. Datos de prueba limpiados (OT 14030, cliente "PruebaCatalogo Servicios", vehículo "PRUE89").

## 2026-09-19 — Bloqueo de edición al cerrar la OT + observaciones de postventa (`0026_bloqueo_ot_cerrada.sql`)

**Qué se entrega:** el cliente pidió que, al marcar una OT como entregada, la información quede fija -tareas, ítems, precios y decisiones no se puedan seguir editando después de que el cliente ya se llevó el vehículo y firmó el documento impreso-, con una única excepción: seguir pudiendo agregar observaciones de postventa (llamados de seguimiento, reclamos, garantías).

- **Protección en dos capas** (RLS no alcanza sola porque todos los roles comparten el rol `authenticated`, mismo criterio que la protección de precios del Bloque 5): un trigger en `ot_detalle`/`tareas_taller` rechaza cualquier escritura mientras `trabajos_taller.bloqueada_en` no sea NULL -probado directo contra la API, sin pasar por la interfaz, y rechazó el intento correctamente-. El trigger deja pasar a `service_role` (la sincronización con ClickUp sigue reflejando el estado real de una tarjeta aunque la OT ya esté cerrada).
- El bloqueo se activa solo al marcar "entregado" (vía trigger). Admin/socia puede **reabrir la OT** para corregir un error real y **volver a bloquearla** después -ambas acciones quedan auditadas (`reabierta_por`/`reabierta_en`)-.
- Tabla nueva `observaciones_postventa`: bitácora de solo lectura+inserción (sin UPDATE/DELETE, es un registro de lo que pasó) que se sigue pudiendo escribir aunque la OT esté bloqueada -la excepción explícita que pidió el cliente-. Sección nueva al final de la ficha de la OT.
- Probado de punta a punta: OT con un ítem → cerrada → los formularios de agregar tarea/ítem se reemplazaron por el aviso de "OT cerrada", el checkbox de verificado y los inputs de costo/precio/decisión quedaron deshabilitados → un `PATCH` directo a la API (sin pasar por la UI) fue rechazado por el trigger con el mensaje esperado → "Reabrir OT" liberó la edición → se agregó una observación de postventa → "Bloquear de nuevo" volvió a cerrarla, con la observación agregada visible después. Datos de prueba limpiados (OT 14029, cliente "PruebaBloqueo OT", vehículo "PRUE90").

## 2026-09-19 — Impresión del diagrama de daños + limpieza de documentos

**Qué se entrega:** revisando el formato ya unificado de los 3 documentos, el cliente encontró tres problemas concretos: el diagrama de daños no se veía al exportar a PDF, las marcas rojas tampoco, y un bloque de datos redundante en la Orden de Egreso.

- **El diagrama no se imprimía**: se dibujaba con `background-image` (CSS), y Chrome no imprime fondos a menos que la persona tenga activado "Gráficos de fondo" al exportar a PDF -ajuste que casi nadie activa-. Se reemplazó por un `<img>` real posicionado con recorte (mismo resultado visual, pero un `<img>` siempre se imprime, no depende de esa opción del navegador).
- **Las marcas rojas tampoco se imprimían** (mismo motivo: `background-color`). En vez de parchar cada elemento con color de fondo uno por uno, se agregó una regla `@media print { * { print-color-adjust: exact } }` global en `index.css` -cubre cualquier color de fondo dentro de un documento impreso del sitio, presente o futuro, en un solo lugar-.
- **Tamaños de recuadro parejos**: las 5 vistas tienen proporciones muy distintas entre sí (la superior es ancha, las laterales aún más). Antes cada recuadro se ajustaba a la proporción natural de su vista, dando cajas de tamaños dispares; ahora las 5 comparten un recuadro fijo (160×112) y el recorte se ajusta adentro tipo "object-fit: contain" -sin deformar ni cortar el dibujo-. **Encontrado y corregido un bug propio en el primer intento:** fijar `height: 100%` a la vez que `aspect-ratio` en el mismo elemento hacía que las vistas laterales (más anchas) se desbordaran y quedaran cortadas por el `overflow: hidden`; la corrección calcula a mano cuál lado (ancho o alto) debe ser el 100% según la proporción de cada recorte, en vez de dejarlo en manos de una combinación de CSS ambigua.
- Orden de Egreso: se quitó el bloque "Cliente/Quien Retira... Rut... Contacto", redundante con "Nombre Cliente"/"R.U.T." que ya muestra el encabezado de datos del cliente.
- Probado de punta a punta con capturas reales del PDF exportado (no solo en pantalla): las 5 vistas se ven completas, del mismo tamaño, y la marca roja con su número visible. Datos de prueba limpiados (OT 14027/PRUE92, OT 14028/PRUE91, cliente "PruebaPDF Diagrama").

## 2026-09-19 — Encuesta de postventa detallada + alerta de respuestas negativas (`0025_encuesta_detallada.sql`)

**Qué se entrega:** la encuesta de postventa (Bloque 7) solo pedía una calificación única 1-5. El cliente pidió desglosarla en 4 preguntas que cubren áreas distintas del negocio -tiempo de entrega, atención del asesor, servicio mecánico y una pregunta de recomendación que mezcla todo-, más "cómo conociste la empresa" y un espacio de sugerencias, y un tratamiento automático distinto según el resultado: negativo → avisarle a David e identificar la razón de fondo por área; positivo → agradecer la preferencia; excelente → invitar a dejar reseña en Google.

- **Clasificación calculada en la base** (no en el frontend, para que la página pública y la pantalla de resultados queden siempre consistentes): si CUALQUIERA de las 4 preguntas queda en 1-2 estrellas, la respuesta es "negativa" y se guarda exactamente qué área(s) fallaron (`areas_bajas`) -el cliente fue explícito: "no puedo dejar pasar a nivel interno ninguno de los puntos", así que un promedio alto no puede tapar un área puntual mala-. Si ninguna quedó baja, la pregunta "Recomendaría" decide entre excelente (5) y positivo (3-4).
- `empresas.google_review_url`: mismo patrón multi-tenant que el logo (Bloque anterior) — NULL hasta que el cliente consiga el link directo de "escribir reseña" de su Google Business Profile (un link de compartir ficha normal también sirve, pero requiere un clic extra del cliente).
- **Edge Function nueva `notificar-encuesta-negativa`**: la página pública la llama justo después de una respuesta negativa. Vuelve a leer la fila real por token (nunca confía en lo que mande el navegador), envía un correo a admin/socia con el desglose de qué área(s) revisar + la sugerencia + link directo a la OT, y usa una actualización atómica de `notificado_en` para no duplicar el aviso si la llamada se reintenta.
- **Página pública** (`EncuestaPublica.jsx`) rediseñada: 4 preguntas con carita, selector de "cómo conociste Didial" (catálogo fijo), campo de sugerencias, y un mensaje final distinto según el resultado -disculpa si es negativo, agradecimiento si es positivo, invitación a Google si es excelente (el botón solo aparece si `google_review_url` está cargado)-.
- **Pantalla nueva en el CRM** (`/encuestas`): todas las respuestas, filtrables por clasificación, con las negativas resaltadas en rojo y aviso de cuántas quedan por revisar, cada una con link directo a su OT.
- Probado de punta a punta con dos OT reales: una respuesta con "Atención del asesor" en 1 estrella clasificó negativo, guardó `areas_bajas: ['atencion_cliente']`, marcó `notificado_en` y no dejó ningún error en `integraciones_brevo_errores` (correo enviado); una respuesta con las 4 preguntas en 5 estrellas clasificó excelente y mostró el mensaje correcto (sin botón de Google, porque el link todavía no está cargado). Datos de prueba limpiados (OT 14024/PRUE96, OT 14025/PRUE94).

## 2026-09-19 — Ajustes de layout en los 3 documentos + calidad del diagrama de daños

**Qué se entrega:** tras revisar el formato unificado del bloque anterior, el cliente pidió cuatro ajustes puntuales: espacio de firma bien definido en la Orden de Ingreso, nota de vigencia en el Presupuesto, quitar un encabezado redundante en la Orden de Egreso, y revisar la calidad visual del diagrama de daños.

- **`BloqueFirma.jsx`** (nuevo, compartido por Ingreso y Egreso): recuadro de firma con altura fija y línea de base, siempre visible -antes, si el cliente no había firmado digitalmente, no quedaba ningún espacio reservado para firmar en el documento impreso en blanco-.
- **`BloqueTotales.jsx`** (nuevo, compartido por los 3 documentos): caja de ancho fijo para los montos, en vez de texto suelto alineado a la derecha -mismo espacio definido venga o no el documento con ítems cargados-.
- **`CampoDato.jsx`** (nuevo, compartido por los 3 documentos): reemplaza los bloques de texto con `&nbsp;&nbsp;` para separar campos (Nombre/Dirección/Marca/Modelo/etc.) por una grilla real de 4 columnas, cada campo con su propia etiqueta y línea -los campos vacíos ya no rompían la alineación visual-.
- Presupuesto: nota "Este presupuesto tiene una vigencia de 30 días a partir de la fecha de emisión." antes del total, en el mismo bloque que se ancla al final de la hoja al imprimir.
- Orden de Egreso: se quitó el encabezado "EGRESO DEL VEHÍCULO" -redundante con el título "ORDEN DE EGRESO" que ya trae el encabezado del documento-.
- **Calidad del diagrama de daños:** las imágenes de referencia de sedán/furgón/pick up venían en solo 550×550px combinados -las vistas individuales recortadas (frontal/posterior) quedaban en ~170px de ancho y se veían pixeladas al mostrarse más grandes-. Se reescalaron con interpolación bicúbica de alta calidad a 1650×1650 y se convirtieron a JPEG (evita que el anti-aliasing del reescalado infle el peso de un PNG). El SUV tenía una resolución inconsistente (1024×1024) y quedó parejo con el resto en 3000×3000. El peso total de las 5 imágenes bajó pese a la mejora de calidad.
- Probado de punta a punta y verificado visualmente con zoom sobre las vistas del diagrama -líneas limpias, sin pixelado visible-. Datos de prueba limpiados (OT 14023, cliente "PruebaLayout Documento", vehículo "PRUE98"; un cliente suelto "PruebaImagen Calidad" sin OT asociada).

## 2026-09-19 — Formato compartido de los 3 documentos + logo de Didial (`0024_logo_empresa.sql`)

**Qué se entrega:** el cliente pidió que los 3 documentos que emite el sistema (Orden de Ingreso, Presupuesto, Orden de Egreso) tuvieran un formato bien definido y consistente, recordando explícitamente que el proyecto es multi-tenant -"la idea es que sea fácilmente programable y exportable a otros casos u otras empresas"- y adjuntó el logo real de Didial para agregarlo a los 3.

- **`empresas.logo_url`** (nueva columna, NULL = sin logo) + bucket público `logos-empresa` en Storage (mismo patrón de carpetas por `empresa_id` que `radar-fotos`, pero público porque un logo no es dato sensible y así el documento impreso lo carga con un `<img src>` directo). Escritura restringida a admin/socia.
- **Componente nuevo `EncabezadoDocumento.jsx`**, compartido por los 3 documentos: logo (si existe) + nombre/dirección/correo/teléfono a la izquierda, título del documento (N° correlativo/OT, según cada uno) + fecha + página a la derecha. Todo sale de `empresa` (la fila de `empresas` del tenant actual, ya embebida en `AuthContext`) -ningún documento tiene texto de Didial fijo en el código-. `NuevoIngreso.jsx`, `PresupuestoDetalle.jsx` y `OrdenEgreso.jsx` reemplazaron su bloque de encabezado duplicado por este componente.
- **De paso, dos textos legales que sí tenían "DIDIAL Ltda." hardcodeado** (la cláusula de autorización en Políticas de Servicio de la Orden de Ingreso, y la cláusula de conformidad al retiro en la Orden de Egreso) se corrigieron para leer `empresa?.nombre` -inconsistentes con el resto del documento, que ya era dinámico desde el Bloque 3/6-.
- El logo también se usa **dentro de la app**: favicon/ícono PWA (`public/logo-didial.png`, activo de build de este deploy) y en el menú lateral (`Menu.jsx`, mismo patrón dinámico de `empresa.logo_url` que los documentos).
- Probado de punta a punta: OT nueva → Orden de Ingreso con logo y encabezado correcto → presupuesto generado desde esa OT → Presupuesto con el mismo formato → Orden de Egreso (`/trabajos/:id/egreso`) también correcta, incluida la cláusula de conformidad ahora con el nombre real de la empresa. Datos de prueba limpiados (OT 14022, cliente "PruebaLogo Documentos", vehículo "PRUE99").

## 2026-09-18 — Diagrama de daños al ingreso (`0022_diagrama_danos.sql`, `0023_carrocerias_hatchback_suv.sql`)

**Qué se entrega:** el cliente pidió poder marcar en un dibujo del vehículo dónde tiene daños o detalles al momento del ingreso, sobre planos de referencia reales que compartió (sedán, furgón, pick up, y después hatchback y SUV).

- `vehiculos.tipo_carroceria` (sedán/hatchback/suv/furgón/pick up) e `inspecciones_ingreso.diagrama_danos` (jsonb: lista de `{vista, x, y, nota}`) — mismo patrón de columna flexible ya usado para `preguntas_descubrimiento`.
- **Primer intento con SVG dibujado a mano, descartado por el cliente** ("Quedó horrible la imagen. Trata de copiar mejor la imagen de referencia o utilizar la misma que te pase"). Se reconstruyó `DiagramaVehiculo.jsx` para recortar por CSS las imágenes reales que el cliente guardó en disco, en vez de aproximarlas a mano: un decodificador de PNG escrito desde cero (sin librerías) ubica automáticamente las 5 sub-vistas (superior/frontal/lateral derecho/posterior/lateral izquierdo) dentro de cada imagen combinada, detectando los bordes de contenido por densidad de píxeles no blancos fila por fila/columna por columna.
- El asesor hace click sobre la vista que corresponda para marcar un daño con una nota corta; los hatchback (con una distribución de filas distinta a los otros 4 tipos) usan un layout de impresión propio.
- **Tamaño de impresión acotado a la mitad de la hoja** a pedido explícito del cliente ("la idea es que no cubra más de la mitad de la hoja de nuevo ingreso"), vía `print:max-w-[45%]`.
- Probado de punta a punta con datos reales para sedán, furgón, pick up, hatchback y SUV. Datos de prueba limpiados (OT 14019/14020/14021, vehículos PRUE18/PRUE19/PRUE21).

## 2026-09-16 — Kilometraje de salida en el cierre (`0021_kilometraje_egreso.sql`)

El kilometraje que se pide en el ingreso puede no ser el mismo al momento de retirar el vehículo (pruebas en ruta, traslados a servicios externos). El cliente pidió volver a pedirlo al cerrar, igual que lo muestra el papel real de "Egreso del Vehículo".

- `egresos_vehiculo.kilometraje_egreso` (nueva columna) capturado en el formulario de cierre, junto a un aviso si es menor al último kilometraje registrado -mismo patrón que el aviso de kilometraje del ingreso (Bloque 3)-.
- Al cerrar, además de guardarse en `egresos_vehiculo`, actualiza `vehiculos.kilometraje` -mismo criterio que ya usa `NuevoIngreso.jsx`: ese campo siempre refleja la última lectura conocida del odómetro-.
- El documento de Orden de Egreso ahora muestra este kilometraje de salida (con reintento al kilometraje general del vehículo si una OT vieja no lo tiene, por cerrarse antes de este cambio).
- Probado de punta a punta: OT con kilometraje de ingreso 50.000, cerrada con kilometraje de salida 50.120 → quedó guardado en `egresos_vehiculo` y actualizado en `vehiculos.kilometraje` → el documento de egreso mostró 50.120, no el de ingreso. Datos de prueba limpiados (OT 14018, cliente "PruebaKmEgreso", vehículo "PRUE15").

## 2026-09-16 — Orden de Egreso combinada + Cuentas por Cobrar

**Qué se entrega:** el cliente compartió los dos papeles reales que se entregan al retirar el vehículo -"Egreso del Vehículo" (quién retira, garantías, hora de salida, firma) y la "Orden de Trabajo" cerrada (mano de obra/repuestos/insumos con su total)- y pidió combinarlos en un solo documento ("Orden de Egreso"), emitido al cerrar y cobrar la OT, con tipo de documento (boleta/factura), un círculo azul/verde según el cliente sea empresa o particular, y registro de facturas pendientes de pago en un módulo nuevo de Cuentas por Cobrar.

### Modelo de datos (`0020_egreso_vehiculo.sql`)
- `trabajos_taller`: `tipo_documento` (boleta/factura, NULL si se cierra sin documento), `estado_pago` (solo aplica a factura -la boleta se considera pagada al cerrar, venta al contado-), `fecha_vencimiento_pago`, `fecha_pago`.
- Tabla nueva `egresos_vehiculo` (mismo patrón que `inspecciones_ingreso`: un registro por OT, en el cierre): quién retira (puede no ser el cliente registrado), comentario, observaciones de cierre, firma.
- **Decisión de seguridad tomada con el cliente:** el documento que recibe el cliente NUNCA muestra costo (solo cantidad/precio/total) -el papel de referencia sí lo mostraba, pero eso filtraría el margen del taller-.

### El formulario de cierre ahora pide
N° de documento → tipo (boleta/factura, solo si hay número) → si es factura, pagada ahora o pendiente (con fecha de vencimiento a mano, sin plazo fijo) → quién retira/RUT/contacto (precargado con el cliente registrado, editable) → observaciones de cierre → comentario → firma de conformidad al retiro.

### Documento nuevo: Orden de Egreso (`/trabajos/:id/egreso`)
Combina el encabezado de empresa, un círculo de color (azul = cliente empresa, verde = cliente particular), los datos de cliente/vehículo, los ítems **aceptados** agrupados por área con su TOTAL, la línea de "Factura/Boleta N°... · estado de pago" (omitida si se cerró sin documento), el texto legal de "Egreso del Vehículo" (garantías, hora de salida) copiado del papel real, y la firma.

### Módulo nuevo: Cuentas por Cobrar (`/cuentas-por-cobrar`)
Lista de todas las facturas (no boletas, que se consideran pagadas al cerrar), filtrable por pendiente/pagada/todas, con el total adeudado arriba, fecha de vencimiento marcada en rojo si está vencida, y botón "Marcar pagada" que registra `fecha_pago`.

### Probado de punta a punta (con un incidente de sesión, no de código)
Al reiniciar el servidor de desarrollo a mitad de las pruebas, una OT cerrada con factura guardó todos los campos nuevos en `null` -el formulario se veía bien en pantalla pero el cierre se guardó vacío-. Se investigó a fondo (datos correctos en cada input, sin errores de consola, la query manual funcionaba) antes de concluir que fue un artefacto del reinicio del servidor a mitad de sesión de pruebas (Vite reconectando/recargando la pestaña repetidas veces), no un bug real: se repitió la prueba completa con una OT nueva contra el servidor ya estable y todo se guardó correcto. **Lección para la próxima vez que haga falta reiniciar el dev server a mitad de una prueba: verificar que la consola ya no muestre "reconectando" antes de seguir interactuando con el formulario.** Con el servidor estable: OT con factura pendiente cerrada → Orden de Egreso mostró el círculo azul (cliente empresa) y la línea de factura pendiente correctamente → apareció en Cuentas por Cobrar → "Marcar pagada" la movió a pagada. Datos de prueba limpiados (OT 14016, OT 14017, cliente "PruebaEgreso SPA", vehículo "PRUE14"); ninguna se sincronizó con ClickUp.

## 2026-09-16 — El asesor ve precio (no costo) de los presupuestos + botón de WhatsApp

**Qué se entrega:** el cliente recordó una regla de negocio central que el módulo de Presupuestos de hoy no respetaba: "el asesor es el único que tiene contacto con el cliente en todo momento. Él envía y negocia los presupuestos gestionados". El asesor quedaba fuera de `tiene_acceso_montos()` -correcto para el costo/margen, pero un problema real para negociar un precio que no podía ver-.

### Separación precio de venta / costo (`0019_precio_venta_asesor.sql`)
- Nueva función `tiene_acceso_precio_venta()` = mismo grupo de `tiene_acceso_montos()` (socia/admin/encargado_presupuestos/jefe_taller) **más el asesor**. `ot_detalle_con_permiso` ahora gatea `precio_unitario`/`total_linea` con esta función nueva, mientras `costo_unitario` sigue exigiendo `tiene_acceso_montos()` sin cambios -el asesor nunca ve margen-.
- `presupuestos_taller` UPDATE ahora también permite al asesor (además del grupo de siempre) -es él quien recibe la respuesta real del cliente tras negociar y marca aceptado/parcial/rechazado-. El INSERT (generar el presupuesto) sigue exclusivo del encargado de presupuestos/admin/socia/jefe_taller.
- **Bug encontrado y corregido de paso, en el mismo cambio:** la vista ya devolvía el precio al asesor, pero `TrabajoDetalle.jsx` seguía ocultando la columna completa de Precio/Total (no solo Costo) detrás del mismo flag viejo que controla Costo -un frontend desincronizado del nuevo permiso del backend-. Se separó en dos flags (`tieneAccesoMontos` para costo/edición de precio, `tieneAccesoPrecioVenta` para ver precio/total de solo lectura) y se corrigió el `colSpan` dinámico de la fila "Cliente lo trae" para que siga alineada sin importar cuántas de las 3 columnas de montos ve cada rol.

### Botón de WhatsApp (`wa.me`, sin API de Meta)
- La integración real de WhatsApp Business (Meta Cloud API) sigue pospuesta desde el Bloque 8 (requiere verificación de negocio y aprobación de plantillas). En vez de eso: botón "Enviar por WhatsApp" en `TrabajoDetalle.jsx` (junto a cada presupuesto) y en `PresupuestoDetalle.jsx` (documento completo), que abre `https://wa.me/<telefono>` con un mensaje prellenado (resumen o detalle itemizado + total) usando `clientes.telefono_norm`. El asesor revisa y aprieta enviar él mismo desde WhatsApp Web/app -no hace falta ninguna credencial nueva, funciona hoy mismo-.

### Probado de punta a punta con las dos cuentas reales
Probado con la cuenta real de Diego Leyton (asesor) contra un presupuesto generado por David Vera (admin): Diego vio precio/total sin costo, no vio "Generar presupuesto", pudo marcar el presupuesto como rechazado (con `fecha_respuesta` registrada), y el enlace de WhatsApp abrió con el número y mensaje correctos en ambas pantallas. **Hallazgo de sesión (no bug de código):** las pestañas del navegador comparten la misma sesión de Supabase Auth (localStorage) -entrar como Diego en una pestaña cierra la sesión de admin en todas las demás-, hubo que alternar cuentas varias veces para probar ambos lados. Datos de prueba limpiados (OT 14015, cliente "PruebaAsesor Whatsapp", vehículo "PRUE13", presupuesto P-00003).

## 2026-09-16 — Módulo de Presupuestos (lista, documento real, seguimiento)

**Qué se entrega:** el cliente compartió el formato real de "Presupuesto" (Dimasoft) y pidió un módulo dedicado -tarea del encargado de adquisiciones (Víctor Tello, rol `encargado_presupuestos`)- con comunicación con las OTs y seguimiento de estado.

**Punto de partida importante:** el sistema ya tenía `presupuestos_taller` desde el Bloque 5 (correlativo P-00001, estados borrador/enviado/aceptado/parcial/rechazado/anulado) y un botón "Generar presupuesto" en cada OT que agrupa los ítems ya valorizados. Pero era un stub: sin documento imprimible y **sin ninguna forma de cambiar el estado** (nacía en "enviado" -el propio botón ya lo marca así al crearlo- y ahí se quedaba para siempre). No hizo falta ninguna migración: todas las columnas necesarias ya existían.

- **Página nueva `/presupuestos`** (lista de TODOS los presupuestos de todas las OTs, filtrable por estado, con aviso de cuántos están "enviado · esperando respuesta") — el "módulo" y el "seguimiento" real que pidió el cliente, en vez de tener que entrar OT por OT.
- **Página nueva `/presupuestos/:id`**: documento imprimible con el formato real (encabezado empresa, N° de presupuesto/fecha, patente/RUT/nombre cliente/color/año/marca/modelo, "Cliente Solicita" -mismo campo agregado ayer en `inspecciones_ingreso`, con el fallback exacto "Presupuesto creado sin solicitud." cuando está vacío-, ítems por área con CÓDIGO/DETALLE/CANTIDAD/PRECIO/TOTAL y subtotal, Mano de Obra con solo DETALLE/TOTAL, y NETO/I.V.A./TOTAL calculados de vuelta desde el total con IVA incluido: `neto = total/1.19`, `iva = total - neto`) + botones para avanzar el estado (aceptado/parcial/rechazado/anulado, con `fecha_respuesta` auto-registrada) y revertir por si hay un error.
- Los enlaces a presupuestos en `TrabajoDetalle.jsx` (línea "Presupuestos: P-00002 (enviado)") ahora apuntan al documento nuevo.
- Acceso restringido a `admin`/`socia`/`encargado_presupuestos`/`jefe_taller` (mismo grupo que ya ve montos desde el Bloque 5), consistente con Informes/Bodega.
- Probado de punta a punta con los mismos datos del PDF de referencia (repuesto $130.000, dos lubricantes $9.000/$5.000, mano de obra $47.600): el documento generado dio **exactamente** NETO $161.008, I.V.A. $30.592, TOTAL $191.600 -mismos números que el papel real-. Se probó también la transición de estado (enviado → aceptado, con fecha de respuesta registrada). Datos de prueba limpiados (OT 14014, cliente "PruebaPresupuesto Modulo", vehículo "PRUE12"); no se sincronizó con ClickUp así que no quedó nada que borrar ahí.

## 2026-09-15 — Taller por islas, formato real de Orden de Trabajo, y prueba de proceso completo

**Qué se entrega:** tres pedidos seguidos del cliente, todos probados en vivo contra producción (ClickUp y Brevo reales).

### Taller por islas (`0017_taller_islas.sql`)
Con la sincronización por tarea ya funcionando, el cliente pidió una vista que imite el taller físico: qué mecánico está haciendo qué, agrupado por isla (no por estado de OT, que ya muestra ClickUp), para ver carga de trabajo y tiempo real por vehículo.
- `usuarios_islas`: qué isla(s) cubre cada técnico, tabla configurable desde la pantalla nueva (`/taller`, admin/socia/jefe_taller) — un técnico puede cubrir más de una (caso real: Pablo Donoso, alineación y compras).
- `trabajos_taller.estado_cambiado_en`: cuánto lleva la OT en su etapa actual (`clickup_estado_actual`), actualizado solo en la transición real de ese campo vía trigger — no con `tareas_taller.estado`, que resultó ser un namespace de ClickUp completamente distinto (el estado propio de la subtarea, no la columna del tablero que ve el jefe de taller).
- El tablero se refresca solo cada 60s. Probado en vivo: alta/baja de asignación isla↔técnico funciona; la carga salió en `0` para todos porque ningún técnico tenía tareas asignadas sincronizadas todavía (el webhook recién se arregló hoy, así que las asignaciones de ANTES del fix nunca llegaron al CRM) — se va a ir llenando solo con el uso normal de ahora en adelante.

### Formato real de la Orden de Trabajo (`0018_orden_ingreso_formato.sql`)
El cliente compartió el papel real (Dimasoft/CamScanner) y pidió que el comprobante de Nuevo Ingreso saliera igual. Comparado campo a campo: `vehiculos.color`/`vin` ya existían desde el Bloque 2 pero el formulario nunca los pedía; faltaban `puertas` y `aseguradora` por completo; "Cliente Solicita" no tenía campo propio (se agregó separado de "Observaciones", que es para notas del asesor); "¿Eres dueño o conductor?" se modeló como dato de la visita puntual (`inspecciones_ingreso.rol_persona_presente`), no como el atributo permanente que ya existía en `clientes_vehiculos`. El comprobante impreso ahora trae encabezado de la empresa, N° de OT/fecha/página, los dos bloques de datos cliente/vehículo, "Cliente Solicita", el texto legal de "Políticas de servicio" (copiado tal cual del papel), y el bloque de firma con nombre/celular/dueño-o-conductor. Probado en vivo con un ingreso real: el documento salió visualmente equivalente al de referencia.

### Prueba de proceso completo, de punta a punta
El cliente pidió una prueba real con los dos correos (asesor + cliente) usando su propio correo (`admdidial@outlook.com`) para ambos roles. Secuencia probada contra producción real (OT 14013, cliente "PruebaCompleta Proceso", vehículo "PRUE11"):
1. Nuevo ingreso (con el formato nuevo) → asesor quedó automáticamente en quien tenía la sesión abierta.
2. Sincronizar con ClickUp → tarjeta creada.
3. El cliente movió la tarjeta a **LISTO PARA ENTREGA** en ClickUp → correo al asesor recibido y confirmado.
4. "Marcar como entregado" en el CRM → encuesta de postventa programada automáticamente.
5. Encuesta adelantada a hoy por SQL y enviada desde Oportunidades → correo de postventa al cliente recibido y confirmado.

**Los dos correos del ciclo de vida de una OT (aviso al asesor + encuesta al cliente) quedan confirmados funcionando de punta a punta con datos reales.** Datos de prueba limpiados; recordado al cliente borrar la tarjeta de ClickUp correspondiente.

## 2026-09-15 — Alta real del equipo de Didial + clave provisoria forzada

**Qué se entrega:** el cliente compartió la planilla real de personal
(`Usuarios.xlsx`, 12 personas con su correo y rol de taller) para dar de
alta las cuentas reales del CRM, con el número de ficha como clave
provisoria de cada persona.

### Verificación previa: asignación de mecánico por tarea vía ClickUp
Antes de dar de alta al equipo real, se probó en vivo la pregunta puntual
del cliente: *si el jefe de taller asigna un mecánico a una tarea en
ClickUp, ¿el CRM registra quién hizo cada tarea, tarea por tarea?* Se creó
una OT de prueba (14011, cliente "PruebaMecanico", vehículo "PRUE09") con
una tarea de mano de obra, se sincronizó con ClickUp, y el cliente asignó
un mecánico real a esa tarjeta. Resultado confirmado por SQL: el webhook
sí procesa la asignación por tarea individual -pero el campo que se llena
depende de si el correo del asignado de ClickUp matchea un `usuarios.correo`
existente (`tecnico_id`) o no (cae al respaldo `clickup_asignado_nombre`,
como pasó en esta prueba porque el mecánico todavía no estaba dado de alta
en el sistema). Esto confirmó que el alta real del equipo era necesaria
para que el Informe de retrabajos por técnico (Bloque 9) capture a todos.
Datos de prueba limpiados al cerrar (OT 14011, cliente y vehículo).

### Clave provisoria forzada (`0016_forzar_cambio_clave.sql`)
El cliente pidió usar el número de ficha de cada persona como clave
provisoria al crear su cuenta, pero exigiendo que la cambien por una propia
en el primer ingreso -el CRM no tenía ninguna pantalla de cambio de clave
ni forma de forzarlo-. Se agregó:
- `usuarios.debe_cambiar_clave` (boolean, default false).
- Función `marcar_clave_cambiada()` (`SECURITY DEFINER`, alcance mínimo:
  solo apaga el flag del propio `auth.uid()`). No se abrió la policy de
  UPDATE general de `usuarios` -esa sigue exigiendo `es_admin()`- para que
  nadie pueda auto-asignarse rol o activarse vía este mecanismo.
- `RutaProtegida` redirige a `/cambiar-clave` en cuanto detecta el flag en
  true, para cualquier ruta que no sea esa misma.
- Página nueva `CambiarClave.jsx`: pide la clave nueva dos veces, llama
  `supabase.auth.updateUser({password})` y luego `marcar_clave_cambiada()`.

Probado en vivo por el cliente con una cuenta real: la clave provisoria
lleva directo a "Define tu clave", y tras definirla ya no se vuelve a pedir
en sesiones siguientes.

### Alta de las 12 cuentas reales
Rol de taller → rol del sistema: Mecánico/Mecánico junior/Alineación-Compras
→ `tecnico`; Detailer → `detailer`; Jefe de taller → `jefe_taller`;
Administrador → `admin`; Asesor de servicios → `asesor`; Socio/Socia →
`socia`; Adquisiciones-Bodega → `encargado_presupuestos` (el rol del
sistema no tiene un equivalente literal de "bodega"; se usó ese porque es
el que da acceso a montos/costos, decisión confirmada por el cliente).
Las 12 cuentas quedaron creadas en Supabase Auth por el cliente, activadas
y con rol vía SQL, y con `debe_cambiar_clave = true`.

## 2026-09-15 — Flujo completo de estados de ClickUp + el webhook nunca había funcionado

**Qué se entrega:** el cliente detalló el resto del flujo real de estados
de ClickUp después de "agenda"/"POR DESIGNAR" (EN REPARACIÓN, EN REP.
SERVICIO EXTERNO, COMPRA REPTOS, ESPERA REPTOS (CLIENTE), PINTURA/
DESABOLLADURA, PRUEBA EN RUTA, RETROCESO, LAVADO, ALINEACIÓN, LISTO PARA
ENTREGA, COMPLETADAS). De ahí salieron tres necesidades concretas, resueltas
y probadas de punta a punta contra ClickUp real — y en el camino se
descubrió que **el webhook ClickUp→CRM nunca había funcionado, desde que se
desplegó en el Bloque 4**.

### Las tres necesidades del cliente
1. **RETROCESO = "retrabajo".** Cuando el jefe de taller mueve una tarjeta
   a RETROCESO, el CRM ahora vincula automáticamente esa OT a la más
   reciente ya entregada del mismo vehículo (mismo campo
   `trabajo_original_id` del Bloque 9). Si no encuentra una OT entregada
   anterior, lo deja registrado en `integraciones_clickup_errores` en vez
   de fallar en silencio.
2. **"ESPERA REPTOS (CLIENTE)"**: nuevo campo `ot_detalle.provisto_por_cliente`.
   Un repuesto marcado así no se valoriza -la tabla de Valorización muestra
   "Cliente lo trae · no se valoriza" en vez de los campos de costo/precio-
   y es mutuamente excluyente con vincular un producto de Bodega (si lo
   trae el cliente, no sale de nuestro inventario).
3. **"LISTO PARA ENTREGA"**: aviso activo por correo al asesor de la OT
   (reutiliza Brevo, ya wireado desde el Bloque 7), disparado solo en la
   TRANSICIÓN -se agregó `trabajos_taller.clickup_estado_actual` para
   comparar contra el estado anterior y no reenviar en cada evento
   mientras la tarjeta sigue en el mismo estado-.

### El hallazgo grande: el webhook nunca recibió una sola petición real
Al probar RETROCESO en vivo, nada pasaba -ni el vínculo automático ni un
error registrado-. Se rastreó en tres pasos:
1. **El webhook de ClickUp estaba `suspended`** (`fail_count: 103`) -
   ClickUp deja de intentar la entrega después de demasiados fallos
   seguidos-. Se reactivó vía `PUT /webhook/{id}` con `status: "active"`.
2. Al reactivarlo y disparar un evento nuevo, **Supabase respondía 401
   `UNAUTHORIZED_NO_AUTH_HEADER` antes de que el código de la función
   corriera.** Supabase exige por defecto un JWT propio en cada peticion a
   una Edge Function; ClickUp nunca manda eso -manda su propia firma HMAC,
   que se verifica *dentro* del código (`firmaValida()`), pero la petición
   nunca llegaba tan lejos-.
3. Se corrigió desplegando `clickup-webhook` con
   `supabase functions deploy clickup-webhook --no-verify-jwt` -flag
   correcto para un endpoint que llama un tercero externo y se autentica
   con su propia firma, no con un JWT de Supabase-.

**Esto explica los 103 fallos acumulados: el webhook estuvo roto desde el
día que se desplegó en el Bloque 4, silenciosamente, porque nunca se probó
contra tráfico real hasta ahora.** Ningún cambio hecho directamente en
ClickUp (nuevas subtareas del jefe de taller, ítems de checklist, cambios
de estado) se había reflejado jamás en el CRM.

### Bug real de regresión encontrado y corregido de paso
`reconciliarChecklists()` (dentro de `clickup-webhook`) tenía su propio
mapeo de nombres de checklist hardcodeado por separado
(`REPUESTOS`/`LUBRICANTES E INSUMOS`/`SERVICIO EXTERNO`), que quedó
desincronizado en silencio cuando se corrigieron los nombres reales del
lado CRM→ClickUp más temprano en el día. Corregido invirtiendo la misma
constante (`NOMBRE_CHECKLIST_POR_AREA`) en vez de mantener una copia aparte.

### Base de datos (`0015_clickup_estados_avanzados.sql`)
- `trabajos_taller.clickup_estado_actual`, `ot_detalle.provisto_por_cliente`.
- `ot_detalle_con_permiso` extendida de nuevo (columna al final, mismo
  gotcha ya documentado del Bloque 6).

### Probado de punta a punta contra ClickUp real
Vehículo con una OT entregada (14009) → segunda OT del mismo vehículo
(14010), sincronizada a ClickUp → movida a RETROCESO en ClickUp real →
confirmado por SQL que `trabajo_original_id` apuntó a la 14009 → movida a
LISTO PARA ENTREGA → correo recibido de verdad por el asesor, confirmado
por el cliente, con `clickup_estado_actual` reflejando la transición. El
campo "cliente lo trae" probado en el CRM: badge visible, valorización
colapsada, mutuamente excluyente con el producto de bodega.

### Pendiente
- El segundo webhook que apareció en la respuesta de la API
  (`ehpstxrzsjwcevcafxgk.supabase.co/functions/v1/clickup-sync`) es de otro
  proyecto/experimento del cliente, confirmado por él mismo -no se tocó-.
- No se construyó nada para EN REP. SERVICIO EXTERNO, COMPRA REPTOS,
  PINTURA/DESABOLLADURA, PRUEBA EN RUTA, LAVADO, ALINEACIÓN ni COMPLETADAS
  -el cliente no pidió una acción concreta del CRM para esos estados, solo
  los tres detallados arriba-.

---

## 2026-09-15 — Primera prueba real de la sincronización con ClickUp

**Qué se entrega:** el botón "Sincronizar con ClickUp" nunca se había
probado en vivo (documentado como pendiente desde el Bloque 4, a propósito,
para no escribir en el ClickUp de producción sin permiso explícito). El
cliente pidió probarlo hoy, en ambas direcciones (CRM→ClickUp y
ClickUp→CRM revisando la tarjeta real). Aparecieron y se corrigieron
varios bugs reales de primera ejecución.

### Bugs reales encontrados y corregidos
1. **`obtenerMiembrosEquipo()` llamaba a un endpoint que no existe.**
   `GET /team/{team_id}` no es parte de la API de ClickUp v2 -solo existe
   `GET /team` (sin id), que lista todos los workspaces autorizados-. La
   llamada devolvía un cuerpo sin `.teams`, y `datos.teams[0]` explotaba
   con "Cannot read properties of undefined". Se corrigió trayendo la
   lista completa y filtrando por `CLICKUP_TEAM_ID`.
2. **`crearItemChecklist()` y `crearChecklist()` asumían la forma de
   respuesta equivocada.** Ambos endpoints de "crear" de ClickUp devuelven
   el objeto contenedor completo (`{ checklist: {...} }`), no el recurso
   recién creado suelto en la raíz. El síntoma real fue silencioso y
   peligroso: el `UPDATE` a `ot_detalle`/`clickup_checklist_item_id` recibía
   `undefined`, supabase-js lo omitía del payload, la fila nunca quedaba
   vinculada, pero el contador `itemsSincronizados` igual se incrementaba
   -el mensaje decía "sincronizado" cuando en la base seguía sin
   vincularse-. Se corrigió leyendo `respuesta.checklist` (y, para el ítem,
   buscándolo por nombre dentro de `checklist.items`, porque ese endpoint
   no devuelve el id del ítem nuevo en ningún otro lado).
3. **Nombres de los tres checklists corregidos** por el cliente revisando
   la tarjeta real: `Repuestos` / `Lubricantes e insumos` / `Servicios
   Rápidos` (no las mayúsculas ni el "SERVICIO EXTERNO" asumidos al
   inspeccionar el workspace en el Bloque 4).
4. **Kilometraje con respaldo:** el campo personalizado de ClickUp solo se
   llenaba si el kilometraje se había capturado en ESE ingreso puntual.
   Ahora usa `vehiculos.kilometraje` (el último conocido) como respaldo
   cuando el ingreso no lo registró.

### Estado inicial de la tarjeta según el origen (requisito nuevo del cliente)
El cliente pidió que la tarjeta nazca en un estado distinto según si el
vehículo entró por una cita agendada (`agenda`) o como ingreso directo sin
cita (`POR DESIGNAR`, texto exacto confirmado por el cliente). Esto
requirió cerrar una pieza que había quedado pendiente desde el Bloque 8:

- **`trabajos_taller.cita_id`** (migración `0014_ingreso_desde_cita.sql`):
  `NuevoIngreso.jsx` ahora ofrece un selector "¿Viene de una cita
  agendada?" cuando el cliente tiene citas abiertas sin vincular, y al
  registrar el ingreso marca esa cita como `completada` y le setea su
  `trabajo_id` -mismo patrón ya usado para "retrabajo"-. De ahí sale el
  estado con el que `clickup-sincronizar` crea la tarjeta.
- **Bug real de PostgREST encontrado al probar esto mismo:** agregar
  `trabajos_taller.cita_id` creó una SEGUNDA relación entre `citas` y
  `trabajos_taller` (la inversa de `citas.trabajo_id` que ya existía).
  `Agenda.jsx` embebía `trabajos_taller(numero_ot)` sin ambigüedad hasta
  ahora; con dos relaciones, PostgREST ya no puede adivinar cuál usar y
  falla con "more than one relationship was found". Se corrigió nombrando
  la restricción a mano: `trabajos_taller!citas_trabajo_id_fkey(...)`.
  **Cualquier columna nueva que cree una segunda FK entre dos tablas ya
  embebidas en otra consulta rompe esa consulta -revisar antes de agregar
  una FK "de vuelta" entre tablas que ya se relacionan de otra forma.**
- **Bug real de zona horaria encontrado en el mismo selector:** la fecha
  de la cita se mostraba un día antes (`new Date("2026-09-15")` se
  interpreta como medianoche UTC, y `toLocaleDateString` la muestra un día
  antes en cualquier huso horario negativo, Chile incluido). Se corrigió
  formateando el string `YYYY-MM-DD` directo, sin pasar por `Date`.

### Probado de punta a punta contra producción (ClickUp real)
Cliente + vehículo de prueba → OT sin cita (14007): tarjeta creada, mano de
obra y repuesto sincronizados, confirmado con el cliente que nació en
**POR DESIGNAR** → cita agendada + segunda OT del mismo cliente/vehículo
(14008) vinculada a esa cita: tarjeta creada, confirmado que nació en
**agenda**. Ambos estados verificados visualmente por el cliente en el
tablero real.

### Pendiente
- Solo se probó la dirección CRM→ClickUp a fondo; la dirección
  ClickUp→CRM (webhook) no se volvió a ejercitar en esta sesión más allá
  de confirmar visualmente el estado de las tarjetas -sigue pendiente una
  prueba real de "cambiar algo en ClickUp y ver que el CRM lo refleje".

---

## 2026-09-15 — Punto de venta (fuera del orden de construcción original)

**Qué se entrega:** con los 10 bloques del spec original completados, el
cliente pidió una funcionalidad nueva no contemplada en el spec: venta de
mostrador -servicios rápidos puntuales o productos de bodega- sin pasar
por Nuevo Ingreso ni crear una OT.

### Diseño
- Dos tipos de línea: **servicio** (texto libre + precio, sin catálogo
  estructurado — el catálogo de 313 servicios del spec nunca se construyó
  como tabla en ningún bloque, y agregarlo solo para esto habría sido
  sobre-construir) y **producto** (vinculado al catálogo de Bodega del
  Bloque 10).
- **Reutiliza el mecanismo de `movimientos_stock` del Bloque 10** en vez de
  inventar uno nuevo: agregar una línea de producto descuenta stock de
  inmediato (motivo `venta`, nuevo valor agregado al `CHECK` existente);
  quitar una línea mientras la venta sigue `abierta` repone el stock. Una
  vez `cerrada` (cobrada), la venta queda fija — mismo criterio que una OT
  `entregada`.
- Sin manejo de pago real (monto recibido, vuelto, método de pago): solo
  registra el número de documento que emite Dimasoft, igual que el cierre
  de OT del Bloque 5.
- Cliente opcional: una venta de mostrador no siempre necesita identificar
  a quien compra.
- Acceso: asesor/recepcionista/admin/socia — mismo criterio de "quien
  atiende el mostrador" que ya se usó para `citas` (Bloque 8), no
  `tiene_acceso_montos()` -esa protección es sobre costo/margen interno en
  negociación de una OT, acá el precio de venta es justo lo que el
  mostrador necesita poder escribir-.

### Base de datos (`0013_punto_venta.sql`)
- `ventas_directas` (estado abierta/cerrada/anulada) + `ventas_directas_detalle`
  (tipo servicio/producto, `total_linea` calculado por la base).
- Dos triggers espejo: `aplicar_venta_directa_detalle` (descuenta al
  insertar una línea de producto) y `reponer_venta_directa_detalle`
  (repone al borrarla). RLS solo permite borrar una línea mientras la
  venta sigue `abierta`.

### Probado de punta a punta contra producción
Línea de servicio agregada → línea de producto agregada (stock bajó en
vivo) → línea de producto quitada (stock repuesto) → línea de producto
agregada de nuevo → venta cerrada con documento Dimasoft, sin cliente →
apareció correctamente en "Ventas recientes". Los tres caminos que tocan
`movimientos_stock` (alta, descuento por venta, reverso) quedaron
verificados por separado.

### Pendiente
- Si se recarga la página a mitad de una venta, el carrito visible se
  pierde -la venta queda igual `abierta` en la base, con sus líneas
  intactas, pero no hay forma de retomarla desde la interfaz-. Limitación
  consciente de esta primera versión, no un bug: para el volumen de un
  mostrador de taller (una venta a la vez, se cobra en el momento) el
  caso es raro, pero si empieza a pasar seguido conviene agregar una
  pantalla de "ventas abiertas" para retomarlas.

---

## 2026-09-14 — Bloque 10: Bodega, etapa 1

**Qué se entrega:** el spec marca este bloque como "el más grande del
proyecto, conviene dividirlo en etapas" y deja su alcance sin definir a
propósito -a diferencia de todos los bloques anteriores, no tiene sección
propia en el spec-. Se acordó con el cliente antes de construir:

1. **Los tres problemas a la vez** (no priorizar uno solo): sin
   visibilidad de stock real, repuestos de la OT sin descontar inventario,
   compras a proveedores sin registrar.
2. **Una sola bodega física** (no hay múltiples ubicaciones todavía).
3. **Conectado a la OT desde el día 1**, no como etapa separada.

Fuera de esta etapa a propósito, para no sobre-construir el módulo más
grande del spec de una sola vez: múltiples bodegas, código de barras,
órdenes de compra con flujo de aprobación, costeo FIFO/promedio ponderado
(se usa "último costo conocido"), y alertas automáticas de stock bajo por
correo/WhatsApp (la pantalla sí muestra el aviso visual).

### Base de datos (`0012_bodega.sql`)
- `proveedores`, `productos` (catálogo con `stock_actual`/`costo_promedio`
  mantenidos por trigger, nunca editables a mano) y `movimientos_stock`
  (historial de entradas/salidas/ajustes; `cantidad` positiva = entrada,
  negativa = salida — el signo ES la dirección, no una columna aparte).
- `ot_detalle.producto_id`: vínculo opcional al catálogo. Al marcar el
  ítem `verificado = true` (columna que ya existía desde el Bloque 4 como
  espejo del `resolved` de ClickUp) se descuenta stock automáticamente —
  solo en la transición `false→true`, para no descontar dos veces si se
  edita otra columna del ítem después.
- **`ot_detalle_con_permiso` (Bloque 5/6) extendida** con `producto_id` +
  nombre/stock del producto vía join — mismo gotcha ya documentado del
  Bloque 6: las columnas nuevas de una vista van siempre al final de la
  lista, nunca en medio (`42P16`).
- RLS: lectura de bodega abierta a cualquiera activo de la empresa,
  escritura (incluye costos) restringida a `tiene_acceso_montos()`, mismo
  rol que ya decide precios en `ot_detalle` desde el Bloque 5.

### Interfaz
- `Bodega.jsx` (nueva, restringida a admin/socia/encargado de
  presupuestos/jefe de taller): catálogo con aviso visual de stock bajo
  mínimo, alta de producto con stock inicial, registro de movimientos
  (entrada/salida, motivo, proveedor, costo, referencia), panel de
  proveedores.
- `TrabajoDetalle.jsx`: el formulario de "Agregar ítem" ahora ofrece
  vincular un producto del catálogo (solo áreas repuestos/lubricantes e
  insumos). Se agregó también el control para marcar "Verificado" —**no
  existía ningún botón para eso en el CRM hasta ahora**: `verificado` solo
  se movía vía sincronización con ClickUp. Ahora se puede marcar desde
  cualquiera de los dos lados.

### Probado de punta a punta contra producción
Producto de prueba con stock inicial 10 (movimiento `ajuste` automático al
crearlo) → OT nueva con un repuesto vinculado a ese producto, cantidad 2 →
al marcar "Verificado" el stock bajó a 8 en vivo, con su
`movimientos_stock` (`motivo: uso_ot`, `cantidad: -2`) → movimiento manual
de entrada por compra (+5) confirmado subiendo el stock a 13. Los tres
caminos que escriben en `movimientos_stock` (alta de producto, uso en OT,
movimiento manual) quedaron verificados por separado.

### Pendiente para este bloque
- Sin reversión automática si un ítem verificado se desmarca o se edita
  después de haber descontado stock — hay que hacer un ajuste manual si se
  corrige un error, documentado como limitación consciente de la etapa 1.
- Próximas etapas (a definir cuándo el cliente las necesite): múltiples
  bodegas, órdenes de compra formales, alertas automáticas de stock bajo.

---

## 2026-09-14 — Bloque 9: Informes y tableros

**Qué se entrega:** "los tres números que definen el estado del negocio"
(sección 9 del spec), con su propia advertencia explícita: desconfiar de
indicadores perfectos, porque un 100% casi siempre significa que la
medición está mal hecha, no que el negocio sea impecable.

### Los tres indicadores del spec
1. **Retorno de clientes** — el spec cita 65,9% de vehículos que vienen una
   sola vez; el informe muestra el % real de clientes con más de una OT.
2. **Captura de datos en el ingreso** — RUT al 8,7% / kilometraje al 35% en
   el spec; el informe muestra el % real de clientes con RUT y de OT con
   kilometraje registrado, para poder verificar si la captura obligatoria
   del Bloque 3 de verdad mejoró el número.
3. **Presupuestos por decisión** — el spec marca el "100% aprobados" de
   Dimasoft como una medición falsa (los rechazos no se registraban); el
   informe muestra el desglose real (pendiente/aceptado/rechazado/
   postergado) que el Bloque 5 ya captura.

### Retrabajos por técnico (gap encontrado, no en ningún bloque anterior)
La sección 4 del spec pide explícitamente "los retrabajos se vinculan a la
OT original y al mecánico que ejecutó — es la base de la medición de
calidad", pero ningún bloque numerado lo había construido. Se agregó acá
por ser justo donde ese dato se consume:
- `trabajos_taller.trabajo_original_id` (nullable, autorreferencia): se
  completa a mano en Nuevo Ingreso cuando el asesor detecta que el
  vehículo vuelve por el mismo problema — aparece un selector opcional
  solo si ese vehículo ya tiene OT anteriores.
- El técnico se deriva de `tareas_taller` del trabajo **original** (no del
  retrabajo): no existe un campo "mecánico responsable" a nivel de OT, la
  mano de obra ya lo registra tarea por tarea desde el Bloque 4.

Probado de punta a punta: cliente + vehículo → OT 14004 (original) → OT
14005 con "¿Retrabajo de una OT anterior?" = OT 14004 → verificado por SQL
que `trabajo_original_id` quedó bien vinculado → tarea de mano de obra de
prueba insertada en la OT original (simulando una sincronización de
ClickUp, que no se ejercitó aquí a propósito) → el informe atribuyó
correctamente el retrabajo al técnico de esa tarea.

### Base de datos (`0011_informes.sql`)
- Cuatro funciones de solo lectura (`informe_retorno_clientes`,
  `informe_captura_datos`, `informe_presupuestos_decision`,
  `informe_retrabajos_por_tecnico`), todas acotadas a `mi_empresa_id()`.
- **Restricción de acceso no cubierta por RLS de tabla:** "visión para
  socia y administración" (tabla de bloques del spec) no es un filtro de
  fila, es una regla sobre quién puede correr la agregación completa. Se
  resolvió con un chequeo de rol (`es_admin() or es_socia()`) adentro de
  cada función en vez de una policy — mismo motivo que la protección de
  precios del Bloque 5: RLS filtra filas, no decide si alguien puede
  ejecutar una consulta agregada entera.

### Interfaz (`Informes.jsx`)
- Página nueva, restringida a admin/socia vía `RutaProtegida
  rolesPermitidos={['admin', 'socia']}` — primera vez que se usa ese
  parámetro (ya existía en el componente desde el Bloque 1, nunca se había
  necesitado). `App.jsx` ahora acepta un segundo argumento opcional en
  `paginaProtegida()` para esto.
- Cuatro tarjetas con barras de porcentaje simples (CSS, sin librería de
  gráficos) y una tabla para retrabajos por técnico.
- `NuevoIngreso.jsx`: selector opcional "¿Retrabajo de una OT anterior?",
  visible solo cuando el vehículo ya tiene OT previas.

### Pendiente para este bloque
- El indicador de retorno de clientes y captura de datos son honestos
  sobre datos de prueba/parciales hasta que se migre la cartera real de
  Didial (Bloque 11 del spec, "Migración de datos" — no confundir con
  bloques de construcción, es la migración de datos históricos que sigue
  pendiente de los archivos de exportación de Dimasoft).
- Sin informe de conversión RADAR por origen (`radar_tecnico` vs.
  `revision_asesor`) ni de postventa (calificación promedio de encuestas)
  — el spec no los pide explícitamente en la sección 9, quedan como
  candidatos naturales para una iteración futura del tablero.

---

## 2026-09-14 — Bloque 8: Recepción (agenda y capacidad por isla)

**Qué se entrega:** agenda de citas con capacidad real por tipo de isla.
WhatsApp (Meta Cloud API) queda explícitamente fuera de este bloque a
pedido del cliente — requiere verificación de negocio y aprobación de
plantillas, un proceso externo que puede tardar días — y se retoma como
bloque aparte cuando esas credenciales estén listas.

### Definición pendiente resuelta con el cliente (bloqueaba este bloque)
El spec original decía "5 vehículos/día con 4 islas", que no cuadraba. La
capacidad real, aclarada con el cliente: **4 islas de taller mecánico, 2 de
servicio rápido, 1 de alineación, 1 de pintura, 1 de lavado** (9 en total) —
`tipos_isla` quedó como catálogo por empresa (no una lista fija en código)
porque es multi-tenant: cada taller que se sume a la plataforma va a tener
su propia distribución.

### Corrección real encontrada después de la primera versión
La primera versión de `citas_cupos_disponibles` (migración `0009`) contaba
"1 cita = 1 cupo por todo el día" — el cliente corrigió esto de inmediato:
una mantención de taller mecánico dura 1-2h de las 8h disponibles (una isla
recibe varios vehículos en el día, no uno), servicio rápido/alineación
duran ~30 min, y pintura no tiene duración definida. Contar por día completo
subestimaba muchísimo la capacidad real. Se corrigió en `0010` (no se editó
`0009`, que ya había corrido en producción) agregando
`citas.duracion_estimada_minutos` y reescribiendo la función para comparar
**solapamiento de horario** (candidato vs. citas existentes ese día), no un
conteo plano. Duración u hora ausente se trata como "ocupa el cupo hasta el
cierre del día calendario" — conservador a propósito: mejor sobreestimar la
ocupación que prometer un cupo que en realidad no está libre. El frontend
replica el mismo criterio en `picoOcupacion()` (barrido de eventos
inicio/fin) para que las tarjetas del día muestren el pico real de
ocupación simultánea, no un conteo plano.

Probado contra producción: dos citas de Alineación (capacidad 1) el mismo
día en horarios que NO se solapan (09:00-09:30 y 10:00-10:30) no generaron
aviso de sobrecupo (pico correcto: 1/1); una tercera a las 09:15 -que sí se
solapa con la primera- sí mostró "Sin cupos disponibles a esa hora" de
inmediato.

### Base de datos (`0009_agenda.sql`, `0010_agenda_duracion.sql`)
- `tipos_isla`: catálogo por empresa (nombre, capacidad, orden), sembrado
  con los 5 tipos reales de Didial.
- `citas`: reserva de una isla en una fecha/hora, con `duracion_estimada_minutos`
  opcional, vehículo opcional (se agenda por teléfono sin patente confirmada
  a veces) y `trabajo_id` opcional para vincular manualmente al Nuevo Ingreso
  real cuando el vehículo llega (sin automatismo todavía).
- `citas_cupos_disponibles()`: cupos por solapamiento de horario, uso como
  aviso -no bloqueo- en el frontend, mismo criterio "avisa, no bloquea" que
  ya se usa para duplicados de cliente (Bloque 2).
- RLS: alta/edición de citas para asesor/recepcionista/admin/socia (mismo
  criterio de "1 · RECEPCIÓN" del Bloque 3); lectura abierta a cualquiera
  activo de la empresa.
- `categoria_servicio` de `trabajos_taller` (Bloque 3/4, ligado al campo de
  ClickUp) se dejó fuera a propósito de este catálogo: cubre solo 3 valores
  atados a esa integración externa y no alcanza para alineación ni lavado.

### Interfaz (`Agenda.jsx`)
- Selector de fecha, tarjetas de ocupación pico por isla (colorea ámbar si
  se pasó de capacidad), tabla de citas del día con cambio de estado inline
  (mismo patrón que `Oportunidades.jsx`).
- Formulario "Nueva cita": isla, hora y duración opcionales (con pista de
  duración típica según la isla elegida), búsqueda/alta de cliente igual que
  en `NuevoIngreso.jsx`, vehículo opcional si el cliente ya tiene alguno
  vinculado. Aviso de sobrecupo con checkbox explícito para agendar igual.

### Bug real encontrado y corregido (no relacionado a este bloque)
`npm run verificar` corre `eslint` ANTES de `vite build`. Si `dist/` quedaba
de una build anterior en el mismo entorno, ESLint lo relinteaba como código
fuente (service worker minificado incluido) y explotaba con ~600 errores
falsos. `dist/` está en `.gitignore` pero ESLint no lo lee solo. Corregido
agregando `{ ignores: ['dist/**', 'dist-ssr/**'] }` a `eslint.config.js`.

### Pendiente para este bloque
- Vincular `citas.trabajo_id` automáticamente desde `NuevoIngreso.jsx`
  cuando el vehículo llega de verdad — hoy es un paso manual (o simplemente
  no se usa) sin UI todavía.
- WhatsApp (Meta Cloud API): pendiente de credenciales, bloque aparte.
- Sin pantalla de administración para editar `tipos_isla` (capacidad,
  agregar/quitar islas) — hoy solo se puede ajustar por SQL directo.

---

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
