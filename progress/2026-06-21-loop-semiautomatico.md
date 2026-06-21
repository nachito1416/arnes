# [2026-06-21] Montar el loop semi-automático (loop cerrado) — (rol: orquestador)

## Tarea
T-007 — Acoplar al arnés (loop abierto) un modo **loop cerrado/semi-automático**, rescatado de los
2 videos de loop engineering. Alcance elegido por el usuario: el loop **puede mergear a `main` solo**
en cambios normales; en **zona crítica frena para OK humano antes de `main`**; deploy a prod manual.

## Que se hizo
- **`scripts/loop.ps1` + `scripts/loop.sh`** — utilidad de **git worktrees** aislados (rama
  `loop/<nombre>` en un directorio hermano del repo). `new` / `list` / `clean`. Nunca toca `main`.
- **`.claude/commands/loop-cerrado.md`** — protocolo del loop: valida plan (doctor) → aísla
  (worktree) → itera implementador→revisor→(auditor si crítico) con **tope de 4 vueltas** → gates
  de salida → limpia. Con las 3 líneas rojas (gate humano antes de prod/zona crítica, tope, siempre
  en rama).
- **`loops/`** — estado durable (el "loop state" del video 2): `README.md` + `_plantilla-estado.md`
  (objetivo, zona crítica, iteración, historial, gates). Persiste entre sesiones.
- **Salvaguarda de seguridad:** en zona crítica el merge a `main` NO es automático aunque el auditor
  apruebe (motivo: `main` puede auto-deployar tipo Vercel y hay dinero de por medio).
- **Integración:** `CLAUDE.md` (mapa + "dos modos: abierto/cerrado"), `orquestador.md` (cómo dispara
  el loop), `README.md` (árbol). Worktrees fuera del repo → no se versionan; `loops/` sí (como progress/).

## Archivos tocados
- `scripts/loop.ps1` + `scripts/loop.sh` — NUEVOS (worktrees)
- `.claude/commands/loop-cerrado.md` — NUEVO (protocolo)
- `loops/README.md` + `loops/_plantilla-estado.md` — NUEVOS (estado durable)
- `CLAUDE.md` · `.claude/agents/orquestador.md` · `README.md` — integración
- `tasks.json` (T-007) · `memory/decisions.md` (ADR)

## Estado / verificacion
- **Worktree probado de punta a punta** (`loop.ps1 new/list/clean`): crea la rama aislada, la lista
  junto a main, la elimina y **no deja directorio basura** (`Test-Path → False`). main intacta.
- `init.ps1` (Windows) → **[OK] Arnes OK**, 5/5 verde, tasks.json con T-007 parsea, CLAUDE.md 102 líneas.
- `init.sh` (Bash) → **✓ Arnes OK**, INIT_EXIT=0. `loop.sh list` → LOOP_EXIT=0 (sin basura).
- Resultado: ✅ aprobado.

## Siguiente paso
- Probar el loop completo en una tarea real chiquita (no crítica) para ver el ciclo entero.
- Opcional: propagar el loop a las plantillas de `prompts-arnes.md` (hoy solo está en el arnés base).
