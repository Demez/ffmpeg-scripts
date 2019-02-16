@echo off

@REM | This allows me to use variables in for loops when i use !variable!
SETLOCAL ENABLEDELAYEDEXPANSION

@REM moves all files into mkv_old and remakes it in original directory

@REM %%~pX gets the path only
@REM %%~dX gets the drive letter only

set "showExtraInfo=0"
set "mkv_old_dir=mkv_old"

echo.
echo =========================================================
echo.
echo                       Remaking MKV's                     
echo.
echo =========================================================
echo.

FOR /F "delims=*" %%A IN ('dir /b /s *.MKV') DO (
	if !showExtraInfo!==1 (
		echo selected "!filedir!!file!"
	)
	if !showExtraInfo!==3 (
		echo selected "!filedir!!file!"
	)
		
	set nextFile=0
	set "file=%%~nxA"
	set "filedir=%%~pA"
	
	(echo !filedir! | findstr /i /c:"!mkv_old_dir!" >nul) && (
		if !showExtraInfo!==2 (
			echo skipping "!filedir!!file!"
		)
		if !showExtraInfo!==3 (
			echo skipping "!filedir!!file!"
		)
		set nextFile=1
		
	) || (
	
		if !nextFile!==0 (
			if not exist "!filedir!!mkv_old_dir!\" (
				md "!filedir!!mkv_old_dir!"
				echo Making mkv_old folder
			)
			
			if not exist "!filedir!!mkv_old_dir!\!file!" (
				echo Moving !filedir!!file!
				move "%%A" "!filedir!!mkv_old_dir!\!file!" >nul
			)
		
			if not exist "%%A" (
				echo Remaking %%A
				echo Press [q] to stop, [?] for help
				"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -v warning -y -i "%%~dA!filedir!!mkv_old_dir!\!file!" -map 0 -c copy "%%A"
				echo ----------------------------------------------------------------------
			)
		)
	)
)
echo.
echo =========================================================
echo.
echo          Finished Running, press any key to quit         
echo.
echo =========================================================

pause >nul