@echo off

SETLOCAL ENABLEDELAYEDEXPANSION

set "ffmpegDir=C:\demez_archive\video_editing\ffmpeg\current\bin\"
set "makeMKA=0"

@REM This batch file exports audio from webm, mkv, and mp4 currently
@REM if you want to add support for one, just include the file extension in the for loop

echo.

FOR /F "delims=*" %%A IN ('dir /b *.webm *.mkv *.mp4') DO (
	
	"!ffmpegDir!ffprobe.exe" -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "%%A" > temp
	set /p codec=<temp
	
	if not exist "old\" MD "old"
	
	if !codec!==vorbis (
		echo Exporting:  %%A --^> .ogg
	
		"!ffmpegDir!ffmpeg.exe" -y -v warning -i "%%A" -vn -acodec copy "%%~nA.ogg"
		
		if !makeMKA!==1 (
			"!ffmpegDir!ffmpeg.exe" -y -v warning -i "%%A" -vn -acodec copy "%%~nA.mka"
		)
	) else (
		echo Exporting:  %%A --^> .!codec!
	
		"!ffmpegDir!ffmpeg.exe" -y -v warning -i "%%A" -vn -acodec copy "%%~nA.!codec!"
	)
	
	move "%%A" "old\%%A" >nul
	echo Moved:      %%A --^> old\
	
	echo.
	del temp
)
pause