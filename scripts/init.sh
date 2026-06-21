#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# init.sh — Script de iniciacion / verificacion del arnes (Pilar 1 + Pilar 3)
#
# Se ejecuta ANTES de empezar cualquier cambio. Verifica que el proyecto este en
# buen estado: estructura, archivos clave y tests. Si algo falla -> sale con codigo
# != 0 para que el agente NO continue sobre un proyecto roto.
#
# Uso:   bash ./scripts/init.sh
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail=0
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }
bad()  { printf '  \033[31m✗\033[0m %s\n' "$1"; fail=1; }
info() { printf '\033[1m%s\033[0m\n' "$1"; }

info "🐴 Verificando el arnes en: $ROOT"

# 1) Archivos clave del arnes ------------------------------------------------
info "[1/5] Estructura del arnes"
for f in CLAUDE.md tasks.json README.md SOUL.md memory/memory.md memory/user_profile.md verification/SECURITY.md .claude/agents/auditor-seguridad.md; do
  [ -f "$f" ] && ok "existe $f" || bad "falta $f"
done
for d in scripts .claude/agents .claude/commands .claude/skills context memory progress verification; do
  [ -d "$d" ] && ok "existe $d/" || bad "falta carpeta $d/"
done

# 2) CLAUDE.md corto (< 200 lineas) ------------------------------------------
info "[2/5] CLAUDE.md se mantiene corto (< 200 lineas)"
if [ -f CLAUDE.md ]; then
  lines=$(wc -l < CLAUDE.md | tr -d ' ')
  if [ "$lines" -lt 200 ]; then ok "CLAUDE.md tiene $lines lineas"; else bad "CLAUDE.md tiene $lines lineas (>= 200): muevelo a context/"; fi
fi

# 3) tasks.json es JSON valido -----------------------------------------------
info "[3/5] tasks.json es JSON valido"
# Buscar un validador que REALMENTE ejecute. Ojo: en Windows/Git Bash, "python3" suele ser el
# stub de Microsoft Store (existe en PATH pero no ejecuta), por eso lo probamos antes de usarlo.
json_validator=""
if python3 -c "pass" >/dev/null 2>&1;   then json_validator="python3"
elif python -c "pass" >/dev/null 2>&1;  then json_validator="python"
elif node -e "0" >/dev/null 2>&1;       then json_validator="node"
fi
case "$json_validator" in
  python3|python)
    "$json_validator" -c "import json; json.load(open('tasks.json', encoding='utf-8'))" 2>/dev/null \
      && ok "tasks.json parsea" || bad "tasks.json NO es JSON valido"
    ;;
  node)
    node -e "JSON.parse(require('fs').readFileSync('tasks.json','utf8'))" 2>/dev/null \
      && ok "tasks.json parsea" || bad "tasks.json NO es JSON valido"
    ;;
  *)
    info "  (sin validador de JSON disponible — instala python3 o node para activar este chequeo)"
    ;;
esac

# 4) Tests / lint / typecheck del proyecto -----------------------------------
#    👇 Reemplaza estos placeholders por los comandos reales de tu stack.
info "[4/5] Tests del proyecto (placeholders — adaptar a tu stack)"
# Ejemplos segun el proyecto:
#   npm test --silent            || bad "tests fallaron"
#   npm run lint                 || bad "lint fallo"
#   npm run typecheck            || bad "typecheck fallo"
#   pytest -q                    || bad "pytest fallo"
ok "sin tests configurados todavia (ver tarea T-002 en tasks.json)"

# 5) Seguridad basica: secretos fuera de git ---------------------------------
info "[5/5] Seguridad basica (secretos fuera de git)"
if [ -f .gitignore ]; then
  grep -qE '^\.env' .gitignore && ok ".env esta en .gitignore" || bad ".env NO esta en .gitignore (LINEA ROJA)"
else
  bad "falta .gitignore"
fi
if git ls-files 2>/dev/null | grep -vE '\.example$' | grep -qE '(\.env($|\.))|(\.key$)|(\.pem$)'; then
  bad "hay secretos trackeados en git (.env/.key/.pem)"
else
  ok "no hay .env/.key/.pem trackeados en git"
fi

# Resultado -------------------------------------------------------------------
echo
if [ "$fail" -ne 0 ]; then
  printf '\033[31m✗ Arnes en mal estado. NO continues: arregla lo anterior o pide ayuda.\033[0m\n'
  exit 1
fi
printf '\033[32m✓ Arnes OK. Puedes empezar a trabajar.\033[0m\n'
