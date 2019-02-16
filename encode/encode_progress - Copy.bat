@echo off
@REM | idk

setlocal EnableDelayedExpansion

:loop 
findstr "frame=" in encode.temp > current_encode.temp 2>nul

for /f "tokens=*" %%c in (current_encode.temp) do (
	set progress=%%c
)

cls
@REM echo Encode Progress:
echo !progress:~12!


@REM timeout 1
ping 127.0.0.1 -n 0 -w 750> nul

goto :loop

del current_encode.temp >NUL 2>NUL

pause