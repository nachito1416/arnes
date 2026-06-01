# .claude/skills/ — Skills (SOPs reutilizables)

Un **skill** es un SOP (procedimiento operativo estándar) para el agente: le explicás un proceso
**una vez** y después lo invoca por nombre, sin repetir el ida y vuelta. Los skills **se acumulan**:
cada tarea recurrente que conviertas en skill es trabajo que no repetís nunca más.

## Formato (lo que descubre Claude Code)

Cada skill es una carpeta con un `SKILL.md`:

    .claude/skills/<nombre>/SKILL.md

Con frontmatter `name` + `description` (Claude Code usa la `description` para invocarlo solo):

    ---
    name: nombre-del-skill
    description: Cuándo usar este skill, en una frase clara.
    ---

    Los pasos del procedimiento, claros y en orden.

## Reglas

- Un skill = un proceso. `description` clara = se dispara cuando corresponde.
- ⛔ No metas secretos en un skill. Respetá la línea roja del `.env` y las zonas sensibles.
- Empezá de a poco: convertí **una** tarea recurrente por vez.

## Ejemplo incluido

- [`registrar-aprendizaje/`](registrar-aprendizaje/SKILL.md) — captura una corrección/preferencia
  del usuario en `memory/memory.md`. Conecta skills + memoria (el self-improving loop).
