# [2026-06-21] Pulir el Prompt D para actualizar proyectos viejos — (rol: orquestador)

## Tarea
Continuación de T-009. El Prompt D (actualizar arnés instalado) servía, pero quedaban 3 huecos para
actualizar proyectos VIEJOS de forma completa y reproducible (copiar-pegar sin improvisar).

## Que se hizo (3 mejoras al Prompt D de prompts-arnes.md)
1. **Referencia vía REPO GIT:** el punto 1 ahora indica clonar `https://github.com/nachito1416/arnes`
   en una carpeta temporal (portable, cualquier máquina) o usar `C:\Harness Engineering` si es la
   misma PC. Avisa de NO copiar el `.git` ni mezclarlo con el repo del proyecto.
2. **Corrección de subagentes viejos:** nuevo bullet en el punto 2 — si un agente está en
   `model: gemini-...` o inferior, pasarlo a `model: opus`.
3. **Capas nuevas del preflight:** el punto 4 ahora suma `SECURITY.md` + `auditor-seguridad` a la
   estructura, la capa de "secretos fuera de git", y el fix del validador JSON (stub `python3` de
   Windows/Git Bash que daba falso negativo).

## Archivos tocados
- `prompts-arnes.md` — Prompt D (blockquote + puntos 1, 2, 4)
- `progress/2026-06-21-prompt-d-pulido.md` (este registro)

## Estado / verificacion
- Preflight `init.ps1` corrido ANTES de tocar (regla del arnés) → [OK] 5/5 verde.
- Relectura del Prompt D completo: coherente, las 3 mejoras presentes.
- Commit con preflight como **gate** (no commitea si el arnés está roto) + push.
- Resultado: ✅ aprobado.

## Siguiente paso
- Nada pendiente. El Prompt D ahora actualiza proyectos viejos de punta a punta: copiás, pegás, listo.
