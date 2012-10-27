@echo off
cd /d %~dp0
cls

:: COMPILO PRG
..\..\bin\bgdc.exe -g main.prg

:: EN CASO CORRECTO EJECUTO
IF NOT ERRORLEVEL 2 ..\..\bin\bgdi.exe main.dcb
IF NOT ERRORLEVEL 2 del main.dcb

:: EN CASO INCORRECTO MUESTRO ERROR
IF ERRORLEVEL 2 pause