# verification/ — Verificación (Pilar 3)

> **El agente no termina porque diga que termino. Termina porque el arnes valido que termino.**

La IA puede mentir sin querer: una respuesta verosimil no es correcta. Por eso el arnes
verifica el trabajo en **capas**, no confia en el "ya quedo, todo funciona".

## Las capas de verificación

| Capa | Que comprueba | Como |
|------|---------------|------|
| **Tests automatizados** | Que la logica hace lo que debe | `scripts/init.*` + suite del proyecto |
| **Linter** | Estilo y errores comunes | `npm run lint`, `ruff`, etc. |
| **Type check** | Tipos / contratos | `tsc --noEmit`, `mypy`, etc. |
| **Playwright** | Flujo real de UI de punta a punta | Abre un navegador y comprueba el flujo |
| **Agente revisor** | Lectura critica + corre todo lo anterior | [`.claude/agents/revisor.md`](../.claude/agents/revisor.md) |

## Playwright (auto-diagnostico)

Para UI, el método mas potente: se le pide a Playwright que **abra un navegador y recorra el
flujo** (login, formulario, etc.), encuentre los errores y los reporte. Es verificacion
empirica: no "se ve bien", sino "se probo y funciona".

## El agente termina cuando el arnes lo valida

El **revisor** corre estas capas y **aprueba o rechaza**. Solo cuando aprueba, la tarea pasa
a `done` en [`tasks.json`](../tasks.json). Si rechaza, vuelve al implementador con evidencia.

## Self-improving loop

Como todo son archivos en una carpeta, si el revisor detecta algo mejorable puede **mejorar
el propio arnes** (reglas en `CLAUDE.md`, nuevos tests, nuevos agentes) y registrarlo en
[`memory/decisions.md`](../memory/decisions.md). El arnes se automejora con el tiempo en vez
de degradarse.

## Qué poner en esta carpeta

- Configuracion de tests/lint/typecheck especifica del arnes.
- Specs de Playwright (`*.spec.ts`) para los flujos criticos.
- [`tasks.schema.json`](tasks.schema.json): valida la forma de `tasks.json`.
