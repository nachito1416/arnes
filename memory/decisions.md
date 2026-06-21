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

<!-- Plantilla para nuevas entradas:

## AAAA-MM-DD — Titulo corto de la decision

- **Decision:** que se decidio.
- **Por que:** razon principal.
- **Consecuencias:** que cambia a partir de ahora / que queda descartado.

-->
