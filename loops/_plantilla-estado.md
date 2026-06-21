# Loop: <nombre> — estado

- **Objetivo (unidad de trabajo):** <qué tiene que lograr este loop; acotado y verificable>
- **Worktree / rama:** `loop/<nombre>`  (creado con `scripts/loop.*`)
- **Zona crítica:** SÍ / NO  (dinero/auth/datos/migraciones → si SÍ, gate humano antes de `main`)
- **Tope de iteraciones:** 4
- **Iteración actual:** 0
- **Estado:** en-curso | frenado-esperando-OK | done | abortado-por-tope

## Plan inicial (validado por el "doctor" antes de arrancar)
- <pasos>

## Historial de iteraciones
| # | Qué se intentó | Resultado (test / revisor / auditor) | Qué falló / aprendizaje |
|---|----------------|--------------------------------------|-------------------------|
| 1 |                |                                      |                         |

## Gates (compuertas — el loop no avanza si una falla)
- [ ] Tests / preflight en verde
- [ ] Revisor: **funciona**
- [ ] Auditor-seguridad: **es seguro**  (solo si zona crítica)
- [ ] Gate humano: OK del usuario  (obligatorio antes de `main` si zona crítica; antes de prod SIEMPRE)

## Próximo paso
- <qué sigue / qué espera del humano>
