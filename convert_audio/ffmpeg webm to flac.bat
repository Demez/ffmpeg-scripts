FOR /F "delims=*" %%A IN ('dir /b *.WEBM') DO (
	if not exist "flac\" MD "flac"
	"D:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -i "%%A" -map 0 "flac\%%~nA.flac" )
pause