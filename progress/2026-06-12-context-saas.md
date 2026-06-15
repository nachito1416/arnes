# [2026-06-12] Destilar dominio SaaS al context/ — (rol: implementador)

## Tarea
T-005 — poblar `context/` con el dominio SaaS, destilado del curso para humanos (`C:\SaaS`).

## Que se hizo
- Se crearon dos archivos de contexto curado (cortos, técnicos, bajo demanda):
  - `context/saas-fundamentos.md` — software/sistema/SaaS + las 6 piezas + ruta de construcción.
  - `context/saas-stack-bolivia.md` — stack por defecto + pagos por QR (Stripe bloqueado en Bolivia)
    + áreas críticas + estrategia de replicar.
- Se actualizó `context/README.md` para listar el ejemplo de dominio incluido.

## Archivos tocados
- context/saas-fundamentos.md (nuevo)
- context/saas-stack-bolivia.md (nuevo)
- context/README.md — sección "Ejemplo incluido"
- tasks.json — T-005 en done; updated 2026-06-12

## Estado / verificacion
- Preflight corrido ANTES y DESPUES del cambio: `pwsh ./scripts/init.ps1` → verde.
- Cambio aditivo (solo se agregaron archivos en context/; no se tocó código ni áreas críticas).
- Resultado: ✅ aprobado.

## Siguiente paso
- Opcional: referenciar estos archivos desde `CLAUDE.md` (mapa) o desde la tarea concreta, para que
  se carguen al construir un SaaS.
- Pendiente conversado: material 3 (reducir tokens/costo del arnés y de los loops).
