# context/ — Contexto curado (Componente 1)

Aqui vive el **contexto del dominio** que el modelo necesita, pero que **no** debe ir en
`CLAUDE.md` (porque ese se carga entero en cada sesion y debe quedar corto).

## Regla de oro: mínimo y curado

> Un arnes muy cargado de informacion funciona **peor**. Un arnes minimo le gana siempre a
> uno inflado (caso Vercel: quitar el 80 % de las herramientas lo hizo 3× mas rapido,
> 47 % mas barato y subio el exito de 80 % a 100 %).

No metas aqui "todo por si acaso". Mete solo lo que el agente va a **necesitar buscar** y
referencialo desde `CLAUDE.md` o desde la tarea puntual. El modelo carga esto **bajo
demanda**, no de entrada.

## Qué poner aquí (ejemplos)

- Glosario del dominio / convenciones del proyecto.
- Esquemas de datos, contratos de API, diagramas.
- Guias de estilo largas, decisiones de arquitectura extensas.
- Referencias externas (enlaces a docs, tickets, dashboards).

## Cómo se referencia

Desde `CLAUDE.md` o desde una tarea: *"para el modelo de datos, lee `context/esquema-db.md`"*.
Asi el contexto entra solo cuando hace falta y la ventana se mantiene limpia.

## Ejemplo incluido: dominio SaaS

Contexto real ya cargado (destilado del curso para humanos en `C:\SaaS`):

- [`saas-fundamentos.md`](saas-fundamentos.md) — qué es un SaaS, las 6 piezas, la ruta de construcción.
- [`saas-stack-bolivia.md`](saas-stack-bolivia.md) — stack por defecto y **pagos por QR** (Stripe está
  bloqueado en Bolivia; verificar el pago es un paso aparte).
