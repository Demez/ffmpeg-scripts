@echo off

SETLOCAL ENABLEDELAYEDEXPANSION

set "ffmpegDir=C:\demez_archive\video_editing\ffmpeg\current\bin\"
set "makeMKA=0"

FOR /F "delims=*" %%A IN ('dir /b *.webm *.mkv *.mp4') DO (
	set skip=0
	
	
	"!ffmpegDir!ffprobe.exe" -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "%%A" > temp
	set /p codec=<temp
	
	if !codec!==vorbis (
		if exist "audio_!codec!\%%~nA.ogg" (
			echo "%%~nA.ogg" already exists, skipping
			set skip=1
		)
	) else (
		if exist "audio_!codec!\%%~nA.!codec!" (
			echo "%%~nA.!codec!" already exists, skipping
			set skip=1
		)
	)
	
	if !skip!==0 (
		if not exist "audio_!codec!\" MD "audio_!codec!"
		
		if !codec!==vorbis (
			echo Exporting:	%%A --^> .ogg
		
			"!ffmpegDir!ffmpeg.exe" -y -v warning -i "%%A" -vn -acodec copy "audio_!codec!\%%~nA.ogg"
			
			if !makeMKA!==1 (
				"!ffmpegDir!ffmpeg.exe" -y -v warning -i "%%A" -vn -acodec copy "audio_mka\%%~nA.mka"
			)
		) else (
			echo Exporting:	%%A --^> .!codec!
		
			"!ffmpegDir!ffmpeg.exe" -y -v warning -i "%%A" -vn -acodec copy "audio_!codec!\%%~nA.!codec!"
		)
	)
	echo.
	del temp
)
pause