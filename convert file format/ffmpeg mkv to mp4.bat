@echo off
FOR /F "delims=*" %%A IN ('dir /b *.MKV') DO (
 	if not exist "mp4\" MD "mp4"
 	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -i "%%A" -map 0 -c copy  "mp4\%%~nA.mp4" )
pause