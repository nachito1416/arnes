# ¿Qué es el arnés? — Guía simple para entender y enseñar

## La idea en una frase
Un **arnés** es un conjunto de **archivos en tu proyecto** que convierten a la IA (Claude Code)
de un genio caótico en un **compañero de trabajo confiable**: que recuerda, sigue tus reglas y
revisa su propio trabajo — y que sigue funcionando aunque cambies de modelo de IA.

## La analogía del caballo 🐴
- El **modelo de IA** es un **caballo**: potente y rápido, pero suelto va para cualquier lado.
- El **arnés** son las **riendas y la silla**: lo que te deja manejarlo y llevarlo a donde querés.
- 🔑 El caballo lo **alquilás** (hoy Claude, mañana otro). El arnés es **100% tuyo**.

## ¿En qué te ayuda? (lo concreto)
1. **Consistencia** — la IA se porta igual siempre, porque las reglas viven en archivos, no en
   tu cabeza ni en un chat que perdiste.
2. **Memoria** — no se olvida de lo que hizo. Anota su avance en archivos y retoma donde quedó.
   Dejás de re-explicar todo cada vez.
3. **No te miente** — a veces la IA dice "ya está, todo funciona" y está roto. El arnés lo
   **verifica** (corre pruebas) antes de darlo por hecho.
4. **Un equipo, no un agente saturado** — en vez de un solo agente haciendo todo (y volviéndose
   tonto), hay roles: uno investiga, otro escribe, otro revisa.
5. **A prueba del futuro** — cuando sale un modelo mejor, le cambiás "el cerebro" y tu sistema
   sigue igual. No empezás de cero cada vez.

## Los 3 pilares (el corazón del arnés)
1. **El arnés vive en tu código** — son archivos en una carpeta, nada mágico. El principal es
   `CLAUDE.md`: el "manual de bienvenida" que la IA lee al empezar cada sesión.
2. **No uses un agente para todo** — dividí el trabajo como en una empresa: un jefe que delega
   (orquestador), uno que investiga (lector), uno que escribe (implementador) y uno que revisa
   (revisor).
3. **Verificación** — la tarea no está "hecha" porque la IA lo diga, sino cuando el arnés lo
   **confirma** (corre lint, tipos, tests…).

## Cómo implementarlo (la forma correcta)
1. Abrí Claude Code **dentro de la carpeta del proyecto**.
2. Pegá el prompt que corresponda (están en `prompts-arnes.md`):
   - Proyecto que **ya existe** → **Prompt A**.
   - Proyecto **nuevo** → **Prompt B** (te hace una entrevista primero).
3. Claude entra en **plan mode** y te muestra **el plan** antes de tocar nada.
4. Lo revisás y das **"OK ejecuta"**.
5. Crea el arnés: subagentes + preflight + carpeta de progreso + el comando `/empezar-dia`.
6. Al final corre la verificación (preflight) y te muestra que pasa en verde.

## El día a día
- Cada vez que te sentás a trabajar, escribís **`/empezar-dia`**: revisa que todo esté sano,
  te dice en qué quedaste y te propone la próxima tarea.
- Cuando pedís algo grande, dejás que **delegue en los subagentes** y que el **revisor apruebe**
  antes de dar por terminado.

## Reglas de oro (para recordar de memoria)
- **Plan primero**: que te muestre qué va a hacer antes de hacerlo.
- **Contexto mínimo**: menos reglas y herramientas innecesarias = la IA trabaja mejor, no peor.
- **Sacá la memoria del modelo**: lo hecho se anota en archivos, no se amontona en el chat.
- **Verificá siempre**: no le creas al "ya quedó".

---
*Resumen de una línea para ella: "El arnés es el reglamento + la memoria + el equipo + el
control de calidad que hace que la IA trabaje como un buen empleado, no como un genio
descontrolado."*
