@echo off
@REM | idk

setlocal EnableDelayedExpansion

cls


:loop
@REM echo loop_count = !loop_count!

tasklist /FI "IMAGENAME eq ffmpeg.exe" 2>NUL | find /I /N "ffmpeg.exe">NUL

if not "%ERRORLEVEL%"=="0" (
	cls
	echo ffmpeg not found
	timeout 2 >nul
	goto :loop
)

findstr "frame=" in encode.temp > current_encode.temp 2>nul

for /f "tokens=*" %%c in (current_encode.temp) do (
	set progress=%%c
)

cls
echo Encode Progress:
echo !progress:~12!
	

goto :loop

del current_encode.temp >NUL 2>NUL

pause