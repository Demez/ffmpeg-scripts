@echo off

SETLOCAL ENABLEDELAYEDEXPANSION

FOR /F "delims=*" %%A IN ('dir /b *.webm *.mkv *.mp4') DO (
	echo Converting %%A
	
	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffprobe.exe" -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "%%A" > temp
	set /p codec=<temp
	
	if not exist "audio\!codec!\" MD "audio\!codec!"
	
	if !codec!==vorbis (
		"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -y -v warning -i "%%A" -vn -acodec copy "audio\!codec!\%%~nA.ogg"
	) else (
		"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -y -v warning -i "%%A" -vn -acodec copy "audio\!codec!\%%~nA.!codec!"
	)

	del temp
)
pause