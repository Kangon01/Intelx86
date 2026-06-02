# Intel x86 16-bit Assembly mit MASM

VS Code Setup für 16-bit Intel x86 Assembly-Programmierung mit Microsoft MASM 6.11
unter DOSBox-X. Funktioniert auf **Windows**, **macOS** und **Linux**.

Drücke `Ctrl+Shift+B` (Windows/Linux) bzw. `Cmd+Shift+B` (macOS) in VS Code
und das geöffnete `.ASM`-Programm wird assembliert, gelinkt und ausgeführt.

---

## Quick-Setup (eine Zeile)

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/Kangon01/Intelx86/main/setup.ps1 | iex
```

### macOS (Terminal)

```bash
curl -fsSL https://raw.githubusercontent.com/Kangon01/Intelx86/main/setup.sh | bash
```

Das Script installiert: **Git**, **VS Code**, **DOSBox-X** und die **MASM/TASM Extension**.

Nach Setup-Lauf neues Terminal öffnen und:

```bash
git clone https://github.com/Kangon01/Intelx86.git
cd Intelx86
code .
```

In VS Code dann `src/HALLO.ASM` öffnen und `Ctrl+Shift+B` drücken.

---

## Manuelle Installation

Falls das Quick-Setup nicht funktioniert oder du es lieber Schritt für Schritt machst:

### Windows

1. **Git**: <https://git-scm.com/download/win>
2. **VS Code**: <https://code.visualstudio.com>
3. **DOSBox-X**: <https://github.com/joncampbell123/dosbox-x/releases>
   → Installiere nach `C:\Program Files\DOSBox-X\`
4. **MASM/TASM Extension** in VS Code: `xsro.masm-tasm` aus Marketplace installieren

### macOS

```bash
brew install git
brew install --cask visual-studio-code dosbox-x
code --install-extension xsro.masm-tasm
```

---

## Erste Schritte

1. Repo klonen + öffnen:
   ```bash
   git clone https://github.com/Kangon01/Intelx86.git
   cd Intelx86
   code .
   ```
2. VS Code zeigt Banner: **"Recommended extensions"** → "Install" klicken
   (falls die Extension noch nicht installiert wurde)
3. `src/HALLO.ASM` öffnen
4. **`Ctrl+Shift+B`** (bzw. `Cmd+Shift+B` auf macOS) drücken
5. DOSBox-X startet, baut + führt das Programm aus

Beim ersten Build entpackt die Extension automatisch MASM-v6.11 nach
`globalStorage/xsro.masm-tasm/MASM-v6.11/` — das dauert ein paar Sekunden.

---

## Eigenes Programm schreiben

1. Neue Datei `src/MEINPROG.ASM` anlegen
2. Code rein (siehe `HALLO.ASM` oder `ALPHABET.ASM` als Vorlage)
3. Datei im Editor öffnen
4. `Ctrl+Shift+B` drücken

`BUILD.BAT` nimmt automatisch den Namen der gerade geöffneten Datei.

---

## Projekt-Struktur

```
.
├── src/                  # Quellcode (.ASM Dateien)
│   ├── BUILD.BAT         # Assembler + Linker (wird vom Task aufgerufen)
│   ├── HALLO.ASM         # Beispiel: "Hallo Welt!"
│   └── ALPHABET.ASM      # Beispiel: Alphabet A-Z
├── obj/                  # Object-Files (gitignored)
├── exe/                  # Executables (gitignored)
├── .vscode/
│   ├── tasks.json        # Build-Task (cross-platform)
│   ├── settings.json     # Editor-Einstellungen
│   └── extensions.json   # Empfohlene Extensions
├── dosbox-x.conf         # DOSBox-X Emulator-Settings
├── setup.ps1             # Windows-Installer
├── setup.sh              # macOS/Linux-Installer
└── README.md
```

---

## Wie funktioniert's intern?

1. `Ctrl+Shift+B` startet die Task in `.vscode/tasks.json`
2. Die Task startet DOSBox-X mit Mount-Befehlen:
   - `D:` → dein Projekt-Ordner
   - `C:` → MASM-Tools aus dem Extension-Storage
3. Im DOSBox wechselt es nach `D:\src\` und ruft `BUILD <dateiname>` auf
4. `BUILD.BAT` ruft `ML.EXE` (Microsoft Macro Assembler) auf:
   - assembliert `src/*.ASM` nach `obj/*.OBJ`
   - linkt nach `exe/*.EXE`
   - startet die `.EXE`

Das ganze in einer integrierten DOSBox-X-Session — kein Terminal-Wechsel nötig.

---

## Troubleshooting

**"dosbox-x: command not found" / Task startet nicht:**
- Windows: Prüfe ob `C:\Program Files\DOSBox-X\dosbox-x.exe` existiert.
  Falls anderer Pfad: `.vscode/tasks.json` → `windows.command` anpassen.
- macOS: `brew install --cask dosbox-x` ausführen.

**"L1093: object file not found" oder leeres DOSBox-X-Fenster:**
- Extension `xsro.masm-tasm` installiert? Prüfe Extensions-Tab in VS Code.
- VS Code 1x neustarten, damit MASM-v6.11 ausgepackt wird.

**Mount-Fehler "Drive C does not exist":**
- Erster Build noch nicht gelaufen — die Extension packt MASM beim ersten
  Aufruf ihres "Run ASM"-Buttons aus. Workaround: Extension-Button 1x klicken
  (Fehler ignorieren), dann `Ctrl+Shift+B` versuchen.

**"Bad command or filename":**
- Programm wurde nicht erfolgreich gebaut. Schaue im DOSBox-X-Fenster nach
  Fehlern beim Assemblieren/Linken.

---

## Lizenz

MIT — frei verwendbar.
