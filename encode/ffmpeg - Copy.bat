@echo off
setlocal enabledelayedexpansion

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

set baseFileName=%2
set baseFileName=!baseFileName:~1!

echo fake quotes:
set "FakeQuote="
set "foundFakeQuote=0"
set "increment=0"

for %%a in ('%*') do (
	set /a increment+=1
	set currentSelection=%%a
	
	set lineStart=!currentSelection:~0,2!
	set lineEnd=!currentSelection:~-1!
	
	if !lineStart!==-i (
		echo !currentSelection!
		set foundFakeQuote=1
	)
	
	if !lineEnd!==# (
		echo !currentSelection!
		set foundFakeQuote=0
		set "FakeQuote=!FakeQuote! !currentSelection!"
	)
	
	echo foundFakeQuote= !foundFakeQuote!
	
	if !foundFakeQuote!==1 (		
		set "FakeQuote=!FakeQuote! !currentSelection!"
	)
	
	echo --------------------------------------------
)

echo.
echo.
echo.
echo.

set input=%FakeQuote:~5,-1%

set "FakeQuote="
set "foundFakeQuote=0"
set "increment=0"
for %%a in ('%*') do (
	set /a increment+=1
	set currentSelection=%%a
	
	set lineStart=!currentSelection:~0,2!
	set lineEnd=!currentSelection:~-1!
	
	if !lineStart!==-o (
		echo !currentSelection!
		set foundFakeQuote=1
	)
	
	if !lineEnd!==# (
		echo !currentSelection!
		set foundFakeQuote=0
		set "FakeQuote=!FakeQuote! !currentSelection!"
	)
	
	echo foundFakeQuote= !foundFakeQuote!
	
	if !foundFakeQuote!==1 (
		
		set input=%!increment!
		
		echo !input!
		
		set "FakeQuote=!FakeQuote! !currentSelection!"
	)
	
	echo --------------------------------------------
)

set ouput=%FakeQuote:~5,-1%

echo Input File:	%input%
echo Output File:	%ouput%

@REM %variable:StrToFind=NewStr%

:findFile input_or_output
for %%a in ('%*') do (
	set /a increment+=1
	set currentSelection=%%a
	
	set lineStart=!currentSelection:~0,2!
	set lineEnd=!currentSelection:~-1!
	
	if !lineStart!==-%~1 (
		echo !currentSelection!
		set foundFakeQuote=1
	)
	
	if !lineEnd!==# (
		echo !currentSelection!
		set foundFakeQuote=0
		set "FakeQuote=!FakeQuote! !currentSelection!"
	)
	
	echo foundFakeQuote= !foundFakeQuote!
	
	if !foundFakeQuote!==1 (		
		set "FakeQuote=!FakeQuote! !currentSelection!"
	)
	
	echo --------------------------------------------
)


pause