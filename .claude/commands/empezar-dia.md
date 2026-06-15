---
description: Rutina de inicio de día — preflight, estado y próxima tarea. Briefing de solo lectura; no hace cambios.
---

Ejecutá la rutina de inicio de día del arnés. Es un **briefing de SOLO LECTURA**: no hagas
cambios. Terminá proponiendo la próxima tarea y **esperá mi OK**.

## 1. Preflight — ¿el proyecto está sano?
Corré el script de verificación:
- Windows: `pwsh ./scripts/init.ps1`
- Linux / macOS: `bash ./scripts/init.sh`

**Verde** → seguí. **Rojo** → pará y reportá: arreglar eso es la **prioridad #1**. No avances
sobre un proyecto roto.

## 2. ¿Dónde quedamos? (memoria fuera del modelo)
- Lee [`memory/user_profile.md`](../../memory/user_profile.md) (perfil y tus preferencias de comunicación/control).
- Lee [`memory/memory.md`](../../memory/memory.md) (lecciones técnicas específicas del repositorio).
- Lee las últimas entradas de `progress/`.
- Lee `tasks.json` (estados: pending / in_progress / done / blocked).

No releas todo el proyecto: para eso existe esta memoria externa dividida.


## 3. Briefing + próxima tarea
Resumí: estado del preflight, en qué se quedó el equipo, y recomendá **UN** ítem de
`tasks.json` para hoy. Si la tarea toca algo crítico o ambiguo, arrancá en **Plan Mode** y
proponé antes de ejecutar.

## 4. Esperá mi OK — recién ahí se trabaja
Cuando apruebe, delegás el loop: **orquestador → lector → implementador → revisor**, cada uno
dejando su registro en `progress/`. Una tarea está "hecha" SOLO cuando el revisor la aprueba.

**No empieces a codear hasta mi OK.**
