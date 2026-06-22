# Prompts para montar el arnés (Harness Engineering) en cualquier proyecto

Pegá uno de estos prompts en Claude Code **con el proyecto abierto** (para que descubra
`.claude/agents/` y los comandos). Los subagentes se crean TODOS en `model: opus` (Claude Opus 4.8, el tope del arnés).

El arnés actual incluye los **3 pilares** (vive en el código · subagentes por rol · verificación),
los **4 elementos del agente** (loop · contexto · memoria · herramientas), la **capa de seguridad**
(auditor + gate en zona crítica), el **loop semi-automático** (worktrees + gates) y el **enforcement
por hooks** (reinyecta las reglas cada turno). Prompt A y B lo montan COMPLETO en una sola pasada.

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
a) .claude/agents/ — 5 subagentes (formato Claude Code, TODOS en `model: opus` = Claude Opus 4.8, el tope del arnés):
   - orquestador: descompone y delega; exige plan para lo crítico; no escribe código.
   - lector: investiga en SOLO LECTURA y deja su resumen en progress/.
   - implementador: escribe respetando las reglas; RECHAZA tocar áreas críticas sin plan humano
     numerado; no marca "hecho".
   - revisor: corre el preflight y valida; aprueba o rechaza. Algo está "hecho" SOLO si él aprueba.
   - auditor-seguridad: en ZONAS CRÍTICAS (dinero/pagos, auth, datos personales, migraciones),
     audita la seguridad DESPUÉS del revisor; sin su OK no hay "hecho" ni producción. Solo-lectura.
   Embebé en cada subagente las reglas duras REALES de este proyecto.
b) SOUL.md — identidad/voz/misión del asistente (con lo que detectaste; si dudás, plantilla + pedímelo).
c) memory/ con user_profile.md (preferencias del usuario, idioma, tono; portable) + memory.md (lecciones técnicas específicas del repo) + decisions.md + README.
d) context/ con README — dominio curado que se carga BAJO DEMANDA.
e) .claude/skills/ con README + skill "registrar-aprendizaje" + skill "autocurar-skills" (bucles de aprendizaje y curación autónoma).
f) scripts/preflight.* — corre la verificación REAL (estructura del arnés → secretos fuera de git
   → lint + typecheck + tests) en orden, se detiene al primer fallo y sale con código ≠ 0. Exponelo
   como `npm run preflight` (o el equivalente del stack). Sumá `verification/SECURITY.md` con el
   checklist de seguridad del dominio (dinero, auth, datos personales).
g) progress/ — bitácora por sesión (README con la convención + un ejemplo).
h) .claude/commands/empezar-dia.md — /empezar-dia: briefing de SOLO LECTURA (corre el preflight,
   lee memory/memory.md + progress/ + el roadmap/tareas, propone la próxima tarea y espera mi OK).
i) .gitignore — versioná el arnés (.claude/agents/, .claude/commands/, .claude/skills/,
   .claude/settings.json) e IGNORÁ los secretos (.env, .env.*, .claude/settings.local.json,
   .claude/.credentials.json). Verificá con `git check-ignore` que el arnés se versiona y los secretos NO.
j) CLAUDE.md: NO lo reescribas. Proponé una sección corta (~15 líneas) "Subagentes + preflight +
   4 elementos" — que mande LEER memory/user_profile.md y memory/memory.md al inicio y actualizarlos cuando me corrijas — y
   mostrame el texto exacto antes de aplicarla.
k) .claude/commands/loop-cerrado.md + scripts/loop.* + loops/ — modo LOOP semi-automático: el equipo
   itera solo en un git worktree aislado, con tope de iteraciones y gates; en zona crítica frena para
   tu OK antes de `main`; el deploy a producción es SIEMPRE manual.
l) .claude/settings.json (hooks) + verification/REGLAS-ARNES.md — ENFORCEMENT: hooks SessionStart +
   UserPromptSubmit que reinyectan las reglas del arnés en cada turno para que no se salte a medio
   trabajo. Versioná settings.json; NUNCA settings.local.json.

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
3. .claude/agents/ — 5 subagentes (TODOS en `model: opus` = Claude Opus 4.8): orquestador (delega, exige plan para
   lo crítico, no escribe código), lector (investiga, solo lectura), implementador (escribe;
   RECHAZA áreas críticas sin plan humano numerado; no marca "hecho"), revisor (verifica y
   aprueba/rechaza; "hecho" solo cuando él aprueba), auditor-seguridad (en zonas críticas —
   dinero/auth/datos/migraciones — audita la seguridad después del revisor; sin su OK no hay
   "hecho" ni producción; solo-lectura). Reglas del proyecto embebidas.
4. memory/ con user_profile.md (preferencias del usuario; portable) + memory.md (lecciones técnicas del repo) + decisions.md + README.
5. context/ con README — dominio curado que se carga BAJO DEMANDA (no infla el CLAUDE.md).
6. .claude/skills/ con README + skill "registrar-aprendizaje" + skill "autocurar-skills" (procedimientos estándar y aprendizaje autónomo).
7. scripts/preflight.* — verificación (estructura del arnés → incluye user_profile.md y memory.md → secretos fuera de git → lint + typecheck + tests del stack
   elegido), se detiene al primer fallo. Exponelo como `npm run preflight` (o equivalente). Sumá `verification/SECURITY.md` (checklist de seguridad del dominio: dinero, auth, datos personales).
8. tasks.json — tareas con estados (pending / in_progress / done / blocked).
9. progress/ — bitácora por sesión (README + plantilla).
10. .claude/commands/empezar-dia.md — /empezar-dia: briefing de inicio (corre el preflight, lee
    memory/memory.md + progress/ + tasks.json, propone la próxima tarea, espera mi OK).
11. .gitignore — versioná el arnés (.claude/agents/, .claude/commands/, .claude/skills/,
    .claude/settings.json) e IGNORÁ los secretos (.env, .env.*, .claude/settings.local.json,
    .claude/.credentials.json).
12. Modo LOOP semi-automático: .claude/commands/loop-cerrado.md + scripts/loop.* + loops/ — el equipo
    itera solo en un worktree aislado, con tope de iteraciones y gates; en zona crítica frena para tu
    OK antes de main; deploy a producción siempre manual.
13. ENFORCEMENT por hooks: .claude/settings.json (SessionStart + UserPromptSubmit) +
    verification/REGLAS-ARNES.md — reinyectan las reglas del arnés en cada turno para que no se salte a
    medio trabajo. Versioná settings.json; nunca settings.local.json.

Wiring: CLAUDE.md lee memory/user_profile.md y memory/memory.md al inicio y tiene la regla "cuando me corrijas o aprendas algo, actualizá memory/user_profile.md o memory/memory.md".

REGLAS: mantené CLAUDE.md corto y el contexto mínimo; NUNCA toques/leas/commitees .env ni secretos;
no instales dependencias sin avisar.

Al terminar, corré el preflight y mostrame que pasa en verde.
```

---

## PROMPT C — Capa Playwright (opcional, después de tener el arnés base, si hay UI)

```
Montá la capa de verificación E2E con Playwright en ESTE proyecto (solo si tiene UI). Entrá en PLAN
MODE y proponé ANTES de instalar dependencias (el arnés no instala nada sin avisar).

SEGURIDAD (innegociable): probá SOLO flujos PÚBLICOS y seguros. NADA de pagos reales, login con
credenciales reales, ni datos reales de contribuyentes. Para lo crítico se usan datos de prueba.

PASOS:
1. Instalá (NO se clona el repo de GitHub; se instala con npm):
   - `npm install -D @playwright/test`
   - `npx playwright install chromium`   (solo Chromium: ~113 MB, más rápido que bajar los 3 navegadores)
2. playwright.config.ts: testDir `./e2e`, reporter 'list', headless, screenshot 'only-on-failure',
   proyectos Chromium desktop + móvil (viewport 375px), y `webServer` que levante el dev server solo
   (command + url + reuseExistingServer) para no depender de uno corriendo a mano.
3. 1-2 specs de flujos PÚBLICOS (home carga, navegación, un formulario sin datos reales) en `./e2e`.
4. Scripts en package.json: `"e2e": "playwright test"`, `"e2e:ui": "playwright test --ui"`,
   `"e2e:install": "playwright install chromium"`.
5. .gitignore: sumá `test-results/`, `playwright-report/`, `blob-report/`, `.playwright/` (artefactos, NO se versionan).
6. Enganchá con el arnés: un flag `--e2e` en scripts/preflight (init.*) que corra `npm run e2e`,
   y que el subagente REVISOR corra `npm run e2e` en tareas de UI antes de aprobar.

Al terminar, corré `npm run e2e` y mostrame que pasa en VERDE (evidencia real, no "ya funciona").
Tip: `--headed` para ver el navegador en vivo; `npx playwright codegen <url>` graba clics y escribe el test.
```

---

## PROMPT D — Actualizar un arnés YA instalado a la versión actual

> Para un proyecto que ya tiene una versión VIEJA del arnés y le faltan piezas nuevas (capa de
> seguridad, loop semi-automático, hooks de enforcement, los 4 elementos) y/o el versionado en git.
> La versión ACTUAL del arnés está en el repo público https://github.com/nachito1416/arnes
> (o, si estás en la misma PC, en `C:\Harness Engineering`).

```
Quiero ACTUALIZAR a la versión ACTUAL el arnés que ya tiene este proyecto, ADITIVO y sin romper
nada. Pueden faltarle los 4 elementos del agente (identidad SOUL.md, memoria memory/memory.md,
contexto context/, skills .claude/skills/) y/o el versionado del arnés en git. Entrá en PLAN MODE
y mostrame el plan ANTES de tocar nada; esperá mi "OK ejecuta".

1. Conseguí la versión ACTUAL del arnés como REFERENCIA (NO la copies textual: adaptá a este proyecto):
   - Recomendado (cualquier máquina): cloná `https://github.com/nachito1416/arnes` en una carpeta
     TEMPORAL fuera de este proyecto (ej. `../arnes-ref`). NO copies su `.git` ni la metas en el repo
     de este proyecto: leé de ahí y recreá/adaptá los archivos acá.
   - O, si estás en la misma PC, usá `C:\Harness Engineering`.
   Revisá SOUL.md, memory/, context/, .claude/ (agents, commands, skills, settings.json), scripts/,
   verification/ y el .gitignore.
2. Detectá qué YA existe y agregá SOLO lo que falte (sin reescribir el CLAUDE.md/AGENTS.md ni el
   código de producto):
    - SOUL.md (identidad/voz/misión; si no sabés el dominio, plantilla editable + pedímelo).
    - memory/ con user_profile.md (perfil de usuario portable) + memory.md (lecciones técnicas) + README.
    - context/ con README (si no está).
    - .claude/skills/ con README + skill "registrar-aprendizaje" + skill "autocurar-skills" (curador autónomo).
    - .claude/agents/auditor-seguridad.md + verification/SECURITY.md (capa de seguridad: gate obligatorio en zonas críticas — dinero/auth/datos/migraciones).
    - Modo LOOP: .claude/commands/loop-cerrado.md + scripts/loop.* + loops/ (loop semi-automático en worktrees, con gates y tope de iteraciones).
    - ENFORCEMENT: .claude/settings.json (hooks SessionStart + UserPromptSubmit) + verification/REGLAS-ARNES.md (reinyectan las reglas cada turno para que el arnés no se salte a medio trabajo).
    - CORRECCIÓN de subagentes viejos: revisá los .claude/agents/ que YA existen. Si alguno está en `model: gemini-...` o un modelo inferior, pasalo a `model: opus` (Claude Opus 4.8, el tope del arnés). Mismo criterio si hay plantillas de prompts que mencionen otro modelo.
3. Versioná el arnés en git (para que la nube/VPS lo tengan al clonar): asegurate de que el
   .gitignore VERSIONE .claude/agents/, .claude/commands/, .claude/skills/ y .claude/settings.json,
   e IGNORE los secretos (.env, .env.*, .claude/settings.local.json, .claude/.credentials.json).
   Verificá con `git check-ignore`.
4. Enganchalo en lo que YA existe (ediciones MÍNIMAS):
    - Archivo de entrada: sumá los 4 elementos al mapa; que LEA memory/user_profile.md y memory/memory.md al inicio; regla
      "cuando me corrijas o aprendas algo, actualizá memory/user_profile.md o memory/memory.md"; sección corta de los 4
      elementos. Mantenelo < 200 líneas.
    - Comando de inicio de día (si existe): que lea memory/user_profile.md y memory/memory.md.
    - Script de verificación (preflight/init): sumá a la capa de ESTRUCTURA SOUL.md, memory/user_profile.md,
      memory/memory.md, context/, .claude/skills/, verification/SECURITY.md y .claude/agents/auditor-seguridad.md.
      Sumá una capa de SEGURIDAD básica: secretos fuera de git (.env en .gitignore; sin .env/.key/.pem trackeados).
      Si el chequeo de tasks.json usa `command -v python3`, corregilo: probá que el intérprete REALMENTE ejecute
      (en Windows/Git Bash "python3" suele ser un stub que no corre) y, si no hay validador, OMITÍ el chequeo en
      vez de marcar falso error. NO toques las capas de lint/typecheck/tests del proyecto.
   - Registrá el cambio en progress/ y, si hay tasks.json, dejá la tarea en done.

REGLAS: aditivo; NUNCA toques, leas ni commitees .env ni secretos; no instales dependencias sin
avisar; contexto mínimo.

Al terminar, corré la verificación y mostrame que pasa en verde.

NOTA (repos en nube/VPS): si .claude/agents|commands|skills estaban ignorados, su CONTENIDO solo
existe en tu máquina local. Tras corregir el .gitignore, agregá y pusheá esos archivos DESDE LOCAL
(git add .claude/agents .claude/commands .claude/skills .claude/settings.json && commit && push). Antes del commit,
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
