// Verificación 4: columnas que el frontend escribe (.insert/.update) y que no
// existen en ninguna migración. Compara contra el esquema real en vez de
// esperar a que Postgres lo rechace en producción.
import { readFileSync } from 'node:fs'
import { extraerEsquema, listarArchivos } from './lib/esquemaSql.mjs'

const DIRECTORIO_MIGRACIONES = 'supabase/migrations'
const DIRECTORIO_FRONTEND = 'src'

function dividirPorComasDeNivelSuperior(texto) {
  const partes = []
  let profundidad = 0
  let actual = ''
  for (const caracter of texto) {
    if ('([{'.includes(caracter)) profundidad++
    if (')]}'.includes(caracter)) profundidad--
    if (caracter === ',' && profundidad === 0) {
      partes.push(actual)
      actual = ''
    } else {
      actual += caracter
    }
  }
  if (actual.trim()) partes.push(actual)
  return partes
}

function extraerClavesDeObjeto(cuerpoObjeto) {
  const claves = []
  for (const parteCruda of dividirPorComasDeNivelSuperior(cuerpoObjeto)) {
    const parte = parteCruda.trim()
    if (!parte || parte.startsWith('...') || parte.startsWith('[')) continue
    const coincidencia = /^["'`]?([A-Za-z_$][\w$]*)["'`]?\s*(:|$)/.exec(parte)
    if (coincidencia) claves.push(coincidencia[1])
  }
  return claves
}

// Encuentra el primer bloque `{...}` balanceado a partir de `desde`.
function extraerPrimerObjetoBalanceado(codigo, desde) {
  let inicio = codigo.indexOf('{', desde)
  if (inicio === -1) return null
  let profundidad = 0
  for (let i = inicio; i < codigo.length; i++) {
    if (codigo[i] === '{') profundidad++
    else if (codigo[i] === '}') {
      profundidad--
      if (profundidad === 0) return codigo.slice(inicio + 1, i)
    }
    // Un `[` antes de encontrar el primer `{` en insert([...]) no rompe nada:
    // igual buscamos el primer `{` que abre la fila.
  }
  return null
}

function buscarLlamadasInsertUpdate(codigo) {
  const llamadas = []
  const regexFrom = /\.from\(\s*['"`](\w+)['"`]\s*\)/g
  let coincidencia
  while ((coincidencia = regexFrom.exec(codigo))) {
    const tabla = coincidencia[1]
    const ventana = codigo.slice(regexFrom.lastIndex, regexFrom.lastIndex + 3000)
    const matchOperacion = /\.(insert|update|upsert)\(/.exec(ventana)
    if (!matchOperacion) continue
    const posicionAbs = regexFrom.lastIndex + matchOperacion.index + matchOperacion[0].length
    const cuerpoObjeto = extraerPrimerObjetoBalanceado(codigo, posicionAbs)
    if (cuerpoObjeto === null) continue
    llamadas.push({ tabla, operacion: matchOperacion[1], claves: extraerClavesDeObjeto(cuerpoObjeto) })
  }
  return llamadas
}

function main() {
  const esquema = extraerEsquema(DIRECTORIO_MIGRACIONES)
  const archivos = listarArchivos(DIRECTORIO_FRONTEND, ['.js', '.jsx'])
  const errores = []

  for (const archivo of archivos) {
    const codigo = readFileSync(archivo, 'utf8')
    for (const llamada of buscarLlamadasInsertUpdate(codigo)) {
      const columnasConocidas = esquema.get(llamada.tabla)
      if (!columnasConocidas) continue // tabla aún no migrada: no se puede verificar todavía

      for (const clave of llamada.claves) {
        if (!columnasConocidas.has(clave.toLowerCase())) {
          errores.push(
            `${archivo}: .${llamada.operacion}() sobre "${llamada.tabla}" usa la columna "${clave}", que no existe en ninguna migración.`
          )
        }
      }
    }
  }

  if (errores.length > 0) {
    console.error('✗ Verificación de columnas falló:\n')
    for (const error of errores) console.error(`  - ${error}`)
    process.exit(1)
  }

  console.log('✓ Verificación de columnas: todas las columnas usadas en insert/update existen en las migraciones.')
}

main()
