#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# loop.sh — utilidad de worktrees aislados para el loop semi-automatico del arnes.
#
# Crea / lista / limpia un git worktree aislado (rama loop/<nombre>) para que un loop
# trabaje sin chocar con main ni con otros loops. NUNCA commitea ni toca main directamente:
# solo prepara el terreno aislado. Ver el protocolo en .claude/commands/loop-cerrado.md.
#
# Uso:  bash ./scripts/loop.sh new <nombre> | list | clean <nombre>
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
# Los worktrees viven en un directorio HERMANO del repo, para no ensuciar el arbol versionado.
WT_BASE="$(dirname "$ROOT")/$(basename "$ROOT").loops"

action="${1:-}"
name="${2:-}"

need_name() { [ -n "$name" ] || { printf '\033[31m[X] Falta el nombre. Uso: loop.sh %s <nombre>\033[0m\n' "$action"; exit 1; }; }

case "$action" in
  new)
    need_name
    branch="loop/$name"; path="$WT_BASE/$name"
    [ -e "$path" ] && { printf '\033[31m[X] Ya existe: %s\033[0m\n' "$path"; exit 1; }
    mkdir -p "$WT_BASE"
    git worktree add -b "$branch" "$path"
    printf '\033[32m[OK] Worktree en %s (rama %s). main queda intacta.\033[0m\n' "$path" "$branch"
    ;;
  list)
    git worktree list
    ;;
  clean)
    need_name
    branch="loop/$name"; path="$WT_BASE/$name"
    git worktree remove "$path" --force
    git branch -D "$branch" 2>/dev/null || true
    printf '\033[32m[OK] Worktree y rama %s eliminados.\033[0m\n' "$branch"
    ;;
  *)
    echo "Uso: loop.sh new <nombre> | list | clean <nombre>"; exit 1
    ;;
esac
