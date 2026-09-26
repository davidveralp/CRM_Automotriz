import { useState } from 'react'
import { supabase } from '../supabaseClient'
import { invocarFuncion } from '../lib/invocarFuncion'
import { hoyLocalISO } from '../lib/agenda'
import { formatearPatente } from '../lib/patente'

// ClickUp acepta unas 100 llamadas por minuto y cada OT usa una decena: se deja
// una pausa entre OT y, si aun así responde "Rate limit", se espera un minuto y se
// repite esa OT (la sincronización se puede repetir sin duplicar).
const PAUSA_ENTRE_OT_MS = 8000
const ESPERA_LIMITE_MS = 65000
const MAX_REINTENTOS_LIMITE = 2
const MAX_RONDAS_CITAS = 8

function esperar(milisegundos) {
  return new Promise((resolver) => setTimeout(resolver, milisegundos))
}

// Herramienta de la cuenta demo: refleja en la lista demo de ClickUp todo lo
// vigente del ambiente de prueba. Por cada OT activa crea (o completa) su
// tarjeta con el estado que ya tiene en el CRM, sus subtareas y sus listas de
// control; por cada cita vigente sin tarjeta, crea la suya en "agenda". Las OT
// entregadas y anuladas y las citas pasadas no se envían.
function SincronizarDemoClickUp() {
  const [preparado, setPreparado] = useState(null)
  const [trabajando, setTrabajando] = useState(false)
  const [progreso, setProgreso] = useState(null)
  const [resumen, setResumen] = useState(null)
  const [error, setError] = useState(null)

  async function preparar() {
    setError(null)
    setResumen(null)
    setTrabajando(true)
    try {
      const [respOts, respCitas] = await Promise.all([
        supabase
          .from('trabajos_taller')
          .select('id, numero_ot, clickup_task_id, vehiculos(patente)')
          .not('estado', 'in', '(entregado,anulado)')
          .order('numero_ot'),
        supabase
          .from('citas')
          .select('id')
          .in('estado', ['agendada', 'confirmada'])
          .gte('fecha', hoyLocalISO())
          .is('clickup_task_id', null),
      ])
      if (respOts.error) throw respOts.error
      if (respCitas.error) throw respCitas.error
      setPreparado({ ots: respOts.data || [], citas: respCitas.data || [] })
    } catch (excepcion) {
      setError(excepcion.message || 'No se pudo revisar lo que hay que enviar.')
    } finally {
      setTrabajando(false)
    }
  }

  async function sincronizar() {
    const { ots, citas } = preparado
    setTrabajando(true)
    setError(null)
    setResumen(null)
    const fallas = []
    let otsListas = 0
    let tarjetasNuevas = 0
    try {
      for (let indice = 0; indice < ots.length; indice++) {
        const ot = ots[indice]
        setProgreso(`OT ${ot.numero_ot} (${indice + 1} de ${ots.length})`)
        try {
          const antes = Boolean(ot.clickup_task_id)
          let resultado = null
          for (let intento = 0; intento <= MAX_REINTENTOS_LIMITE; intento++) {
            resultado = await invocarFuncion('clickup-sincronizar', { body: { trabajo_id: ot.id, forzar_estado: true } })
            const limitado = (resultado?.errores || []).some((falla) => /rate limit/i.test(falla.mensaje))
            if (!limitado || intento === MAX_REINTENTOS_LIMITE) break
            setProgreso(`OT ${ot.numero_ot} (${indice + 1} de ${ots.length}) - esperando el límite de ClickUp`)
            await esperar(ESPERA_LIMITE_MS)
          }
          otsListas++
          if (!antes) tarjetasNuevas++
          for (const falla of resultado?.errores || []) {
            fallas.push(`OT ${ot.numero_ot} (${formatearPatente(ot.vehiculos?.patente)}): ${falla.mensaje}`)
          }
        } catch (excepcion) {
          fallas.push(`OT ${ot.numero_ot} (${formatearPatente(ot.vehiculos?.patente)}): ${excepcion.message}`)
        }
        await esperar(PAUSA_ENTRE_OT_MS)
      }

      let citasEnviadas = 0
      if (citas.length > 0) {
        setProgreso(`Citas (${citas.length})`)
        const { error: errorMarcar } = await supabase
          .from('citas')
          .update({ clickup_pendiente: true })
          .in(
            'id',
            citas.map((cita) => cita.id)
          )
        if (errorMarcar) throw errorMarcar
        for (let ronda = 0; ronda < MAX_RONDAS_CITAS; ronda++) {
          const resultado = await invocarFuncion('clickup-agendar-cita', { body: {} })
          citasEnviadas += resultado?.creadas || 0
          for (const falla of resultado?.errores || []) fallas.push(`Cita: ${falla.mensaje}`)
          if (!resultado?.procesadas) break
          await esperar(PAUSA_ENTRE_OT_MS)
        }
      }

      setResumen({ otsListas, tarjetasNuevas, totalOts: ots.length, citasEnviadas, totalCitas: citas.length, fallas })
      setPreparado(null)
    } catch (excepcion) {
      setError(excepcion.message || 'La sincronización se interrumpió. Se puede volver a correr sin duplicar tarjetas.')
    } finally {
      setProgreso(null)
      setTrabajando(false)
    }
  }

  return (
    <section className="mb-5 max-w-3xl rounded-lg border border-sky-200 bg-sky-50 p-4 text-sm text-sky-900">
      <h2 className="font-semibold">Sincronizar la demo con ClickUp</h2>
      <p className="mt-1 text-sky-800">
        Envía a la lista demo de ClickUp las OT activas (con su estado, subtareas y listas de control) y las citas vigentes que aún no tienen tarjeta. Se puede repetir sin duplicar.
      </p>

      {error && <p className="mt-2 rounded border border-red-200 bg-red-50 px-3 py-2 text-red-700">{error}</p>}

      {!preparado && !trabajando && (
        <button type="button" onClick={preparar} className="mt-3 rounded bg-slate-900 px-3 py-1.5 font-medium text-white hover:bg-slate-800">
          Revisar lo que se enviará
        </button>
      )}

      {preparado && !trabajando && (
        <div className="mt-3">
          <p>
            Se enviarán {preparado.ots.length} OT activas ({preparado.ots.filter((ot) => !ot.clickup_task_id).length} sin tarjeta todavía) y{' '}
            {preparado.citas.length} citas vigentes sin tarjeta.
          </p>
          <div className="mt-2 flex gap-2">
            <button type="button" onClick={sincronizar} className="rounded bg-slate-900 px-3 py-1.5 font-medium text-white hover:bg-slate-800">
              Enviar a ClickUp
            </button>
            <button type="button" onClick={() => setPreparado(null)} className="rounded border border-slate-300 bg-white px-3 py-1.5 text-slate-700 hover:bg-slate-50">
              Cancelar
            </button>
          </div>
        </div>
      )}

      {trabajando && <p className="mt-3 font-medium">Procesando {progreso || '…'}. No cierres esta página.</p>}

      {resumen && (
        <div className="mt-3 space-y-1">
          <p className="font-medium">
            Listo: {resumen.otsListas} de {resumen.totalOts} OT ({resumen.tarjetasNuevas} tarjetas nuevas) y {resumen.citasEnviadas} de {resumen.totalCitas} citas enviadas.
          </p>
          {resumen.fallas.length > 0 && (
            <div className="rounded border border-amber-300 bg-amber-50 p-2 text-amber-900">
              <p className="font-medium">{resumen.fallas.length} avisos de ClickUp:</p>
              <ul className="mt-1 max-h-48 list-disc space-y-0.5 overflow-auto pl-5 text-xs">
                {resumen.fallas.map((falla, indice) => (
                  <li key={indice}>{falla}</li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}
    </section>
  )
}

export default SincronizarDemoClickUp
