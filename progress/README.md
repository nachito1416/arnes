# progress/ — Carpeta de progreso (Pilar 1)

Aqui cada agente **va guardando lo que hace**: resultados de cada paso, decisiones tomadas y
archivos que toco. Es lo que permite que un agente nuevo **no tenga que releer todo el
proyecto**: va a la ultima entrada, entiende en que se quedo el equipo y **retoma desde ahi**.

## Reglas

- **Cada subagente escribe su resultado en un archivo aqui, NO solo en el chat.** Asi el
  siguiente subagente carga ese contexto y no reinvestiga lo ya investigado.
- Un archivo por unidad de trabajo. Nombra con fecha + tema:
  `AAAA-MM-DD-tema.md` (ej. `2026-05-30-login-fix.md`).
- Conciso y accionable. Esto es memoria de trabajo, no un ensayo.

## Plantilla de una entrada

```markdown
# [AAAA-MM-DD] Titulo — (rol: lector | implementador | revisor)

## Tarea
T-00X — que se pidio.

## Que se hizo
- Paso 1…
- Paso 2…

## Archivos tocados
- ruta/archivo.ext:linea — que cambio

## Estado / verificacion
- Comando corrido y su salida (evidencia).
- Resultado: ✅ aprobado / ❌ rechazado / ⏳ en progreso.

## Siguiente paso
- Que falta y para quien (que subagente sigue).
```

Hay un ejemplo en [`0000-ejemplo.md`](0000-ejemplo.md).
