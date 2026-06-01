# Registro de decisiones (ADR ligero)

Cada decision relevante del proyecto o del arnes se anota aqui, en orden cronologico. Formato
minimo: fecha, decision, por que, y consecuencias. El **revisor** puede agregar entradas
cuando mejora el arnes (self-improving loop).

---

## 2026-05-30 — Adoptar Harness Engineering como base del proyecto

- **Decision:** estructurar el proyecto como un arnes (3 pilares) en vez de atarlo a un
  modelo concreto.
- **Por que:** los modelos cambian cada ~3 meses; el arnes es portable y 100 % nuestro.
- **Consecuencias:** el punto de entrada unico es `CLAUDE.md` (el que Claude Code carga
  automaticamente), mantenido corto (< 200 lineas). El modelo es intercambiable. Para portar
  a otra herramienta (Codex, Cursor) se renombra/copia a `AGENTS.md`, el estandar abierto.

## 2026-05-30 — Un solo archivo de entrada: CLAUDE.md

- **Decision:** consolidar el punto de entrada en un unico `CLAUDE.md`; se elimino `AGENTS.md`.
- **Por que:** Claude Code solo auto-carga `CLAUDE.md`, no `AGENTS.md` (doc oficial). Tener dos
  archivos era redundante para un flujo centrado en Claude Code.
- **Consecuencias:** una sola fuente de verdad. Si en el futuro se usa Codex/Cursor, se
  renombra/copia `CLAUDE.md` a `AGENTS.md` (mismo contenido).

## 2026-05-31 — Sumar los 4 elementos del agente al arnés

- **Decision:** incorporar identidad (`SOUL.md`), memoria de preferencias/aprendizajes
  (`memory/memory.md`) y skills/SOPs (`.claude/skills/`) como parte estándar del arnés
  (`context/` ya existía).
- **Por que:** completar los 4 elementos de un agente (loop + contexto + memoria + herramientas)
  y cerrar el self-improving loop con una memoria que se lee al inicio y se escribe al corregir.
- **Consecuencias:** el punto de entrada lee `memory/memory.md` al iniciar y exige actualizarlo al
  corregir; el script de verificación (`init.*`) exige `SOUL.md` y `.claude/skills/`; hay un skill
  de ejemplo `registrar-aprendizaje`.

## 2026-06-01 — Versionar el arnés en git sin filtrar secretos

- **Decision:** incluir un `.gitignore` que VERSIONA `.claude/agents/`, `.claude/commands/` y
  `.claude/skills/` (prompts/SOPs) e IGNORA secretos y config local (`.env`, `.env.*`,
  `.claude/settings.local.json`, `.claude/.credentials.json`).
- **Por que:** si el arnés no se versiona, un clon fresco (nube/VPS) queda sin subagentes ni
  comando `/empezar-dia`. Si se versiona de más, se filtran credenciales (p.ej. `service_role`).
- **Consecuencias:** `.gitignore` en la plantilla y en cada proyecto; verificar con
  `git check-ignore`. El contenido de carpetas antes ignoradas solo existe en local → tras
  cambiar el `.gitignore` hay que `git add` + commit + push esos archivos desde la máquina local.

---

<!-- Plantilla para nuevas entradas:

## AAAA-MM-DD — Titulo corto de la decision

- **Decision:** que se decidio.
- **Por que:** razon principal.
- **Consecuencias:** que cambia a partir de ahora / que queda descartado.

-->
