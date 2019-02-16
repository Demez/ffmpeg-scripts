@echo off
setlocal enabledelayedexpansion

set "ffmpegDir=C:\demez_archive\video_editing\ffmpeg\current\bin\"

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
@REM this could probably be cleaned up a bit, idk

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
echo -----------------------------------------------------------------------------------------
echo.

!ffmpegDir!ffmpeg.exe -i "%input%" %commands% "%ouput%"

if not %ERRORLEVEL%==0 (
	echo.
	echo -----------------------------------------
	echo An error has occurred, press any key to exit
	pause >nul
)
exit


:findFile inout quote
@REM so what this does is look for a string within the currently selected string
@REM they are used to determine the start and end of a line
@REM used for finding the input, the output, and the commands
if !lineStart!==-%~1 (
	set foundFakeQuote=1
)

if !lineEnd!==%~2 (
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