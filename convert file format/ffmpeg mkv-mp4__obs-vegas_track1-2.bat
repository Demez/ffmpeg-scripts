@echo off
FOR /F "delims=*" %%A IN ('dir /b *.MKV') DO (
 	if not exist "mp4_vegas_track1-2\" MD "mp4_vegas_track1-2"
 	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -v warning -y -i "%%A" -map 0:v -map 0:a:1 -map 0:a:2 -c copy  "mp4_vegas_track1-2\%%~nA.mp4" )
pause