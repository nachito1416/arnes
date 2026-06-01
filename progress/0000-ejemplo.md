# [2026-05-30] Montaje inicial del arnes — (rol: orquestador)

> Entrada de ejemplo. Borrala o usala como plantilla para tus propias entradas.

## Tarea
T-000 — dejar el esqueleto del arnes listo (Harness Engineering).

## Que se hizo
- Se creo la estructura de carpetas y archivos base del arnes (3 pilares).
- `CLAUDE.md` como punto de entrada unico (lo carga Claude Code).
- Subagentes definidos: orquestador, lector, implementador, revisor.

## Archivos tocados
- CLAUDE.md, README.md, tasks.json
- scripts/init.sh, scripts/init.ps1
- .claude/agents/*.md

## Estado / verificacion
- Pendiente: ejecutar `pwsh ./scripts/init.ps1` y conectar tests reales (T-002).
- Resultado: ⏳ en progreso (esqueleto listo, falta adaptar a un proyecto real).

## Siguiente paso
- Implementador: rellenar la seccion 2 de CLAUDE.md con el proyecto real (T-001).
- Implementador: conectar tests/lint/typecheck en los scripts init (T-002).
