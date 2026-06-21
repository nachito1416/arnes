# [2026-06-21] Propagar loop + hooks a las plantillas — (rol: orquestador)

## Tarea
T-009 — Que los próximos proyectos (impuestos) nazcan ya con el loop semi-automático y el
enforcement por hooks. Propagar ambos a las plantillas de `prompts-arnes.md` (A, B, D).

## Que se hizo
- **Encabezado:** ahora lista capa de seguridad + loop semi-automático + enforcement por hooks.
- **Prompt A** (proyecto existente): nuevos items `k)` (loop) y `l)` (hooks); item `i)` (.gitignore) versiona `.claude/settings.json`.
- **Prompt B** (desde cero): nuevos items `12` (loop) y `13` (hooks); item `11` (.gitignore) versiona `settings.json`.
- **Prompt D** (actualizar): punto 2 suma loop + hooks; punto 3 y la NOTA versionan `settings.json`.

## Archivos tocados
- `prompts-arnes.md` — plantillas A, B, D + encabezado
- `tasks.json` (T-009)

## Estado / verificacion
- Preflight `init.ps1` corrido ANTES de tocar (regla del arnés) → [OK] Arnes OK (5/5 verde).
- `grep` confirma `loop-cerrado` / `settings.json` / `REGLAS-ARNES` presentes en las plantillas.
- Resultado: ✅ aprobado.

## Siguiente paso
- Nada pendiente. El arnés plantilla quedó completo y propagado; los proyectos nuevos heredan todo.
