#!/usr/bin/env bash
# Setup-Script fuer Intel x86 16-bit Assembly (macOS / Linux)
# Installiert: Git, VS Code, DOSBox-X, MASM/TASM Extension
#
# Verwendung im Terminal:
#   curl -fsSL https://raw.githubusercontent.com/Kangon01/Intelx86/main/setup.sh | bash

set -e

echo "=== Intel x86 16-bit Assembly Setup ==="

OS="$(uname -s)"

if [ "$OS" = "Darwin" ]; then
    # macOS: Homebrew
    if ! command -v brew &> /dev/null; then
        echo ">> Installiere Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo ""
    echo ">> Installiere Git, VS Code, DOSBox-X via Homebrew..."
    brew install git
    brew install --cask visual-studio-code dosbox-x

elif [ "$OS" = "Linux" ]; then
    # Linux: apt-basiert annehmen
    echo ">> Installiere Git und DOSBox-X via apt..."
    sudo apt-get update
    sudo apt-get install -y git dosbox-x || {
        echo "Hinweis: dosbox-x evtl. nicht im Repo. Pruefe https://dosbox-x.com fuer Downloads."
    }

    if ! command -v code &> /dev/null; then
        echo ">> Installiere VS Code..."
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        rm packages.microsoft.gpg
        sudo apt-get update
        sudo apt-get install -y code
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
echo "  4. HALLO.ASM oeffnen, Cmd+Shift+B druecken"
echo ""
echo "Tipp: Beim ersten Build wird MASM-v6.11 von der Extension entpackt."
