# [2026-06-21] Revertir subagentes de Gemini a Opus 4.8 + auditoría del arnés — (rol: revisor)

## Tarea
Revisión integral del arnés tras una actualización hecha con Gemini. Objetivo del usuario:
quitar la configuración que ponía los subagentes en `gemini-1.5-pro` y fijarlos en Opus 4.8
como tope; verificar que el arnés esté bien estructurado y cumpla lo que promete.

## Que se hizo
- **Subagentes → `model: opus`.** Los 4 (`orquestador`, `lector`, `implementador`, `revisor`)
  tenían `model: gemini-1.5-pro`; ahora corren TODOS en `model: opus` (Claude Opus 4.8).
- Se limpiaron las menciones a Gemini en descripciones y cuerpos de `implementador.md` y
  `revisor.md`, y los comentarios de modelo de los 4 agentes.
- **`prompts-arnes.md`** (plantillas para montar el arnés en otros proyectos): las 3 instrucciones
  de modelo pasan de `gemini-1.5-pro` / "según prefieras Gemini o Anthropic" a `model: opus`.
- **Inconsistencia estructural corregida:** el árbol de carpetas del `README.md` no reflejaba el
  "split memory" — faltaba `memory/user_profile.md` (que el preflight SÍ exige). Añadido.
- **`decisions.md`:** registrada la decisión (el cambio previo a Gemini no se había documentado,
  rompiendo el self-improving loop del propio arnés).
- Se dejaron a propósito las menciones conceptuales a Gemini en `README.md` (l.9, l.24): ahí
  ilustran "el modelo es intercambiable / el arnés permanece", no son configuración de ejecución.

## Archivos tocados
- .claude/agents/orquestador.md:5-6 — comentario + `model: opus`
- .claude/agents/lector.md:5-6 — comentario + `model: opus`
- .claude/agents/implementador.md:3,5-6,10 — descripción, frontmatter y cuerpo sin Gemini
- .claude/agents/revisor.md:3,5-6,11 — descripción, frontmatter y cuerpo sin Gemini
- prompts-arnes.md:4,31,84 — plantillas fijan `model: opus`
- README.md — árbol de `memory/` incluye `user_profile.md`
- memory/decisions.md — nueva entrada ADR 2026-06-21

## Estado / verificacion
- `& 'C:\Harness Engineering\scripts\init.ps1'` → **[OK] Arnes OK. Puedes empezar a trabajar.**
  (estructura completa, CLAUDE.md 82 líneas < 200, tasks.json parsea).
- `grep "^model:" .claude/agents/` → los 4 = `model: opus`. Sin `gemini-1.5-pro` en ningún agente.
- Resultado: ✅ aprobado.

## Siguiente paso
- Nada bloqueante. Tareas de fondo pendientes en `tasks.json`: T-001 (definir proyecto en
  CLAUDE.md §2), T-002 (conectar tests reales al preflight), T-003 (capas de verificación).
