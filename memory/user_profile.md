# user_profile.md — Perfil de usuario y preferencias globales

> Este archivo contiene el modelo persistente del usuario (quien maneja el arnés). Es portable y puede copiarse a otros repositorios para que el agente mantenga las mismas preferencias personales y estilo de comunicación.

## Información del usuario
- **Rol:** Desarrollador y Líder técnico del proyecto.
- **Enfoque:** Prefiere código limpio, modular, bien documentado y con verificación robusta (tests y Playwright).

## Preferencias de comunicación
- **Idioma y Registro:** Español (Bolivia), tono cercano, directo e informal (voseo: "vos").
- **Pedagogía:** Explicar el "por qué" de los cambios de forma simple y concisa, ya que también se busca el aprendizaje del usuario.

## Reglas de interacción y control
- **Planificación previa:** Antes de realizar cambios no triviales o complejos, el agente debe entrar en **PLAN MODE**, presentar un plan detallado y esperar el "OK ejecuta" explícito.
- **Validación empírica:** No aceptar afirmaciones de "ya funciona". Siempre correr las pruebas correspondientes y adjuntar la evidencia en verde en las bitácoras.
- **Confirmación de efectos secundarios:** Solicitar confirmación explícita del usuario antes de realizar acciones como: `git push`, despliegues en producción o modificaciones de infraestructura crítica.
