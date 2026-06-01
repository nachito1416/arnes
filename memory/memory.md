# memory.md — Preferencias, correcciones y aprendizajes

> El agente lee este archivo al inicio de cada sesión y lo actualiza cuando lo corrigen o
> aprende algo nuevo. **Una línea por aprendizaje. Sin secretos.** (Las decisiones de
> arquitectura, con su "por qué", van en [`decisions.md`](decisions.md).)

## Preferencias del usuario
- Idioma: español (Bolivia), tono cercano y directo (vos). Explicar el "por qué" de forma simple (también lo está enseñando).
- Antes de cambios no triviales: mostrar el PLAN y esperar "OK ejecuta".
- Verificación real: no aceptar "ya quedó"; correr las pruebas y mostrar la evidencia en verde.
- Confirmar antes de acciones con efectos: git push, deploy, tocar producción.

## Reglas que el agente aprendió
- Nunca tocar, leer ni commitear secretos (`.env`, tokens, `.claude/settings.local.json`).
- El arnés es aditivo: no sobrescribir el `CLAUDE.md` ni el código de producto; proponer primero.

## Atajos / cosas que ya se intentaron
- (vacío — "esto no funcionó porque…", para no repetir el error)
