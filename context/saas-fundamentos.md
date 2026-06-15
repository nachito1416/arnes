# Contexto: Fundamentos de un SaaS

> Contexto de dominio **curado**. Se carga BAJO DEMANDA (no va en `CLAUDE.md`). Es la versión
> técnica y corta del curso para humanos en `C:\SaaS` (ahí está la versión larga, con analogías y
> diagramas).

## Definiciones
- **Software**: un programa (código que corre). La pieza más chica.
- **Sistema**: software + datos + usuarios + procesos/reglas, coordinados para un fin.
- **SaaS** (Software as a Service): un sistema entregado por internet, con acceso web y cobro por
  suscripción/uso; el proveedor opera la infraestructura. Relación: **Software ⊂ Sistema ⊂ SaaS**.

## Las 6 piezas de cualquier SaaS
| Pieza | Función | Nota |
|-------|---------|------|
| Frontend | UI que ve y usa el cliente | web y/o móvil |
| Backend | lógica de negocio; procesa pedidos | expone una API |
| Base de datos | persistencia de la información | usuarios, registros, etc. |
| Auth (login) | identidad y control de acceso | pieza sensible (área crítica) |
| Hosting/deploy | dónde corre y queda online | + dominio, HTTPS |
| Pagos | cobro (suscripción o por uso) | en Bolivia ver [`saas-stack-bolivia.md`](saas-stack-bolivia.md) |

## Ruta de construcción (referencia)
Validar la idea → definir MVP → diseño → elegir stack → construir núcleo (auth + función principal)
→ pagos → deploy → conseguir usuarios → medir/iterar.

Reglas: el **MVP resuelve UNA cosa bien**; no agregar piezas que nadie pidió (contexto mínimo);
plan primero para lo sensible.
