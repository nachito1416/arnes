# SECURITY.md — Capa de seguridad (Pilar 3 reforzado)

> **El revisor dice "funciona". El auditor de seguridad dice "es seguro".** Son dos preguntas
> distintas y ninguna sustituye a la otra. Aquí vive el **checklist** que ejecuta el subagente
> [`auditor-seguridad`](../.claude/agents/auditor-seguridad.md).

Este arnés se usa para sistemas que mueven **dinero real, impuestos municipales, inversión y
datos de contribuyentes**. Un bug funcional cuesta tiempo; un bug de seguridad cuesta dinero,
multas o la confianza de un municipio. Por eso la seguridad es una **capa propia y obligatoria**,
no un "lo reviso si me acuerdo".

---

## 1. ¿Cuándo es OBLIGATORIA la auditoría de seguridad?

Siempre que el cambio toque una **zona crítica**. Si toca una de estas, la tarea **NO pasa a
`done` ni sube a producción** sin el OK del auditor de seguridad:

- 💰 **Dinero / pagos / impuestos:** cálculo de montos, cobros, conciliación de pagos QR, saldos.
- 🔐 **Auth y sesiones:** login, roles, permisos, tokens, recuperación de contraseña.
- 🗃️ **Datos personales o sensibles (PII):** datos de contribuyentes, documentos, direcciones.
- 🛠️ **Migraciones de base de datos** y cambios de esquema.
- 🌐 **Endpoints públicos / superficie expuesta a internet.**

Para cambios que NO tocan nada de esto (ej: un texto, un estilo, un README), la auditoría es
**opcional** — no frenes trabajo trivial. El criterio lo aplica el orquestador al delegar.

---

## 2. Checklist de seguridad

El auditor recorre estas categorías. Marca cada ítem ✅ / ❌ / N/A con evidencia.

### A. Secretos y credenciales (LÍNEA ROJA)
- [ ] **Cero secretos hardcodeados** (API keys, tokens, contraseñas, `service_role` de Supabase) en el código o en commits.
- [ ] `.env`, `.env.*`, `*.key`, `*.pem`, `secrets/` están en `.gitignore` y **no hay ninguno trackeado** en git.
- [ ] Las claves sensibles (ej. `service_role`) **solo viven en el backend**, nunca en el cliente/Next.js público.
- [ ] No se loguean secretos, tokens ni PII en consola, logs ni mensajes de error.

### B. Dinero, impuestos y pagos (lo más crítico de este dominio)
- [ ] **Validación de montos:** no se aceptan negativos, ceros indebidos, ni desbordes; los importes se manejan con tipo exacto (entero de centavos / decimal), **nunca `float`**.
- [ ] **Idempotencia:** un mismo pago/operación no se puede aplicar dos veces (clave de idempotencia o constraint único). No hay doble cobro ni doble acreditación.
- [ ] **Conciliación del pago QR:** el servicio se habilita **solo después de verificar** que el pago entró realmente (contra banco/pasarela), nunca por el solo hecho de mostrar el QR.
- [ ] **Race conditions:** operaciones sobre saldo/estado usan transacción o bloqueo; dos requests simultáneos no corrompen el saldo.
- [ ] **Trazabilidad / auditoría:** toda operación financiera deja registro inmutable (quién, cuándo, cuánto, resultado) para poder auditar después.
- [ ] **Redondeo** definido y consistente (mismo criterio en cálculo y en lo que ve el usuario).

### C. Control de acceso (AuthN / AuthZ)
- [ ] Cada endpoint/acción verifica **autenticación** Y **autorización** (no alcanza con estar logueado: hay que tener permiso para *ese* recurso).
- [ ] No hay **IDOR** (cambiar un `id` en la URL no te da datos de otro contribuyente/municipio).
- [ ] **Supabase RLS (Row Level Security) activo** en todas las tablas con datos sensibles; las policies se probaron (un usuario no ve filas de otro).
- [ ] Principio de **mínimo privilegio**: cada rol/clave tiene solo los permisos que necesita.

### D. Inyección y validación de entrada
- [ ] **SQL:** consultas parametrizadas / ORM; cero concatenación de strings con input del usuario.
- [ ] **Command / path injection:** no se pasa input del usuario a shell ni a rutas de archivo sin validar.
- [ ] **XSS:** el output que viene de datos del usuario se escapa; nada de `dangerouslySetInnerHTML` sin sanitizar.
- [ ] Toda entrada se **valida en el servidor** (la validación del cliente no cuenta como seguridad).

### E. Dependencias y configuración
- [ ] `npm audit` (o equivalente del stack) sin vulnerabilidades **high/critical** sin justificar.
- [ ] No se agregaron dependencias innecesarias (cada dependencia es superficie de ataque).
- [ ] CORS, headers y configuración de producción no quedan en modo permisivo/debug.

---

## 3. Herramientas (correr lo que aplique)

```bash
# Secretos trackeados por error (no debería devolver nada sensible)
git ls-files | grep -E '\.env($|\.)|\.key$|\.pem$'

# ¿Está .env realmente ignorado?
git check-ignore .env

# Vulnerabilidades en dependencias (Node)
npm audit --audit-level=high

# Búsqueda rápida de secretos hardcodeados (ajustar patrones al stack)
#   claves tipo sk-..., service_role, BEGIN PRIVATE KEY, password = "..."
```

> Claude Code trae el comando **`/security-review`** (revisión de seguridad del diff de la rama).
> El auditor puede apoyarse en él, pero **no lo reemplaza**: el criterio de dominio (dinero,
> impuestos, conciliación QR) lo pone este checklist.

---

## 4. Decisión del auditor

- ✅ **APRUEBA** → registra en [`progress/`](../progress/) los ítems revisados con su evidencia (comandos + salida). Recién entonces el revisor puede pasar la tarea a `done`.
- ❌ **RECHAZA** → deja la tarea en `blocked`, explica **cada hallazgo con su severidad** (crítico / alto / medio / bajo) y la forma de corregirlo, y la devuelve al implementador.

**Regla de oro:** ante la duda en una zona crítica, **se rechaza y se pide plan humano numerado**.
En sistemas con dinero de por medio, un falso "todo bien" es mucho más caro que un falso "frená".
