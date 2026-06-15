# memory.md — Lecciones aprendidas y reglas del proyecto

> El agente lee este archivo al inicio de cada sesión y registra aquí las lecciones técnicas aprendidas sobre el repositorio. **Las preferencias de comunicación y control del usuario viven en [`user_profile.md`](user_profile.md).** Las decisiones de arquitectura con su justificación van en [`decisions.md`](decisions.md).

## Reglas técnicas y restricciones del proyecto
- Nunca tocar, leer ni commitear secretos (`.env`, tokens, `.claude/settings.local.json`).
- El arnés es aditivo: no sobrescribir el `CLAUDE.md` ni el código de producto; proponer primero.
- Evitar inflar la ventana de contexto de Claude Code manteniendo la memoria compacta y organizada.

## Atajos / aprendizajes técnicos (qué funciona y qué no)
- *(vacío — "intentamos usar la librería X pero falló por la versión Y", para evitar repetir errores)*

