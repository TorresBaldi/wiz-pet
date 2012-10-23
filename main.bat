@echo off
cd /d %~dp0
del main.dcb
..\..\bin\bgdc.exe -g main.prg

IF ERRORLEVEL 1 ..\..\bin\bgdi.exe main.dcb
IF NOT ERRORLEVEL 1 pause