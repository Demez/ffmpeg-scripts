@echo off
FOR /F "delims=*" %%A IN ('dir /b *.MKV') DO (
 	if not exist "mp4_vegas_track1-4\" MD "mp4_vegas_track1-4"
REM 	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -i "%%A" -map 0:v -map 0:a:1 -map 0:a:2 -map 0:a:3 -map 0:a:4 -c copy  "mp4_vegas_track1-4\%%~nA.mp4" )
 	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -i "%%A" -map 0 -map -0:a:0 -c copy  "mp4_vegas_track1-4\%%~nA.mp4" )
pause