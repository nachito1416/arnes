#Requires -Version 5
<#
.SYNOPSIS
  init.ps1 — Script de iniciacion / verificacion del arnes (Pilar 1 + Pilar 3) para Windows.
.DESCRIPTION
  Se ejecuta ANTES de empezar cualquier cambio. Verifica que el proyecto este en buen estado:
  estructura, archivos clave y tests. Si algo falla -> sale con codigo != 0 para que el agente
  NO continue sobre un proyecto roto.
.EXAMPLE
  pwsh ./scripts/init.ps1
#>
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$script:fail = $false
function Ok($m)   { Write-Host "  [OK] $m"   -ForegroundColor Green }
function Bad($m)  { Write-Host "  [X]  $m"   -ForegroundColor Red; $script:fail = $true }
function Info($m) { Write-Host $m -ForegroundColor Cyan }

Info "Verificando el arnes en: $root"

# 1) Archivos y carpetas clave ----------------------------------------------
Info "[1/4] Estructura del arnes"
foreach ($f in 'CLAUDE.md','tasks.json','README.md','SOUL.md','memory/memory.md','memory/user_profile.md') {
  if (Test-Path $f) { Ok "existe $f" } else { Bad "falta $f" }
}
foreach ($d in 'scripts','.claude/agents','.claude/commands','.claude/skills','context','memory','progress','verification') {
  if (Test-Path $d -PathType Container) { Ok "existe $d/" } else { Bad "falta carpeta $d/" }
}

# 2) CLAUDE.md corto (< 200 lineas) -----------------------------------------
Info "[2/4] CLAUDE.md se mantiene corto (< 200 lineas)"
if (Test-Path CLAUDE.md) {
  $lines = (Get-Content CLAUDE.md | Measure-Object -Line).Lines
  if ($lines -lt 200) { Ok "CLAUDE.md tiene $lines lineas" }
  else { Bad "CLAUDE.md tiene $lines lineas (>= 200): muevelo a context/" }
}

# 3) tasks.json es JSON valido ----------------------------------------------
Info "[3/4] tasks.json es JSON valido"
try { Get-Content tasks.json -Raw | ConvertFrom-Json | Out-Null; Ok "tasks.json parsea" }
catch { Bad "tasks.json NO es JSON valido" }

# 4) Tests / lint / typecheck del proyecto ----------------------------------
#    👇 Reemplaza estos placeholders por los comandos reales de tu stack.
Info "[4/4] Tests del proyecto (placeholders — adaptar a tu stack)"
# Ejemplos:
#   npm test        ; if ($LASTEXITCODE) { Bad "tests fallaron" }
#   npm run lint    ; if ($LASTEXITCODE) { Bad "lint fallo" }
#   pytest -q       ; if ($LASTEXITCODE) { Bad "pytest fallo" }
Ok "sin tests configurados todavia (ver tarea T-002 en tasks.json)"

# Resultado ------------------------------------------------------------------
Write-Host ""
if ($script:fail) {
  Write-Host "[X] Arnes en mal estado. NO continues: arregla lo anterior o pide ayuda." -ForegroundColor Red
  exit 1
}
Write-Host "[OK] Arnes OK. Puedes empezar a trabajar." -ForegroundColor Green
exit 0
