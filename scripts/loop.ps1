#Requires -Version 5
<#
.SYNOPSIS
  loop.ps1 — utilidad de worktrees aislados para el loop semi-automatico del arnes (Windows).
.DESCRIPTION
  Crea / lista / limpia un git worktree aislado (rama loop/<nombre>) para que un loop trabaje
  sin chocar con main ni con otros loops. NUNCA commitea ni toca main directamente: solo prepara
  el terreno aislado. Ver el protocolo en .claude/commands/loop-cerrado.md.
.EXAMPLE
  pwsh ./scripts/loop.ps1 new conciliacion-qr
  pwsh ./scripts/loop.ps1 list
  pwsh ./scripts/loop.ps1 clean conciliacion-qr
#>
param(
  [Parameter(Mandatory)][ValidateSet('new','list','clean')][string]$Action,
  [string]$Name
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

# Los worktrees viven en un directorio HERMANO del repo, para no ensuciar el arbol versionado.
$wtBase = Join-Path (Split-Path -Parent $root) ((Split-Path -Leaf $root) + '.loops')

function Need-Name {
  if (-not $Name) { Write-Host "[X] Falta el nombre del loop. Uso: loop.ps1 $Action <nombre>" -ForegroundColor Red; exit 1 }
}

switch ($Action) {
  'new' {
    Need-Name
    $branch = "loop/$Name"
    $path   = Join-Path $wtBase $Name
    if (Test-Path $path) { Write-Host "[X] Ya existe el worktree: $path" -ForegroundColor Red; exit 1 }
    New-Item -ItemType Directory -Force -Path $wtBase | Out-Null
    git worktree add -b $branch $path
    if ($LASTEXITCODE) { Write-Host "[X] git worktree fallo." -ForegroundColor Red; exit 1 }
    Write-Host "[OK] Worktree creado: $path (rama $branch). main queda intacta." -ForegroundColor Green
    Write-Host "     Trabaja el loop ahi; al terminar y pasar los gates, mergea a main." -ForegroundColor Cyan
  }
  'list' {
    git worktree list
  }
  'clean' {
    Need-Name
    $branch = "loop/$Name"
    $path   = Join-Path $wtBase $Name
    git worktree remove $path --force
    git branch -D $branch 2>$null
    Write-Host "[OK] Worktree y rama $branch eliminados." -ForegroundColor Green
  }
}
