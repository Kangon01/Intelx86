# Intel x86 16-bit Assembly mit MASM

Schreib 16-bit-Assembler-Code in VS Code — drück **`Ctrl+Shift+B`** — das Programm
läuft sofort in DOSBox-X.

Cross-platform: **Windows** · **macOS** · **Linux**.

---

## Installation in 60 Sekunden

### Windows

PowerShell öffnen und ausführen:

```powershell
irm https://raw.githubusercontent.com/Kangon01/Intelx86/main/setup.ps1 | iex
```

### macOS

Terminal öffnen und ausführen:

```bash
curl -fsSL https://raw.githubusercontent.com/Kangon01/Intelx86/main/setup.sh | bash
```

Beide Skripte installieren **Git**, **VS Code**, **DOSBox-X** und die
**MASM/TASM-Extension** — sonst nichts.

> Quick-Setup geht nicht? Siehe [Manuelle Installation](#manuelle-installation) am Ende.

---

## Loslegen

Nach dem Setup **neues** Terminal öffnen (damit `git` im PATH ist):

```bash
git clone https://github.com/Kangon01/Intelx86.git
cd Intelx86
code .
```

In VS Code:

1. Falls Banner *"Recommended extensions"* erscheint → **Install** klicken
2. Datei `src/HALLO.ASM` öffnen
3. **`Ctrl+Shift+B`** drücken *(macOS: `Cmd+Shift+B`)*

Ein DOSBox-X-Fenster öffnet sich, assembliert, linkt und führt den Code aus.
Erwartete Ausgabe:

```
Hallo Welt!
```

> Beim **ersten** Build entpackt die Extension MASM-v6.11 in ihren Storage —
> das dauert ein paar Sekunden, danach ist es schnell.

---

## Eigenes Programm schreiben

1. Neue Datei `src/MEINPROG.ASM` anlegen
2. Code reinschreiben (siehe `HALLO.ASM` oder `ALPHABET.ASM` als Vorlage)
3. **`Ctrl+Shift+B`** drücken

Der Build-Task verwendet automatisch den Namen der gerade geöffneten Datei.

---

## Projekt-Struktur

| Pfad              | Zweck                                       |
| ----------------- | ------------------------------------------- |
| `src/`            | Deine `.ASM`-Quelldateien                   |
| `src/BUILD.BAT`   | Wird vom Build-Task in DOSBox-X aufgerufen  |
| `obj/`            | Object-Files (gitignored)                   |
| `exe/`            | Kompilierte `.EXE`-Dateien (gitignored)     |
| `.vscode/`        | Build-Task, Settings, Extension-Empfehlung  |
| `dosbox-x.conf`   | DOSBox-X Emulator-Settings                  |
| `setup.ps1`       | Windows-Installer                           |
| `setup.sh`        | macOS-/Linux-Installer                      |

---

## Wie es intern funktioniert

`Ctrl+Shift+B` löst diese Kette aus:

1. VS Code startet DOSBox-X mit zwei Mounts:
   - `D:` → Projekt-Ordner
   - `C:` → MASM-Tools (aus dem Extension-Storage)
2. DOSBox wechselt nach `D:\src\` und ruft `BUILD <dateiname>` auf
3. `BUILD.BAT` lässt `ML.EXE` assemblieren + linken:
   `src/HALLO.ASM` → `obj/HALLO.OBJ` → `exe/HALLO.EXE`
4. Die `.EXE` startet direkt im DOSBox-Fenster

---

## Hilfe bei Problemen

### "dosbox-x: command not found" / Task startet nicht

- **Windows**: Prüf, ob `C:\Program Files\DOSBox-X\dosbox-x.exe` existiert.
  Anderer Pfad? In `.vscode/tasks.json` unter `"windows" → "command"` anpassen.
- **macOS**: `brew install --cask dosbox-x`

### "L1093: object file not found" / leeres DOSBox-Fenster

- Extension `xsro.masm-tasm` installiert? Im Extensions-Tab prüfen.
- VS Code einmal neustarten, damit MASM-v6.11 ausgepackt wird.

### Mount-Fehler "Drive C does not exist"

Die Extension packt MASM erst beim ersten Aufruf ihres "Run ASM"-Buttons aus.
**Workaround**: Extension-Button einmal klicken (Fehler ignorieren), dann
mit `Ctrl+Shift+B` weitermachen.

### "Bad command or filename"

Build ist gescheitert — schau im DOSBox-Fenster nach Assembler- oder
Linker-Fehlermeldungen.

---

## Manuelle Installation

Falls das Quick-Setup nicht klappt:

### Windows

| Tool      | Quelle                                                              |
| --------- | ------------------------------------------------------------------- |
| Git       | <https://git-scm.com/download/win>                                  |
| VS Code   | <https://code.visualstudio.com>                                     |
| DOSBox-X  | <https://github.com/joncampbell123/dosbox-x/releases>               |
| Extension | VS Code → Extensions → `xsro.masm-tasm` suchen → **Install**        |

DOSBox-X nach `C:\Program Files\DOSBox-X\` installieren (sonst Task-Pfad anpassen).

### macOS

```bash
brew install git
brew install --cask visual-studio-code dosbox-x
code --install-extension xsro.masm-tasm
```

---

## Lizenz

MIT — frei verwendbar.
