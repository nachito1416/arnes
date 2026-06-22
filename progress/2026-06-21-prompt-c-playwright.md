# [2026-06-21] Dejar la capa Playwright (Prompt C) llave-en-mano — (rol: orquestador)

## Tarea
Cerrar el último cabo suelto: que la capa Playwright (verificación de UI real) sea reproducible en
TODOS los proyectos del usuario. El Prompt C existía pero estaba flojo (sin comando de instalación
exacto ni alineado con el arnés actual).

## Que se hizo
- **Prompt C reescrito (prompts-arnes.md) llave-en-mano:** comando de instalación validado hoy
  (`npm install -D @playwright/test` + `npx playwright install chromium` — solo Chromium, NO clonar
  el repo), `playwright.config` (Chromium desktop + móvil 375px, headless, `webServer` que levanta el
  dev server solo), specs de flujos públicos, scripts npm, `.gitignore` de artefactos, y enganche con
  el preflight (`--e2e`) y con el revisor (corre `npm run e2e` en tareas de UI).
- **Regla de seguridad reforzada:** probar SOLO flujos públicos; nunca pagos reales, login real ni
  datos reales de contribuyentes (coherente con `verification/SECURITY.md`).
- **Lección registrada en memory/memory.md:** cómo instalar Playwright bien (npm, no repo; solo
  Chromium; headless; codegen). La sección de aprendizajes estaba vacía.

## Archivos tocados
- `prompts-arnes.md` — Prompt C reescrito
- `memory/memory.md` — lección Playwright
- `progress/2026-06-21-prompt-c-playwright.md` (este registro)

## Estado / verificacion
- Base empírica: Playwright 1.61.0 instalado y probado hoy en `C:\playwright-demo` → **"2 passed (10.1s)"**.
- Preflight `init.ps1` ANTES de tocar → 5/5 verde. Commit con preflight como **gate** + push.
- Resultado: ✅ aprobado.

## Siguiente paso
- Para cada proyecto con UI: usar el Prompt C (ahora completo). Copiás, pegás, listo.
- **Cabo suelto cerrado:** el arnés ya cubre verificación de UI real de punta a punta.
