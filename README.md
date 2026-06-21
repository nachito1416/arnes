# 🐴 Harness Engineering

> *"Los modelos van a cambiar 1000 veces y el arnés siempre se va a quedar."*

Este repositorio es un **arnés** (harness) para agentes de IA. No es una aplicación ni
magia externa: son **archivos en una carpeta** que se referencian entre sí y que ordenan,
estructuran y verifican el trabajo del modelo.

El modelo (Claude, GPT, Gemini, un modelo open source…) es **el caballo**: potente, rápido,
pero alocado si lo dejas suelto. El arnés son las riendas y la silla: lo que te permite
controlarlo y llevarlo en la dirección correcta.

**El caballo lo alquilas. El arnés es 100 % tuyo.** Por eso el modelo es intercambiable y
el arnés permanece.

---

## ¿Por qué importa más que el modelo?

Los modelos cambian cada ~3 meses. Si construyes tu sistema *encima de un modelo*, cada
versión nueva lo deja obsoleto: tienes que reaprender y reescribir todo.

Si construyes alrededor de un **arnés bien orquestado**, el modelo es solo el cerebro que
enchufas. Hoy Claude, mañana Gemini, pasado un modelo local. El arnés no cambia.

> Obsesiónate con el arnés, no con el modelo. Esa es la jugada más segura a largo plazo.

---

## Los 4 componentes de un arnés

| Componente | Qué es | Dónde vive en este repo |
|------------|--------|--------------------------|
| **Contexto** | Lo que le das al modelo (mínimo y curado) | [`CLAUDE.md`](CLAUDE.md), [`context/`](context/) |
| **Herramientas** | A lo que el modelo puede acceder (mínimas: Bash + archivos) | [`scripts/`](scripts/) |
| **Memoria** | Lo que recuerda entre sesiones, **fuera del modelo** | [`memory/`](memory/), [`progress/`](progress/) |
| **Verificación** | Comprueba si lo que hizo está bien hecho | [`verification/`](verification/), [`scripts/init.sh`](scripts/init.sh) |

---

## Los 3 pilares del Harness Engineering

### Pilar 1 — El arnés vive en tu código
Archivos que se interrelacionan. El punto de entrada es [`CLAUDE.md`](CLAUDE.md) — lo primero
que Claude Code lee en cada sesión. **Corto, < 200 líneas.** Acompañado de un script de
iniciación ([`scripts/init.sh`](scripts/init.sh)), un archivo de tareas
([`tasks.json`](tasks.json)) y una [`carpeta de progreso`](progress/).

> 💡 El estándar abierto y portable se llama `AGENTS.md` (lo leen Codex, Cursor, etc.). Aquí
> usamos `CLAUDE.md` porque es el que **Claude Code** carga automáticamente. Si te mudas a
> otra herramienta, basta renombrar/copiar este archivo a `AGENTS.md`: el contenido es idéntico.

### Pilar 2 — No uses un agente para todo
Un agente líder **orquesta** y delega en subagentes con contexto limpio:
**[lector](.claude/agents/lector.md) → [implementador](.claude/agents/implementador.md) →
[revisor](.claude/agents/revisor.md)**. Cada uno reporta a [`progress/`](progress/) para que
el siguiente retome sin releer todo el proyecto. Un agente solo siempre pierde contra un
equipo multiagente.

### Pilar 3 — Verificación
La IA te puede *mentir sin querer* (una respuesta verosímil no es una respuesta correcta).
El agente no termina porque diga que terminó — termina cuando **el arnés valida** que
terminó. Capas: tests, linter, type check, Playwright y un [agente revisor](.claude/agents/revisor.md).
En **zonas críticas** (dinero, auth, datos personales, migraciones) suma un
[auditor de seguridad](.claude/agents/auditor-seguridad.md) que valida que el cambio es *seguro*,
no solo que *funciona* (checklist en [`verification/SECURITY.md`](verification/SECURITY.md)).
Si el revisor detecta mejoras, actualiza el propio arnés → **self-improving loop**.

---

## Estructura de carpetas

```
Harness Engineering/
├── CLAUDE.md             # 🚪 Punto de entrada. Corto (<200 líneas). Lo lee Claude Code
├── SOUL.md               # 🫀 Identidad / voz / misión del agente (siempre presente)
├── README.md             # Este archivo (el mapa del arnés)
├── tasks.json            # 📋 Tareas con estados (pending / in_progress / done / blocked)
├── scripts/
│   ├── init.sh           # ✅ Verificación pre-sesión (bash / Linux / macOS)
│   └── init.ps1          # ✅ Verificación pre-sesión (Windows / PowerShell)
├── .claude/
│   ├── settings.local.json
│   ├── agents/           # 🤖 Pilar 2 — subagentes por rol
│   │   ├── orquestador.md
│   │   ├── lector.md
│   │   ├── implementador.md
│   │   ├── revisor.md
│   │   └── auditor-seguridad.md  # 🔒 audita zonas críticas (dinero/auth/datos)
│   ├── commands/         # ⌨️  Comandos (p.ej. /empezar-dia)
│   └── skills/           # 🛠️ SOPs reutilizables que se acumulan (Componente "herramientas")
├── context/              # 🧠 Contexto del dominio — curado y mínimo, bajo demanda
├── memory/               # 💾 Memoria fuera del modelo
│   ├── user_profile.md   #    preferencias del usuario (idioma, tono, control) — portable
│   ├── memory.md         #    lecciones técnicas del repo (se lee al inicio; self-improving)
│   └── decisions.md      #    decisiones de arquitectura (ADR ligero)
├── progress/             # 📝 Carpeta de progreso — bitácora de cada paso
└── verification/         # 🔍 Pilar 3 — capas de verificación (incluye SECURITY.md)
```

---

## Cómo empezar HOY (3 pasos)

1. **Escribe tu `CLAUDE.md`.** No tiene que ser perfecto. Pídele a tu agente que te haga
   "preguntas estilo entrevista" para construirlo. Mantenlo **< 200 líneas**.
2. **Agrega un script de verificación** ([`scripts/init.sh`](scripts/init.sh)): corre tests,
   valida la estructura, revisa que nada esté roto. Si falla, **no continúes — pide ayuda.**
3. **Separa tu agente en roles** (mínimo 3): líder, implementador y revisor. Cada subagente
   escribe su resultado en un **archivo** (en [`progress/`](progress/)), no en el chat.

> El repositorio orquesta a varios agentes y verifica todo.
> Construye el arnés y dejarás de preocuparte por el modelo.
