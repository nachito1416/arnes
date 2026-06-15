---
name: registrar-aprendizaje
description: Úsalo cuando el usuario te corrige, te da una preferencia nueva o te pide "acuérdate de esto". Guarda preferencias personales en memory/user_profile.md y reglas técnicas en memory/memory.md.
---

# Skill: registrar-aprendizaje

Convierte una corrección o preferencia en una línea persistente en el archivo de memoria adecuado. Es parte fundamental del self-improving loop.

## Cuándo se dispara
- El usuario te corrige ("no, el tono va más informal").
- Te da una preferencia ("siempre responde en español").
- Te dice explícitamente "acuérdate de esto" o "que no se te olvide".
- Descubres una regla técnica crítica del código durante el desarrollo.

## Pasos
1. Resume el aprendizaje en **una línea accionable**.
2. Identifica dónde guardarlo:
   - **Preferencias personales/estilo/comunicación:** Añade la línea en [`memory/user_profile.md`](../../memory/user_profile.md) (bajo `Preferencias de comunicación`).
   - **Reglas del código/trucos técnicos del repo:** Añade la línea en [`memory/memory.md`](../../memory/memory.md) (bajo `Reglas técnicas` o `Atajos/aprendizajes`).
3. Si es una decisión técnica compleja, deja el detalle en [`memory/decisions.md`](../../memory/decisions.md) y escribe en `memory.md` solo la conclusión + el enlace.
4. ⛔ **Nunca** guardes valores de `.env`, tokens ni secretos. Registra el nombre de la variable, no el secreto.
5. Confírmale al usuario en una línea corta qué registraste y en qué archivo.

## Resultado
La próxima sesión mantendrá este conocimiento al leer ambos archivos al iniciar.

