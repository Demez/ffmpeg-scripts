FOR /F "delims=*" %%A IN ('dir /b *.WEBM') DO (
	if not exist "source-wav\" MD "source-wav"
	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -i "%%A" -map 0 -ar 44100 "source-wav\%%~nA.wav" )
pause