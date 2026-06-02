# Setup-Script fuer Intel x86 16-bit Assembly (Windows)
# Installiert: Git, VS Code, DOSBox-X, MASM/TASM Extension via winget
#
# Verwendung in PowerShell:
#   irm https://raw.githubusercontent.com/Kangon01/Intelx86/main/setup.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host "=== Intel x86 16-bit Assembly Setup (Windows) ===" -ForegroundColor Cyan

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "FEHLER: winget nicht gefunden." -ForegroundColor Red
    Write-Host "Loesung: App Installer aus dem Microsoft Store installieren oder Windows 10/11 aktualisieren."
    exit 1
}

function Install-WingetPkg($id, $name) {
    Write-Host "`n>> Installiere $name..." -ForegroundColor Yellow
    winget install -e --id $id --accept-package-agreements --accept-source-agreements --silent
}

Install-WingetPkg "Git.Git" "Git"
Install-WingetPkg "Microsoft.VisualStudioCode" "Visual Studio Code"
Install-WingetPkg "joncampbell123.DOSBox-X" "DOSBox-X"

# PATH refresh, damit 'code' Befehl gefunden wird
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "`n>> Installiere VS Code Extension xsro.masm-tasm..." -ForegroundColor Yellow
code --install-extension xsro.masm-tasm

Write-Host "`n=== Setup fertig! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Naechste Schritte:" -ForegroundColor Cyan
Write-Host "  1. NEUES PowerShell-Fenster oeffnen (damit PATH aktualisiert ist)"
Write-Host "  2. git clone https://github.com/Kangon01/Intelx86.git"
Write-Host "  3. cd Intelx86"
Write-Host "  4. code ."
Write-Host "  5. HALLO.ASM in VS Code oeffnen, Ctrl+Shift+B druecken"
Write-Host ""
Write-Host "Tipp: Beim ersten Build wird MASM-v6.11 von der Extension entpackt." -ForegroundColor Gray
