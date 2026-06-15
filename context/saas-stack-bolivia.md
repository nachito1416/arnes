# Contexto: Stack y pagos (Bolivia)

> Contexto de dominio **curado**, BAJO DEMANDA. Lo específico de ESTE entorno para construir un SaaS.

## Stack por defecto (proponer salvo que el usuario pida otro)
- **Frontend**: Next.js (React).
- **Backend + base de datos + auth**: Supabase (Postgres gestionado, Auth, APIs, storage).
- **Hosting/deploy**: Vercel.
- Mantener el stack **mínimo**; no sumar dependencias sin pedirlas.

## Pagos en Bolivia — CRÍTICO (no asumir Stripe)
- **Stripe está BLOQUEADO en Bolivia.** No proponerlo como pasarela. PayPal, limitado.
- Se cobra por **QR** (códigos QR bancarios / pasarelas locales).
- **Cobrar y verificar son dos trabajos distintos:**
  1. Mostrar el QR de pago al cliente.
  2. **Verificar que el pago entró** (conciliación con el banco/pasarela) ANTES de habilitar el
     servicio. Esta es la parte difícil y es un punto de diseño propio.
- No dar por hecho cobro recurrente automático tipo suscripción: con QR suele ser pago manual +
  verificación. Diseñar el flujo en consecuencia.

## Áreas críticas (pedir plan humano numerado antes de tocar)
Pagos / verificación de pago · Auth y sesiones · Datos personales o sensibles · Migraciones de BD.

## Estrategia de producto
- Para **aprender**: un proyecto propio está bien.
- Para **vender**: conviene **replicar** — construir un sistema base para un tipo de cliente y
  adaptarlo a muchos parecidos (cambian marca/detalles; el núcleo se reutiliza).
