@echo off
setlocal enabledelayedexpansion

@REM ok i need to start using python now holy shit this is a FUCKING MESS

IF "%*"=="" (
	echo this needs to be started from a batch file
	echo with the full ffmpeg command line put into the start command
	echo with the file name being wrapped in #
	echo.
	echo Example:
	echo start /WAIT cmd /k "ffmpeg.bat" C:\ffmpeg\bin\ffmpeg.exe -i #file with spaces.mkv# -argument
	echo.
	pause
	exit
)

@REM ----------------------------------------------------------------

echo fake quotes:
echo.

@REM input file
set "FakeQuote="
set "foundFakeQuote=0"
for %%a in ('%*') do (
	set currentSelection=%%a
	set lineStart=!currentSelection:~0,2!
	set lineEnd=!currentSelection:~-2!
	
	call :findFile i -o
)

@REM output file
set "FakeQuote="
set "foundFakeQuote=0"
for %%a in ('%*') do (
	set currentSelection=%%a
	set lineStart=!currentSelection:~0,2!
	set lineEnd=!currentSelection:~-2!
	
	call :findFile o -c
)

@REM get commands
set "FakeQuote="
set "foundFakeQuote=0"
for %%a in ('%*') do (
	set currentSelection=%%a
	set lineStart=!currentSelection:~0,2!
	set lineEnd=!currentSelection:~-2,-1!
	
	call :findFile c @
)

echo Input File:	%input%
echo Output File:	%ouput%
echo Commands:	%commands%


pause
exit


:findFile inout quote
echo %~1
if !lineStart!==-%~1 (
	echo.
	set foundFakeQuote=1
	echo !currentSelection!
	echo starting
	echo.
)

if !lineEnd!==%~2 (
	echo.
	echo !currentSelection!
	echo ending
	echo.
	set foundFakeQuote=0
	set "FakeQuote=!FakeQuote!"
)

if !foundFakeQuote!==1 (		
	set "FakeQuote=!FakeQuote! !currentSelection!"
)

if %~1==i (
	set input=%FakeQuote:~4,-1%
)

if %~1==o (
	set ouput=%FakeQuote:~4,-1%
)

if %~1==c (
	set commands=%FakeQuote:~4%
)

EXIT /B 0




pause