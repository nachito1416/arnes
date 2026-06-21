---
description: Corre un loop semi-automático sobre una unidad de trabajo acotada — aislado en un worktree, con auto-corrección, gates y tope de iteraciones. El loop trabaja solo hasta los gates; vos controlás producción.
---

Ejecutá un **loop semi-automático** (loop cerrado) sobre UNA unidad de trabajo acotada. La idea
(de los videos de loop engineering): en vez de prompts sueltos, el arnés **itera solo**
—implementa → testea → si falla, corrige y reintenta— **aislado** y **con frenos**, hasta dejarte
el trabajo listo. Vos diseñás y supervisás *desde arriba* (human on the loop), no en cada paso.

> ⚠️ Esto consume tokens en bucle. Respetá el **tope de iteraciones** y los **gates**. No lances
> loops gigantes "para no hacer nada" — la factura se dispara (la advertencia del video 1).

## 0. Precondiciones (si alguna falla, NO arranques)
- Preflight en verde: `pwsh ./scripts/init.ps1` (o `bash ./scripts/init.sh`).
- El objetivo está **acotado y es verificable** (sabés cómo se prueba que quedó bien).
- Tenés claro si toca **zona crítica** (dinero/pagos/impuestos, auth, datos personales, migraciones).

## 1. Validar el plan (el "doctor")
Antes de tocar nada, escribí el plan y validá que sea correcto y acotado. Si el objetivo es ambiguo
o gigante, **paralo y pedile al usuario que lo afine o lo parta**. Un mal plan = un loop que gira en falso.

## 2. Aislar (worktree)
Creá el entorno aislado para no chocar con `main` ni con otros loops:
```
pwsh ./scripts/loop.ps1 new <nombre>      # crea la rama loop/<nombre> en un worktree hermano
```
Copiá `loops/_plantilla-estado.md` → `loops/<nombre>-estado.md` y completá objetivo, zona crítica y plan.

## 3. Iterar (la unidad de loop, máximo 4 vueltas)
Repetí, actualizando `loops/<nombre>-estado.md` en CADA vuelta:
1. **implementador** → escribe el cambio más pequeño que cumple el objetivo.
2. **revisor** → corre tests/lint/typecheck/preflight + lectura crítica. ¿Funciona?
3. Si el revisor **rechaza** → volvé al paso 1 con el aprendizaje anotado. Si **aprueba** → seguí.
4. **auditor-seguridad** (SOLO si zona crítica) → audita contra `verification/SECURITY.md`. ¿Es seguro?

**Tope:** si llegás a **4 iteraciones** sin pasar los gates, **FRENÁ**, dejá el estado en
`abortado-por-tope` y reportá al usuario qué bloqueó. No sigas quemando tokens.

## 4. Salida — gates de cierre (según alcance acordado)
- **Cambio NORMAL (no crítico)** y revisor en verde → el loop **puede mergear a `main` solo**:
  ```
  git switch main; git merge --no-ff loop/<nombre>
  pwsh ./scripts/loop.ps1 clean <nombre>
  ```
- **Cambio de ZONA CRÍTICA** (dinero/auth/datos/migraciones), aunque revisor Y auditor aprueben →
  **FRENÁ antes de tocar `main`**. Dejá el estado en `frenado-esperando-OK` y pedí el **OK humano**.
  Motivo: `main` puede estar conectado a auto-deploy (Vercel) y hay dinero de por medio.
- **Producción / deploy:** SIEMPRE manual del usuario. El loop **nunca** deploya.

## 5. Cerrar
- Dejá una bitácora en [`progress/`](../../progress/) (qué se hizo, evidencia, estado final).
- Limpiá el worktree (`scripts/loop.* clean <nombre>`).
- Si aprendiste algo reutilizable, registralo (skill `registrar-aprendizaje` / `memory/`).

## Líneas rojas (innegociables)
1. 🔴 **Gate humano antes de producción** y antes de tocar `main` en **zona crítica**.
2. 🔴 **Tope de iteraciones (4).** Si no se logra, frená y reportá — no gires en falso.
3. 🔴 El loop trabaja **siempre en su worktree/rama**, nunca commitea directo sobre `main`.
