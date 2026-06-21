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

## 2026-06-21 — Fijar los subagentes en Claude Opus 4.8 (`model: opus`)

- **Decision:** los 4 subagentes (`orquestador`, `lector`, `implementador`, `revisor`) corren
  TODOS en `model: opus` (Claude Opus 4.8). Se revierte el cambio previo que los había puesto en
  `model: gemini-1.5-pro`. Las plantillas de `prompts-arnes.md` también fijan `model: opus`.
- **Por que:** una actualización anterior hecha con Gemini cambió los subagentes a `gemini-1.5-pro`
  sin registrar la decisión aquí (rompiendo el self-improving loop del arnés). Se prioriza máxima
  calidad y un comportamiento predecible: Opus 4.8 como tope, sin caer a modelos inferiores.
- **Consecuencias:** el frontmatter de cada agente usa el alias `opus` (apunta al Opus configurado,
  hoy 4.8). La filosofía "el modelo es intercambiable" sigue en `README.md` a nivel conceptual
  (el arnés es portable), pero la configuración concreta de ejecución queda anclada en Opus 4.8.

## 2026-06-21 — Capa de seguridad obligatoria (Pilar 3 reforzado)

- **Decision:** sumar al arnés un subagente **`auditor-seguridad`** (Opus 4.8, solo-lectura + Bash)
  y un checklist **`verification/SECURITY.md`** adaptado al dominio (dinero/impuestos, pagos QR,
  Supabase RLS, PII). En **zonas críticas** (dinero, auth, datos personales, migraciones, endpoints
  públicos) ninguna tarea pasa a `done` ni a producción sin el OK del auditor. El preflight
  (`init.*`) suma una capa que verifica que los secretos están fuera de git.
- **Por que:** el arnés se usa para sistemas con dinero real, impuestos municipales e inversión.
  El revisor validaba que algo *funciona*, pero nadie validaba que fuera *seguro* (inyección, doble
  cobro, RLS, secretos, PII). Los videos de "loop engineering" tampoco cubren seguridad. Era el
  hueco más caro de dejar abierto.
- **Consecuencias:** nuevo rol `auditor-seguridad` (añadido al enum de `tasks.schema.json` y al
  flujo en `CLAUDE.md`, `orquestador.md`, `revisor.md`, `empezar-dia.md`). Separación de funciones:
  el auditor NO edita el código que audita (no tiene Write/Edit). Próximo paso acordado con el
  usuario: el **loop semi-automático** (worktrees + gates + tope de coste), en una sesión aparte.

## 2026-06-21 — Loop semi-automático (loop cerrado) acoplado al arnés

- **Decision:** sumar un modo de trabajo **loop cerrado/semi-automático** sobre el loop abierto
  existente: comando `/loop-cerrado` (protocolo), `scripts/loop.ps1`/`loop.sh` (git worktrees
  aislados) y `loops/` (estado durable). El loop itera implementador→revisor→(auditor si crítico)
  con **tope de 4 iteraciones**. **Alcance elegido por el usuario:** puede **mergear a `main` solo**
  en cambios normales; en **zona crítica frena para OK humano antes de `main`**; el **deploy a
  producción es siempre manual**.
- **Por que:** los videos de "loop engineering" aportan justo esto (autonomía on-the-loop con
  aislamiento y validación). El arnés ya tenía la "unidad de loop" (los subagentes); faltaba que
  iterara sola, aislada y con frenos. Se mantiene el control humano donde hay dinero.
- **Consecuencias:** salvaguarda de seguridad: en zona crítica el merge a `main` NO es automático
  (motivo: `main` puede estar conectado a auto-deploy tipo Vercel y hay impuestos/dinero de por
  medio). Líneas rojas del loop: gate humano antes de prod, tope de iteraciones, y trabajar siempre
  en worktree/rama (nunca commit directo sobre `main`). Worktrees viven fuera del repo (hermano),
  no se versionan; `loops/` (estado) sí se versiona como `progress/`.

## 2026-06-21 — Enforcement del arnés por hooks (que no se salte a medio trabajo)

- **Decision:** versionar `.claude/settings.json` con hooks `SessionStart` y `UserPromptSubmit` que
  inyectan en contexto (vía `cat verification/REGLAS-ARNES.md`) un recordatorio compacto de las
  reglas del arnés en cada turno y al iniciar sesión. Nuevo archivo `verification/REGLAS-ARNES.md`.
- **Por que:** las reglas en `CLAUDE.md`/agentes son instrucciones que el modelo PUEDE saltarse a
  medida que se llena el contexto (el usuario lo detectó: a medio trabajo Claude omitía el arnés si
  no se lo recordaba). Los hooks los ejecuta el HARNESS, no el modelo → enforcement determinístico,
  no depende de que "se acuerde".
- **Consecuencias:** `.claude/settings.json` ahora se versiona (`.gitignore`: `!/.claude/settings.json`);
  `settings.local.json` sigue ignorado. El comando `cat` funciona igual en Git Bash y PowerShell.
  CAVEAT: como `settings.json` no existía al iniciar la sesión, el watcher puede no tomarlo hasta abrir
  `/hooks` o reiniciar Claude Code. Si se quiere enforcement más duro, se puede sumar un PreToolUse
  bloqueante sobre Edit/Write (más intrusivo; no implementado por ahora).

<!-- Plantilla para nuevas entradas:

## AAAA-MM-DD — Titulo corto de la decision

- **Decision:** que se decidio.
- **Por que:** razon principal.
- **Consecuencias:** que cambia a partir de ahora / que queda descartado.

-->
