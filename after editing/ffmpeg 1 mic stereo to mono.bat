FOR /F "delims=*" %%A IN ('dir /b *.MP4') DO (
	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -i "%%~nA 1.mp4" -map 0 -ac:2 1 -ab 448k -c:v copy "%%~nA mic.mp4")
pause