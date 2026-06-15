# memory/ — Memoria fuera del modelo (Componente 3)

> La solucion a que los agentes "se vuelvan mas tontos" con el tiempo es **sacar la memoria
> fuera del modelo**. El modelo solo carga lo esencial (un punto de entrada) y todo lo demas
> lo va dejando en archivos. Lo que ya hizo, lo anota y lo deja afuera → la ventana de
> contexto se mantiene limpia.

## memory/ vs progress/

- **`memory/`** = hechos persistentes y decisiones que siguen siendo verdad sesion tras
  sesion (el "por que" del proyecto). Cambia poco.
- **[`progress/`](../progress/)** = bitacora de lo que se fue haciendo paso a paso (el "que
  paso"). Crece en cada sesion.

## Qué guardar aquí

- Decisiones de arquitectura y su justificacion → [`decisions.md`](decisions.md).
- Hechos estables del proyecto que no se derivan del codigo (acuerdos, restricciones,
  convenciones que el equipo eligio).
- Atajos aprendidos: "esto ya lo intentamos y no funciono porque…".

## Por qué importa

La degradacion del contexto empieza temprano (cerca del 20-40 %) incluso en ventanas de 1M
de tokens: mas espacio no significa mejor. Externalizar la memoria es lo que permite el
**self-improving loop**: el arnes recuerda sin saturar al modelo.

## Archivos

- [`user_profile.md`](user_profile.md) — **Perfil del usuario** (preferencias de comunicación, tono, idioma, nivel de detalle y reglas de interacción). Es portátil entre proyectos.
- [`memory.md`](memory.md) — **Lecciones aprendidas y reglas específicas del proyecto**. Registra atajos, trucos de desarrollo y restricciones técnicas descubiertas en el repositorio.
- [`decisions.md`](decisions.md) — **Decisiones de arquitectura** y su justificación (ADR ligero).

