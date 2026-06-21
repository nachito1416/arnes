# CLAUDE.md — Punto de entrada del arnés

> **Claude Code lee este archivo automáticamente al iniciar cada sesión.** Es el onboarding de
> un nuevo empleado: quién eres, qué hace este proyecto, dónde están las cosas y qué hacer
> antes de empezar. **Manténlo corto (< 200 líneas).** Todo lo extenso vive en otros archivos
> que se enlazan desde aquí — no lo pegues acá.

---

## 1. Quién eres

Eres un agente que trabaja dentro de un **arnés**. No improvises fuera de las reglas de este
archivo. El modelo es intercambiable; el arnés (estas reglas y archivos) manda.

La **identidad y la voz** del agente (quién es, su misión, su tono) viven en [`SOUL.md`](SOUL.md);
el **cómo** operativo (reglas, verificación, flujo) está aquí.

## 2. Qué es este proyecto

> ✏️ **Reemplaza esto** por una descripción de 2-4 líneas de tu proyecto: qué construye,
> para quién y cuál es el objetivo. (Plantilla de arnés basada en Harness Engineering.)

## 3. Mapa: dónde están las cosas

| Necesitas… | Ve a… |
|------------|-------|
| Identidad / voz del agente | [`SOUL.md`](SOUL.md) |
| Entender el arnés completo | [`README.md`](README.md) |
| Saber qué hacer ahora | [`tasks.json`](tasks.json) |
| Ver qué se hizo antes | [`progress/`](progress/) |
| Perfil del usuario (preferencias de comunicación/control) | [`memory/user_profile.md`](memory/user_profile.md) |
| Lecciones técnicas aprendidas en el proyecto | [`memory/memory.md`](memory/memory.md) |
| Decisiones de arquitectura | [`memory/decisions.md`](memory/decisions.md) |
| Contexto curado del dominio | [`context/`](context/) |
| SOPs reutilizables (skills) | [`.claude/skills/`](.claude/skills/) |
| Cómo se verifica el trabajo | [`verification/README.md`](verification/README.md) |
| Checklist de **seguridad** (dinero / auth / datos) | [`verification/SECURITY.md`](verification/SECURITY.md) |
| Definición de los subagentes | [`.claude/agents/`](.claude/agents/) |

## 4. ⚠️ Antes de empezar CUALQUIER cambio

1. Ejecuta el script de verificación:
   - Windows: `pwsh ./scripts/init.ps1`
   - Linux / macOS: `bash ./scripts/init.sh`
2. **Si falla, NO continúes.** El proyecto está roto: pide ayuda o arregla el estado primero.
   No trabajes horas sobre un proyecto roto — el arnés detecta el problema antes que tú.
3. Lee [`memory/user_profile.md`](memory/user_profile.md) (preferencias y estilo del usuario) y [`memory/memory.md`](memory/memory.md) (lecciones técnicas específicas del repo), [`tasks.json`](tasks.json) y la última entrada de [`progress/`](progress/) para saber en qué se quedó el agente anterior. **Retoma desde ahí**, no releas todo el proyecto.

## 5. Flujo de trabajo (Pilar 2 — multiagente)

No hagas todo con un solo agente. Delega por roles:

```
        ┌─────────────────┐
        │   ORQUESTADOR   │  entiende la tarea grande y delega
        └────────┬────────┘
     ┌───────────┼───────────────┐
     ▼           ▼               ▼
 ┌────────┐ ┌──────────────┐ ┌──────────┐
 │ LECTOR │ │IMPLEMENTADOR │ │ REVISOR  │
 │ lee /  │ │ escribe      │ │ verifica │
 │investiga│ │ código       │ │ aprueba/ │
 └────────┘ └──────────────┘ │ rechaza  │
                             └────┬─────┘
                                  ▼  si toca ZONA CRÍTICA
                        ┌────────────────────┐
                        │ AUDITOR-SEGURIDAD  │  ¿es seguro?
                        │  aprueba / rechaza │
                        └────────────────────┘
```

- Cada subagente arranca con **contexto limpio** y una **tarea concreta**.
- Cada subagente escribe su resultado en **un archivo** dentro de [`progress/`](progress/),
  nunca solo en el chat. Así el siguiente no reinvestiga lo ya investigado.
- **Zona crítica** (dinero/pagos/impuestos, auth, datos personales, migraciones, endpoints
  públicos): el revisor **no alcanza**. El [`auditor-seguridad`](.claude/agents/auditor-seguridad.md)
  debe aprobar **antes** de `done` y antes de producción. Ver [`verification/SECURITY.md`](verification/SECURITY.md).
- Detalle de cada rol en [`.claude/agents/`](.claude/agents/).

## 6. Verificación (Pilar 3)

**El agente no termina porque diga que terminó. Termina cuando el arnés valida que terminó.**
No confíes en "ya quedó, todo funciona". Verifica con capas (tests, lint, type check,
Playwright, agente revisor). Detalle en [`verification/README.md`](verification/README.md).

**Seguridad = capa propia y obligatoria.** Este arnés mueve dinero real, impuestos y datos de
contribuyentes. El **revisor** dice "funciona"; el **auditor-seguridad** dice "es seguro". En
zonas críticas, ninguna tarea pasa a `done` ni sube a producción sin el OK del auditor. Checklist
adaptado al dominio (idempotencia, conciliación de pago QR, RLS, PII, inyección) en
[`verification/SECURITY.md`](verification/SECURITY.md).

## 7. Reglas de oro

- **Contexto mínimo.** Menos herramientas, menos reglas, menos ruido → mejor desempeño
  (caso Vercel: quitar el 80 % de las herramientas lo hizo 3× más rápido y 47 % más barato).
- **Saca la memoria del modelo.** El avance de cada tarea va en [`progress/`](progress/); las preferencias del usuario van en [`memory/user_profile.md`](memory/user_profile.md); y las lecciones del repo van en [`memory/memory.md`](memory/memory.md). **Cuando te corrijan o aprendas algo, actualízalo** (self-improving loop). Mantén la ventana de contexto limpia.
- **Comprime / reinicia la sesión** cuando el contexto pase ~40-50 %: la calidad se degrada
  mucho antes de llenarse, incluso con ventanas de 1M de tokens.
- **El arnés es portable.** Los 3 pilares funcionan igual en Codex, Cursor u OpenCode; solo
  cambia el nombre del archivo de entrada. Este se llama `CLAUDE.md` porque es el que **Claude
  Code** lee solo. Si te mudas a otra herramienta, renombra (o copia) este archivo a
  **`AGENTS.md`**, el estándar abierto que esas herramientas leen. El contenido es el mismo.

## 8. Self-improving loop

Si detectas que una regla falta o que algo se puede mejorar, **actualiza el propio arnés**
(este `CLAUDE.md`, los agentes o `verification/`) y déjalo registrado en
[`memory/decisions.md`](memory/decisions.md). El arnés se mejora a sí mismo.

## 9. Los 4 elementos del agente (dónde vive cada uno)

- **Identidad** → [`SOUL.md`](SOUL.md): quién es el agente, su misión y su voz. Siempre presente.
- **Memoria** → [`memory/user_profile.md`](memory/user_profile.md) (usuario) y [`memory/memory.md`](memory/memory.md) (proyecto): léelas al inicio (§4) y actualízalas cuando aprendas algo. (Decisiones en [`memory/decisions.md`](memory/decisions.md).)
- **Contexto** → [`context/`](context/): dominio curado. **No lo pegues aquí**; cárgalo bajo
  demanda ("antes de la tarea X, lee `context/Y`").
- **Skills** → [`.claude/skills/`](.claude/skills/): SOPs reutilizables. Un proceso recurrente se
  explica una vez y se invoca por nombre; se acumulan con el tiempo.

---

<!-- Límite duro: este archivo NO debe superar las 200 líneas. Si crece, mueve el detalle a
     context/, memory/ o verification/ y enlázalo desde aquí. -->
