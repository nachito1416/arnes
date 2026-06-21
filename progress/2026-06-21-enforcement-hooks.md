# [2026-06-21] Enforcement del arnés por hooks — (rol: orquestador)

## Tarea
T-008 — Problema reportado por el usuario: a medio trabajo, Claude Code se salta partes del arnés
si no se le recuerda explícitamente que lo use al 100%. Hacer que el arnés se aplique solo, sin que
el usuario tenga que recordárselo.

## Que se hizo
- **Causa raíz:** las reglas en `CLAUDE.md`/agentes son instrucciones que el modelo *puede* ignorar
  cuando se llena el contexto. La solución determinística son **hooks** (los ejecuta el harness, no
  el modelo).
- **`verification/REGLAS-ARNES.md`** — recordatorio compacto (7 líneas) del checklist operativo:
  preflight antes de tocar código, flujo multiagente, nada "done" sin revisor, gate de seguridad en
  zona crítica, contexto mínimo + bitácora.
- **`.claude/settings.json`** (NUEVO, versionado) con 2 hooks que hacen `cat verification/REGLAS-ARNES.md`:
  - `SessionStart` → inyecta las reglas al iniciar la sesión.
  - `UserPromptSubmit` → inyecta las reglas en CADA turno → el modelo no las "olvida" a medio trabajo.
- **`.gitignore`** → `!/.claude/settings.json` (se versiona; `settings.local.json` sigue ignorado).
- El comando `cat` funciona igual en Git Bash y PowerShell → portable.

## Archivos tocados
- `verification/REGLAS-ARNES.md` — NUEVO (recordatorio)
- `.claude/settings.json` — NUEVO (hooks, versionado)
- `.gitignore` — versiona settings.json
- `tasks.json` (T-008) · `memory/decisions.md` (ADR)

## Estado / verificacion
- **pipe-test** `echo '{}' | cat verification/REGLAS-ARNES.md` → imprime el recordatorio, EXIT=0.
- **settings.json válido**, ambos hooks (`SessionStart` + `UserPromptSubmit`) con el comando correcto.
- **git check-ignore**: `settings.json` → versionado (ok); `settings.local.json` → ignorado (ok).
- Resultado: ✅ aprobado.
- ⚠️ **CAVEAT (importante para el usuario):** como `.claude/settings.json` no existía al iniciar esta
  sesión, el watcher de Claude Code puede no tomar los hooks hasta **abrir `/hooks` una vez** o
  **reiniciar Claude Code**. Tras eso, quedan activos en todas las sesiones.

## Siguiente paso
- El usuario debe abrir `/hooks` o reiniciar para activarlos en esta máquina.
- Opcional / a evaluar: enforcement más duro con un `PreToolUse` bloqueante sobre Edit/Write (no se
  hizo por ser más intrusivo). Propagar los hooks a las plantillas de `prompts-arnes.md`.
