@echo off
Title BUILDBOT

set gamename=wizpet

set windows=1
set exe=1
set linux=0
set wiz=1
set canoo=0

:::::::::::: PREGUNTO VERSION
cls
echo Ingresar Numero de Version
set /p ver=
mkdir %ver%

::preparo el winrar
set path=%path%;"C:\Archivos de programa\WinRAR"


:::::::::::: RECORRO TODAS LAS PLATAFORMAS
:bot_begin

SET short_path=0

IF %windows% == 0 GOTO skip_windows

	IF %exe% == 1 SET exe=2

	SET windows=0
	SET short_path=1
	SET platform=windows
	GOTO copy_files
:skip_windows

SET exe=0

IF %linux% == 0 GOTO skip_linux

	SET linux=0
	SET short_path=1
	SET platform=linux
	GOTO copy_files
:skip_linux

IF %wiz% == 0 GOTO skip_wiz
	SET wiz=0
	SET platform=wiz
	GOTO copy_files
:skip_wiz

IF %canoo% == 0 GOTO skip_canoo
	SET canoo=0
	SET platform=canoo
	GOTO copy_files
:skip_canoo

:: termie con todas las plataformas
GOTO bot_end


:::::::::::: CONSTRUYO LA RELEASE
:copy_files

SET URL=%gamename%-%platform%\%gamename%
IF %short_path% == 1 SET URL=%gamename%-%platform%

echo copio Archivos a %url%

copy ..\main.prg %URL%\
xcopy "..\fpg" /E /D /I "%URL%\fpg"
xcopy "..\prg" /E /D /I "%URL%\prg"

::del %URL%\data\config.dat

echo genero archivo %ver%\%gamename%-%ver%-%platform%.zip

winRAR a -cl -m5 -r %ver%\%gamename%-%ver%-%platform%.zip %gamename%-%platform%\*
IF %exe% == 2 winRAR s -zsfx.txt %ver%\%gamename%-%ver%-%platform%.zip

echo limpio carpeta

del %URL%\main.prg
del /f/q %URL%\fpg
rd %URL%\fpg
del /f/q %URL%\prg
rd %URL%\prg

GOTO bot_begin

:bot_end
