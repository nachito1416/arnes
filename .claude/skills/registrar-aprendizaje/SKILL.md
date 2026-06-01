---
name: registrar-aprendizaje
description: Usalo cuando el usuario te corrige, te da una preferencia nueva o te pide "acordate de esto". Guarda el aprendizaje en memory/memory.md con el formato estándar para que sobreviva entre sesiones.
---

# Skill: registrar-aprendizaje

Convierte una corrección o preferencia del usuario en una línea persistente en
`memory/memory.md`. Es el motor del self-improving loop.

## Cuándo se dispara
- El usuario te corrige ("no, el tono va más informal").
- Te da una preferencia ("siempre respondé en español").
- Te dice explícitamente "acordate de esto" / "que no se te olvide".

## Pasos
1. Resumí el aprendizaje en **una línea accionable** (qué vas a hacer distinto de ahora en más).
2. Abrí `memory/memory.md` y agregá la línea en la sección que corresponda
   (`Preferencias del usuario`, `Reglas que el agente aprendió` o `Atajos`).
3. Si es una decisión con contexto largo, dejá el detalle en `memory/decisions.md` y en
   `memory.md` solo la conclusión + el enlace.
4. ⛔ **Nunca** guardes valores de `.env`, tokens ni credenciales. Nombrá la variable, no su valor.
5. Confirmale al usuario en una línea qué guardaste.

## Resultado
La próxima sesión arranca sabiendo esto, porque `CLAUDE.md` §4 manda leer `memory/memory.md` al inicio.
