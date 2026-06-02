# Setup-Script fuer Intel x86 16-bit Assembly (Windows)
# Installiert nur was fehlt: Git, VS Code, DOSBox-X, MASM/TASM Extension
#
# Verwendung in PowerShell:
#   irm https://raw.githubusercontent.com/Kangon01/Intelx86/main/setup.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host "=== Intel x86 16-bit Assembly Setup (Windows) ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "FEHLER: winget nicht gefunden." -ForegroundColor Red
    Write-Host "Loesung: App Installer aus dem Microsoft Store installieren oder Windows 10/11 aktualisieren."
    exit 1
}

function Ensure-Tool {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$WingetId,
        [string]$Command = $null,
        [string[]]$TestPaths = @()
    )

    $installed = $false
    if ($Command -and (Get-Command $Command -ErrorAction SilentlyContinue)) {
        $installed = $true
    }
    foreach ($p in $TestPaths) {
        if (Test-Path $p) { $installed = $true; break }
    }

    if ($installed) {
        Write-Host "[skip] $Name ist schon installiert." -ForegroundColor DarkGray
    } else {
        Write-Host ">> Installiere $Name..." -ForegroundColor Yellow
        winget install -e --id $WingetId --accept-package-agreements --accept-source-agreements --silent
    }
}

Ensure-Tool -Name "Git" `
    -WingetId "Git.Git" `
    -Command "git" `
    -TestPaths @(
        "$env:ProgramFiles\Git\cmd\git.exe",
        "${env:ProgramFiles(x86)}\Git\cmd\git.exe"
    )

Ensure-Tool -Name "VS Code" `
    -WingetId "Microsoft.VisualStudioCode" `
    -Command "code" `
    -TestPaths @(
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe",
        "$env:ProgramFiles\Microsoft VS Code\Code.exe",
        "${env:ProgramFiles(x86)}\Microsoft VS Code\Code.exe"
    )

Ensure-Tool -Name "DOSBox-X" `
    -WingetId "joncampbell123.DOSBox-X" `
    -TestPaths @(
        "$env:ProgramFiles\DOSBox-X\dosbox-x.exe",
        "${env:ProgramFiles(x86)}\DOSBox-X\dosbox-x.exe"
    )

# PATH refresh, damit 'code' Befehl gefunden wird (falls VS Code gerade installiert wurde)
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host ""
Write-Host ">> Installiere VS Code Extension xsro.masm-tasm..." -ForegroundColor Yellow
code --install-extension xsro.masm-tasm

Write-Host ""
Write-Host "=== Setup fertig! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Naechste Schritte:" -ForegroundColor Cyan
Write-Host "  1. NEUES PowerShell-Fenster oeffnen (damit PATH aktualisiert ist)"
Write-Host "  2. git clone https://github.com/Kangon01/Intelx86.git"
Write-Host "  3. cd Intelx86"
Write-Host "  4. code ."
Write-Host "  5. src/HALLO.ASM oeffnen, Ctrl+Shift+B druecken"
Write-Host ""
Write-Host "Tipp: Beim ersten Build wird MASM-v6.11 von der Extension entpackt." -ForegroundColor Gray
