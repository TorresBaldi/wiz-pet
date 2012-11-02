@echo off
cd /d %~dp0
cls

:: CREO FPGS
::del /f/q fpg
::..\..\bin\bgdi.exe build-fpgs.dcb


:: COMPILO PRG
..\..\bin\bgdc.exe -g main.prg


:: EN CASO CORRECTO EJECUTO
IF NOT ERRORLEVEL 2 ..\..\bin\bgdi.exe main.dcb

:: EN CASO INCORRECTO MUESTRO ERROR
IF ERRORLEVEL 2 pause