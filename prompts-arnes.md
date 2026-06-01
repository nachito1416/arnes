# Prompts para montar el arnés (Harness Engineering) en cualquier proyecto

Pegá uno de estos prompts en Claude Code **con el proyecto abierto** (para que descubra
`.claude/agents/` y los comandos). Los subagentes se crean en `model: opus` (Opus 4.8).

El arnés actual incluye los **3 pilares** (vive en el código · subagentes por rol · verificación)
y los **4 elementos del agente** (loop · contexto · memoria · herramientas). Prompt A y B ya lo
montan COMPLETO en una sola pasada.

---

## PROMPT A — Proyecto que YA existe (seguimiento)

```
Quiero montar en ESTE proyecto el arnés COMPLETO de "Harness Engineering" (arnés de agentes IA),
de forma ADITIVA y sin romper nada. Entrá en PLAN MODE: explorá el proyecto y mostrame el plan
ANTES de tocar o instalar nada. Esperá mi "OK ejecuta".

Los 3 pilares: (1) el arnés vive en el código; (2) equipo de subagentes por rol; (3) verificación:
nada está "hecho" hasta que el arnés lo valida. Más los 4 elementos del agente: loop + contexto +
memoria + herramientas.

PASO 1 — Explorá y reportá:
- Stack, framework y gestor de paquetes.
- Si ya existe CLAUDE.md o AGENTS.md: NO lo sobrescribas, resumí sus reglas.
- Los comandos reales de verificación (lint, typecheck, tests) y si hay CI.
- La VOZ/identidad del proyecto (para SOUL.md) y las áreas CRÍTICAS (dinero/pagos, auth, base de
  datos, migraciones, datos personales/sensibles) que NO se tocan sin plan humano numerado.

PASO 2 — Proponé el plan (agregar SOLO lo que falte, todo aditivo):
a) .claude/agents/ — 4 subagentes (formato Claude Code, TODOS en `model: opus`):
   - orquestador: descompone y delega; exige plan para lo crítico; no escribe código.
   - lector: investiga en SOLO LECTURA y deja su resumen en progress/.
   - implementador: escribe respetando las reglas; RECHAZA tocar áreas críticas sin plan humano
     numerado; no marca "hecho".
   - revisor: corre el preflight y valida; aprueba o rechaza. Algo está "hecho" SOLO si él aprueba.
   Embebé en cada subagente las reglas duras REALES de este proyecto.
b) SOUL.md — identidad/voz/misión del asistente (con lo que detectaste; si dudás, plantilla + pedímelo).
c) memory/ con memory.md (preferencias/correcciones/aprendizajes; se lee al inicio, se actualiza al
   corregir) + README.
d) context/ con README — dominio curado que se carga BAJO DEMANDA.
e) .claude/skills/ con README + skill de ejemplo "registrar-aprendizaje" (escribe en memory/memory.md).
f) scripts/preflight.* — corre la verificación REAL (estructura del arnés → lint + typecheck +
   tests) en orden, se detiene al primer fallo y sale con código ≠ 0. Exponelo como `npm run
   preflight` (o el equivalente del stack).
g) progress/ — bitácora por sesión (README con la convención + un ejemplo).
h) .claude/commands/empezar-dia.md — /empezar-dia: briefing de SOLO LECTURA (corre el preflight,
   lee memory/memory.md + progress/ + el roadmap/tareas, propone la próxima tarea y espera mi OK).
i) .gitignore — versioná el arnés (.claude/agents/, .claude/commands/, .claude/skills/) e IGNORÁ
   los secretos (.env, .env.*, .claude/settings.local.json, .claude/.credentials.json). Verificá
   con `git check-ignore` que los subagentes se versionan y los secretos NO.
j) CLAUDE.md: NO lo reescribas. Proponé una sección corta (~15 líneas) "Subagentes + preflight +
   4 elementos" — que mande LEER memory/memory.md al inicio y actualizarlo cuando me corrijas — y
   mostrame el texto exacto antes de aplicarla.

REGLAS: todo aditivo; no sobrescribas archivos ni toques código de producto; respetá las
convenciones existentes; NUNCA toques, leas ni commitees .env ni secretos; no instales
dependencias sin avisar.

PASO 3 — Al terminar: corré el preflight y mostrame que pasa en verde.
```

---

## PROMPT B — Proyecto desde CERO (de partida)

```
Es un proyecto desde cero. Quiero que montes el arnés COMPLETO de "Harness Engineering" (arnés de
agentes IA). Entrá en PLAN MODE y mostrame el plan antes de crear o instalar nada. Esperá mi
"OK ejecuta".

Los 3 pilares: (1) el arnés vive en el código; (2) equipo de subagentes por rol, no un agente para
todo; (3) verificación: nada está "hecho" hasta que el arnés lo valida. Más los 4 elementos del
agente: loop + contexto + memoria + herramientas.

Antes de armarlo, hacéme preguntas tipo entrevista para entender: qué construye el proyecto, para
quién, el stack/gestor de paquetes, la VOZ/identidad del asistente (para SOUL.md), las reglas duras
(qué NO se debe tocar) y qué es crítico (dinero, auth, datos personales o sensibles).

Creá:
1. CLAUDE.md (punto de entrada, < 200 líneas): quién es el agente, qué es el proyecto, mapa de
   carpetas, reglas duras, cómo se verifica, flujo de subagentes y los 4 elementos. Cortito; lo
   extenso va en archivos enlazados.
2. SOUL.md — identidad/voz/misión del asistente (con las respuestas de la entrevista).
3. .claude/agents/ — 4 subagentes (TODOS en `model: opus`): orquestador (delega, exige plan para
   lo crítico, no escribe código), lector (investiga, solo lectura), implementador (escribe;
   RECHAZA áreas críticas sin plan humano numerado; no marca "hecho"), revisor (verifica y
   aprueba/rechaza; "hecho" solo cuando él aprueba). Reglas del proyecto embebidas.
4. memory/ con memory.md (preferencias/correcciones/aprendizajes; el agente lo lee al inicio y lo
   actualiza cuando lo corrijo) + README.
5. context/ con README — dominio curado que se carga BAJO DEMANDA (no infla el CLAUDE.md).
6. .claude/skills/ con README + skill de ejemplo "registrar-aprendizaje" (escribe en memory/memory.md).
7. scripts/preflight.* — verificación (estructura del arnés → lint + typecheck + tests del stack
   elegido), se detiene al primer fallo. Exponelo como `npm run preflight` (o equivalente).
8. tasks.json — tareas con estados (pending / in_progress / done / blocked).
9. progress/ — bitácora por sesión (README + plantilla).
10. .claude/commands/empezar-dia.md — /empezar-dia: briefing de inicio (corre el preflight, lee
    memory/memory.md + progress/ + tasks.json, propone la próxima tarea, espera mi OK).
11. .gitignore — versioná el arnés (.claude/agents/, .claude/commands/, .claude/skills/) e IGNORÁ
    los secretos (.env, .env.*, .claude/settings.local.json, .claude/.credentials.json).

Wiring: CLAUDE.md lee memory/memory.md al inicio y tiene la regla "cuando me corrijas o aprendas
algo, actualizá memory/memory.md".

REGLAS: mantené CLAUDE.md corto y el contexto mínimo; NUNCA toques/leas/commitees .env ni secretos;
no instales dependencias sin avisar.

Al terminar, corré el preflight y mostrame que pasa en verde.
```

---

## PROMPT C — Capa Playwright (opcional, después de tener el arnés base, si hay UI)

```
Montá la capa de verificación E2E con Playwright, SOLO para flujos PÚBLICOS y seguros (nada de
pagos, auth ni datos reales). Entrá en plan mode y proponé antes de instalar dependencias.
Incluí: playwright.config.ts (Chromium, desktop + móvil 375px, que levante el dev server solo),
1-2 specs de flujos públicos, scripts npm (e2e / e2e:ui / e2e:install), entradas en .gitignore
para los artefactos, un flag --e2e en scripts/preflight, y que el subagente revisor corra
`npm run e2e` en tareas de UI. Al terminar, corré `npm run e2e` y mostrame que pasa en verde.
```

---

## PROMPT D — Actualizar un arnés YA instalado a la versión actual

> Para un proyecto que ya tiene el arnés base pero le faltan los 4 elementos (SOUL.md, memory/,
> context/, .claude/skills/) y/o el versionado correcto en git. Esta plantilla
> (`C:\Harness Engineering`) ya los trae como referencia.

```
Quiero ACTUALIZAR a la versión ACTUAL el arnés que ya tiene este proyecto, ADITIVO y sin romper
nada. Pueden faltarle los 4 elementos del agente (identidad SOUL.md, memoria memory/memory.md,
contexto context/, skills .claude/skills/) y/o el versionado del arnés en git. Entrá en PLAN MODE
y mostrame el plan ANTES de tocar nada; esperá mi "OK ejecuta".

1. Leé como REFERENCIA de estilo la plantilla en C:\Harness Engineering (SOUL.md, memory/README.md,
   memory/memory.md, context/README.md, .claude/skills/ y el .gitignore). NO la copies textual:
   adaptá a este proyecto.
2. Detectá qué YA existe y agregá SOLO lo que falte (sin reescribir el CLAUDE.md/AGENTS.md ni el
   código de producto):
   - SOUL.md (identidad/voz/misión; si no sabés el dominio, plantilla editable + pedímelo).
   - memory/ con memory.md + README. Sembrá memory.md con las preferencias/aprendizajes que ya conozcas.
   - context/ con README (si no está).
   - .claude/skills/ con README + skill de ejemplo "registrar-aprendizaje" que escriba en memory/memory.md.
3. Versioná el arnés en git (para que la nube/VPS lo tengan al clonar): asegurate de que el
   .gitignore VERSIONE .claude/agents/, .claude/commands/ y .claude/skills/, e IGNORE los secretos
   (.env, .env.*, .claude/settings.local.json, .claude/.credentials.json). Verificá con
   `git check-ignore`.
4. Enganchalo en lo que YA existe (ediciones MÍNIMAS):
   - Archivo de entrada: sumá los 4 elementos al mapa; que LEA memory/memory.md al inicio; regla
     "cuando me corrijas o aprendas algo, actualizá memory/memory.md"; sección corta de los 4
     elementos. Mantenelo < 200 líneas.
   - Comando de inicio de día (si existe): que también lea memory/memory.md.
   - Script de verificación (preflight/init): sumá SOUL.md, memory/, context/ y .claude/skills/ a
     la capa de ESTRUCTURA. NO toques las capas de lint/typecheck/tests.
   - Registrá el cambio en progress/ y, si hay tasks.json, dejá la tarea en done.

REGLAS: aditivo; NUNCA toques, leas ni commitees .env ni secretos; no instales dependencias sin
avisar; contexto mínimo.

Al terminar, corré la verificación y mostrame que pasa en verde.

NOTA (repos en nube/VPS): si .claude/agents|commands|skills estaban ignorados, su CONTENIDO solo
existe en tu máquina local. Tras corregir el .gitignore, agregá y pusheá esos archivos DESDE LOCAL
(git add .claude/agents .claude/commands .claude/skills && commit && push). Antes del commit,
verificá que no haya tokens/secretos dentro (son prompts/SOPs, no debería).
```

---

### Cómo usarlos
- Abrí Claude Code **dentro de la carpeta del proyecto**.
- **Proyecto nuevo →** Prompt B. **Proyecto que ya existe →** Prompt A. Ambos montan el arnés
  COMPLETO (3 pilares + 4 elementos + .gitignore que versiona el arnés) en una sola pasada.
- **¿Ya tenías un arnés viejo (sin SOUL/memory/skills o sin versionar en git)? →** Prompt D para ponerlo al día.
- **¿Hay UI? →** Prompt C suma la capa Playwright (después).
- Claude entra en plan mode, te muestra el plan, vos das "OK ejecuta".
- Una vez montado, cada día arrancás con `/empezar-dia`.
