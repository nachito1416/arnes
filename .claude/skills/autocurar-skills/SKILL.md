---
name: autocurar-skills
description: Analiza el historial de la tarea finalizada para extraer soluciones a bugs, comandos útiles o patrones repetibles y guardarlos autónomamente como nuevos skills o lecciones técnicas.
---

# Skill: autocurar-skills (Auto-curación del arnés)

Este procedimiento estándar permite que el arnés aprenda por sí mismo al finalizar cada tarea, emulando el bucle cerrado de aprendizaje (closed learning loop) de Hermes Agent.

## Cuándo se dispara
- Al finalizar con éxito una tarea en `tasks.json` (antes de marcarla como terminada por completo).
- Cuando el usuario dice "guardá este truco/flujo" o el subagente Revisor corre la verificación de cierre de sesión.

## Pasos del procedimiento

1. **Analizar la sesión:**
   - Lee la última bitácora escrita en `progress/` y ejecuta un `git diff` si hay cambios en el código.
   - Identifica:
     - **Bugs resueltos:** ¿Qué causó el error y cómo se solucionó? (para evitar que vuelva a pasar).
     - **Procedimientos repetibles:** ¿Se configuró una herramienta, base de datos o servicio con pasos específicos?
     - **Comandos no triviales:** ¿Hubo algún comando complejo o atajo de terminal que funcionó?

2. **Decidir la clasificación del aprendizaje:**
   - **Caso A (Procedimiento completo / SOP):** Si el aprendizaje es un flujo de pasos reutilizable (ej: configurar Docker, migrar Prisma, formatear logs), **crea un nuevo Skill**.
   - **Caso B (Lección puntual o truco técnico):** Si es un dato o hack rápido (ej: "la versión X de Pytest rompe con Node Y"), **actualiza `memory/memory.md`**.
   - **Caso C (Preferencia de interacción del usuario):** Si descubriste un hábito o gusto del usuario (ej: "prefiere que las explicaciones no tengan código de ejemplo redundante"), **actualiza `memory/user_profile.md`**.

3. **Ejecutar la creación o actualización:**
   - **Para un nuevo Skill (Caso A):**
     - Crea la carpeta `.claude/skills/<nombre-del-skill-en-minúsculas-y-guiones>/`.
     - Crea el archivo `SKILL.md` dentro de esa carpeta.
     - Escribe el YAML frontmatter obligatorio (`name` y `description`) siguiendo el estándar `agentskills.io` y redacta los pasos claros en Markdown.
   - **Para lecciones técnicas o preferencias (Casos B y C):**
     - Usa la edición dirigida para añadir una sola línea con el aprendizaje en la sección correspondiente de `memory/memory.md` o `memory/user_profile.md`.

4. **Registrar el resultado:**
   - Deja constancia en el progreso de la sesión (`progress/`) sobre qué skill se creó o qué regla de memoria se añadió.
   - Informa al usuario brevemente: *"Autocuración: He registrado un nuevo skill en `.claude/skills/<nombre-skill>/` para automatizar este procedimiento en el futuro."*
