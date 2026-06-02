#!/usr/bin/env bash
# Setup-Script fuer Intel x86 16-bit Assembly (macOS / Linux)
# Installiert nur was fehlt: Git, VS Code, DOSBox-X, MASM/TASM Extension
#
# Verwendung im Terminal:
#   curl -fsSL https://raw.githubusercontent.com/Kangon01/Intelx86/main/setup.sh | bash

set -e

echo "=== Intel x86 16-bit Assembly Setup ==="
echo ""

OS="$(uname -s)"

skip() { echo "[skip] $1 ist schon installiert."; }
inst() { echo ">> Installiere $1..."; }

has_app() {
    # Prueft Standard-App-Pfade auf macOS
    [ -d "/Applications/$1" ] || [ -d "$HOME/Applications/$1" ]
}

if [ "$OS" = "Darwin" ]; then
    # macOS via Homebrew
    if command -v brew &> /dev/null; then
        skip "Homebrew"
    else
        inst "Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if command -v git &> /dev/null; then
        skip "Git"
    else
        inst "Git"
        brew install git
    fi

    if command -v code &> /dev/null || has_app "Visual Studio Code.app"; then
        skip "VS Code"
    else
        inst "VS Code"
        brew install --cask visual-studio-code
    fi

    if command -v dosbox-x &> /dev/null || has_app "dosbox-x.app"; then
        skip "DOSBox-X"
    else
        inst "DOSBox-X"
        brew install --cask dosbox-x
    fi

elif [ "$OS" = "Linux" ]; then
    # Linux via apt
    sudo apt-get update

    if command -v git &> /dev/null; then
        skip "Git"
    else
        inst "Git"
        sudo apt-get install -y git
    fi

    if command -v code &> /dev/null; then
        skip "VS Code"
    else
        inst "VS Code"
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        rm packages.microsoft.gpg
        sudo apt-get update
        sudo apt-get install -y code
    fi

    if command -v dosbox-x &> /dev/null; then
        skip "DOSBox-X"
    else
        inst "DOSBox-X"
        sudo apt-get install -y dosbox-x || echo "  (nicht im Repo — siehe https://dosbox-x.com)"
    fi
else
    echo "FEHLER: Nicht unterstuetztes OS ($OS). Manueller Setup noetig — siehe README."
    exit 1
fi

echo ""
echo ">> Installiere VS Code Extension xsro.masm-tasm..."
code --install-extension xsro.masm-tasm

echo ""
echo "=== Setup fertig! ==="
echo ""
echo "Naechste Schritte:"
echo "  1. git clone https://github.com/Kangon01/Intelx86.git"
echo "  2. cd Intelx86"
echo "  3. code ."
echo "  4. src/HALLO.ASM oeffnen, Cmd+Shift+B druecken"
echo ""
echo "Tipp: Beim ersten Build wird MASM-v6.11 von der Extension entpackt."
