@echo off
Title BUILDBOT

:::::::::::: CONFIGURACIONES
set gamename=wizpet

set bennupath="E:\Bennu\bin"

set windows=1
set linux=0
set source=1
set wiz=1
set canoo=0
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
"%bennupath%\bgdc.exe" main.prg
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
	GOTO copy_exe
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
copy ..\info.txt %URL%\

xcopy "..\fpg" /E /D /I "%URL%\fpg"
xcopy "..\fnt" /E /D /I "%URL%\fnt"
xcopy "..\audio" /E /D /I "%URL%\audio"

::comprimo archivo
winRAR a -cl -m5 -r %ver%\%gamename%-%ver%-%platform%.zip %gamename%-%platform%\*

::borro archivos
del %URL%\main.dcb
del %URL%\info.txt

del /f/q %URL%\fpg
rd %URL%\fpg
del /f/q %URL%\fnt
rd %URL%\fnt
del /f/q %URL%\audio
rd %URL%\audio

GOTO bot_begin



:::::::::::: CONSTRUYO EL EXE de windows
:copy_exe

SET URL=%gamename%-%platform%

:: copio archivos
copy ..\%gamename%.exe %URL%\
copy ..\info.txt %URL%\

::comprimo archivo
winRAR a -cl -m5 -r %ver%\%gamename%-%ver%-%platform%.zip %gamename%-%platform%\*

::borro archivos
del %URL%\%gamename%.exe
del %URL%\info.txt

SET exe=0

GOTO bot_begin



:::::::::::: CONSTRUYO EL SOURCE
:copy_source

SET URL=%gamename%-%platform%

:: copio archivos
copy ..\main.prg %URL%\
copy ..\info.txt %URL%\
xcopy "..\prg" /E /D /I "%URL%\prg"

xcopy "..\fpg" /E /D /I "%URL%\fpg"
xcopy "..\fnt" /E /D /I "%URL%\fnt"
xcopy "..\audio" /E /D /I "%URL%\audio"

::comprimo archivo
winRAR a -cl -m5 -r %ver%\%gamename%-%ver%-%platform%.zip %gamename%-%platform%\*

::borro archivos
del %URL%\main.prg
del %URL%\info.txt
del /f/q %URL%\fpg
rd %URL%\fpg
del /f/q %URL%\fnt
rd %URL%\fnt
del /f/q %URL%\audio
rd %URL%\audio
del /f/q %URL%\prg
rd %URL%\prg

GOTO bot_begin

:::::::::::: FINAL
:bot_end

:: borro los archivos creados
del ..\main.dcb
del ..\%gamename%.exe

::creo un archivo con todas las releases juntas
winRAR a -cl -m5 -r -ep1 %ver%\%gamename%-all.zip %ver%\*
