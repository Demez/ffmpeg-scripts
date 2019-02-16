@echo off
setlocal enabledelayedexpansion

@REM ok i need to start using python now holy shit

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
	
	call :findFile i #
)

@REM output file
set "FakeQuote="
set "foundFakeQuote=0"
for %%a in ('%*') do (
	set currentSelection=%%a
	
	call :findFile o $
)

@REM get commands
set "FakeQuote="
set "foundFakeQuote=0"
for %%a in ('%*') do (
	set currentSelection=%%a
	
	call :findFile commands @
)

echo Input File:	%input%
echo Output File:	%ouput%


pause
exit


:findFile inout quote
set lineStart=!currentSelection:~0,2!
set lineEnd=!currentSelection:~-1!

if !lineStart!==-%~1 (
	set foundFakeQuote=1
)

if !lineEnd!==%~2 (
	set foundFakeQuote=0
	set "FakeQuote=!FakeQuote! !currentSelection!"
)

if !foundFakeQuote!==1 (		
	set "FakeQuote=!FakeQuote! !currentSelection!"
)

if %~1==i (
	set input=%FakeQuote:~4,-1%
	if !lineEnd!==-o (
		set foundFakeQuote=0
		set "FakeQuote=!FakeQuote! !currentSelection!"
	)
)

if %~1==o (
	set ouput=%FakeQuote:~4,-2%
)

if %~1==commands (
	set commands=%FakeQuote:~1,-2%
)

EXIT /B 0




pause