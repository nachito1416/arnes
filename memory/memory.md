# memory.md — Lecciones aprendidas y reglas del proyecto

> El agente lee este archivo al inicio de cada sesión y registra aquí las lecciones técnicas aprendidas sobre el repositorio. **Las preferencias de comunicación y control del usuario viven en [`user_profile.md`](user_profile.md).** Las decisiones de arquitectura con su justificación van en [`decisions.md`](decisions.md).

## Reglas técnicas y restricciones del proyecto
- Nunca tocar, leer ni commitear secretos (`.env`, tokens, `.claude/settings.local.json`).
- El arnés es aditivo: no sobrescribir el `CLAUDE.md` ni el código de producto; proponer primero.
- Evitar inflar la ventana de contexto de Claude Code manteniendo la memoria compacta y organizada.

## Atajos / aprendizajes técnicos (qué funciona y qué no)
- **Playwright se instala con npm, NO clonando el repo de GitHub.** `npm install -D @playwright/test` + `npx playwright install chromium` (solo Chromium, ~113 MB: más rápido que bajar los 3 navegadores). Headless por defecto; `--headed` para verlo en vivo; `npx playwright codegen <url>` graba clics y genera el test solo. Verificado el 2026-06-21 (2 tests en verde en `C:\playwright-demo`). La máquina del usuario ya tiene Node v24 / npm 11. La capa Playwright llave-en-mano vive en el Prompt C de `prompts-arnes.md`.

