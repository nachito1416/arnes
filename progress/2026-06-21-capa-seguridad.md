# [2026-06-21] Montar la capa de seguridad del arnés — (rol: orquestador)

## Tarea
T-006 — El arnés no tenía ningún punto que verificara la **seguridad** de lo que se construye.
Para un sistema con dinero real, impuestos municipales e inversión, ese era el hueco más caro.
Crear una capa de seguridad obligatoria. (Surge de analizar 2 videos de "loop engineering" — ver
sección Contexto — que confirmaron que la seguridad no la cubre nadie.)

## Que se hizo
- **Nuevo subagente `auditor-seguridad`** (`.claude/agents/auditor-seguridad.md`, `model: opus`):
  audita la seguridad DESPUÉS del revisor. Solo-lectura + Bash (separación de funciones: NO edita
  el código que audita). Aprueba/rechaza con severidad y deja informe en `progress/`.
- **`verification/SECURITY.md`**: checklist adaptado al dominio — secretos, **dinero/impuestos**
  (idempotencia, conciliación de pago QR, race conditions, trazabilidad), control de acceso +
  **Supabase RLS**, PII de contribuyentes, inyección, dependencias.
- **Gate de seguridad** cableado en el flujo: en zonas críticas (dinero/pagos, auth, datos
  personales, migraciones, endpoints públicos) ninguna tarea pasa a `done` ni a producción sin el
  OK del auditor.
- **Preflight reforzado** (`init.ps1` + `init.sh`): nueva capa `[5/5]` que verifica que `.env` está
  en `.gitignore` y que no hay `.env`/`.key`/`.pem` trackeados en git. Exige los 2 archivos nuevos.

## Archivos tocados
- `.claude/agents/auditor-seguridad.md` — NUEVO (subagente)
- `verification/SECURITY.md` — NUEVO (checklist)
- `CLAUDE.md` — mapa + diagrama de flujo + sección de verificación con el gate
- `.claude/agents/orquestador.md` — delega al auditor y exige el gate en zona crítica
- `.claude/agents/revisor.md` — no marca `done` en zona crítica sin el auditor
- `.claude/commands/empezar-dia.md` — menciona el gate
- `scripts/init.ps1` + `scripts/init.sh` — capa `[5/5]` de secretos + exigen los archivos nuevos
- `verification/tasks.schema.json` — `auditor-seguridad` sumado al enum de `owner`
- `tasks.json` — T-006 (done) + `updated`
- `README.md` + `prompts-arnes.md` — propagan la capa de seguridad a la plantilla
- `memory/decisions.md` — ADR 2026-06-21

## Estado / verificacion
- `init.ps1` (Windows/PowerShell) → **[OK] Arnes OK**, las 5 capas en verde (estructura con los 2
  archivos nuevos, CLAUDE.md < 200 líneas, tasks.json parsea, seguridad: secretos fuera de git).
- `init.sh` (Bash) → **✓ Arnes OK**, EXIT=0.
- **Bug de portabilidad encontrado al verificar en las 2 rutas:** `init.sh` usaba `command -v python3`,
  que en Windows/Git Bash da falso positivo con el **stub de Microsoft Store** (existe en PATH pero no
  ejecuta) → marcaba `tasks.json NO es JSON valido` siendo válido. Corregido: ahora prueba que el
  validador realmente ejecute (python3 → python → node) y, si no hay ninguno, OMITE en vez de marcar
  error. Self-improving loop en acción: verificar de verdad encontró el bug.
- Los 5 subagentes confirmados en `model: opus`.
- Resultado: ✅ aprobado.

## Contexto (de dónde salió)
Análisis de 2 videos de "loop engineering" (transcripciones en `loops.docx`). Conclusión: el arnés
ya cubre casi todo lo del "loop abierto" (subagentes, verificación, memoria). Faltaba SEGURIDAD
(esta tarea) y el **loop cerrado/semi-automático** (worktrees + gates + tope de coste).

## Siguiente paso
- Acordado con el usuario: **vamos uno por uno**. Primero esta capa de seguridad (esta tarea);
  después, en sesión aparte y con calma, el **loop semi-automático** (Opción B): git worktrees,
  `/loop` con tope de iteraciones/coste, gate humano obligatorio antes de producción.
