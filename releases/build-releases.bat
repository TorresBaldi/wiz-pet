@echo off
Title BUILDBOT

:::::::::::: CONFIGURACIONES
set gamename=wizpet

set bennupath="E:\Bennu\bin"

set windows=1
set linux=0
set source=1
set wiz=1
set canoo=1
set exe=1



:::::::::::: PREGUNTO VERSION
cls
echo Ingresar Numero de Version
set /p ver=
mkdir %ver%

::preparo el winrar
set path=%path%;"C:\Archivos de programa\WinRAR"



:::::::::::: CONSTRUYO LA RELEASE
cd ..
"%bennupath%\bgdc.exe" -a main.prg
"%bennupath%\bgdc.exe" -a main.prg -s bgdi.exe -o %gamename%.exe
cd releases\


:::::::::::: RECORRO TODAS LAS PLATAFORMAS
:bot_begin

SET short_path=0

IF %windows% == 0 GOTO skip_windows

	ECHO Windows

	SET windows=0
	SET short_path=1
	SET platform=windows
	GOTO copy_files
:skip_windows

IF %linux% == 0 GOTO skip_linux

	ECHO Linux

	SET linux=0
	SET short_path=1
	SET platform=linux
	GOTO copy_files
:skip_linux

IF %wiz% == 0 GOTO skip_wiz

	ECHO Wiz

	SET wiz=0
	SET platform=wiz
	GOTO copy_files
:skip_wiz

IF %canoo% == 0 GOTO skip_canoo

	ECHO Canoo

	SET canoo=0
	SET platform=canoo
	GOTO copy_files
:skip_canoo

IF %exe% == 0 GOTO skip_exe

	ECHO Windows Exe

	SET exe=2
	SET short_path=1
	SET platform=exe
	GOTO copy_files
:skip_exe

IF %source% == 0 GOTO skip_source

	ECHO Source Code

	SET source=0
	SET platform=source
	GOTO copy_source
:skip_source

:: termie con todas las plataformas
GOTO bot_end


:::::::::::: EMPAQUETO LA RELEASE
:copy_files
SET URL=%gamename%-%platform%\%gamename%
IF %short_path% == 1 SET URL=%gamename%-%platform%

:: copio archivos
copy ..\main.dcb %URL%\

:: si es version exe copio el exe
IF %exe% == 2 del %URL%\main.dcb
IF %exe% == 2 copy ..\%gamename%.exe %URL%\

::comprimo archivo
winRAR a -cl -m5 -r %ver%\%gamename%-%ver%-%platform%.zip %gamename%-%platform%\*

::borro archivos
del %URL%\main.dcb
IF %exe%==2 del %URL%\%gamename%.exe

:: indico que ya se construyo el exe
IF %exe%==2 SET exe=0


GOTO bot_begin



:::::::::::: CONSTRUYO EL SOURCE
:copy_source

SET URL=%gamename%-%platform%

echo copio Archivos a %url%

copy ..\main.prg %URL%\
xcopy "..\fpg" /E /D /I "%URL%\fpg"
xcopy "..\prg" /E /D /I "%URL%\prg"

winRAR a -cl -m5 -r %ver%\%gamename%-%ver%-%platform%.zip %gamename%-%platform%\*

del %URL%\main.prg
del /f/q %URL%\fpg
rd %URL%\fpg
del /f/q %URL%\prg
rd %URL%\prg

GOTO bot_begin

:::::::::::: FINAL
:bot_end

:: borro los archivos creados
del ..\main.dcb
del ..\main.exe

::creo un archivo con todas las releases juntas
winRAR a -cl -m5 -r -ep1 %ver%\%gamename%-all.zip %ver%\*
