@echo off
rem BUILD.BAT - Assembler + Linker (DOS COMMAND.COM kompatibel)
rem Aufruf in DOSBox-X: BUILD HALLO  (ohne .ASM)
rem Voraussetzung: dosbox-x.conf aus Projektordner starten

if "%1"=="" goto usage

echo === Assembliere + Linke %1.ASM ===
ml /nologo /FoD:\obj\%1.OBJ /FeD:\exe\%1.EXE D:\src\%1.ASM
if errorlevel 1 goto buildfail

echo === Starte %1.EXE ===
D:\exe\%1.EXE
goto end

:usage
echo Verwendung: BUILD Dateiname  (ohne .ASM)
echo Beispiel:   BUILD HALLO
goto end

:buildfail
echo FEHLER beim Build!

:end
