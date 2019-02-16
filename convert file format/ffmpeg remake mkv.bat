@echo off
REM | remakes mkv's, mainly because obs mkv files you can't seek through not on keyframe

FOR /F "delims=*" %%A IN ('dir /b *.MKV') DO (
	if not exist "%%~nA\mkv_old\" MD "%%~nA\mkv_old"
	if not exist "%%~nA\mkv_old\%%A" move "%%A" "%~nA\mkv_old\%%A"
	echo Remaking %%A
	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -v warning -y -i "mkv_old/%%A" -map 0 -c copy "%%A"
	
	
	pause
)
pause