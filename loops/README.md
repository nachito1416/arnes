# loops/ — Estado durable de los loops semi-automáticos

> El **"loop state"** del que habla el video 2: archivos que **persisten el estado** de un loop
> entre sesiones para que no pierda el hilo ni se ahogue en ruido. Es la memoria de trabajo del
> loop, separada de [`progress/`](../progress/) (que es la bitácora de tareas puntuales).

Cada loop semi-automático tiene **un archivo de estado** acá (copialo de
[`_plantilla-estado.md`](_plantilla-estado.md)). Mientras el loop corre, se actualiza en cada
iteración: qué se intentó, qué falló, qué gate pasó. Así, si la sesión se corta o el contexto se
llena, el loop **retoma desde el estado, no desde cero**.

## Cómo se usa

1. Al arrancar un loop, el orquestador copia `_plantilla-estado.md` → `loops/<nombre>-estado.md`.
2. En cada vuelta (implementa → testea → revisa), actualiza ese estado.
3. Cuando el loop frena (gate humano) o termina, el estado queda como registro.

- **Protocolo completo:** [`.claude/commands/loop-cerrado.md`](../.claude/commands/loop-cerrado.md).
- **Aislamiento (worktrees):** [`scripts/loop.ps1`](../scripts/loop.ps1) / [`scripts/loop.sh`](../scripts/loop.sh).
