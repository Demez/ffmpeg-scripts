FOR /F "delims=*" %%A IN ('dir /b *.MP4') DO (
	if not exist "%%~nA\" MD "%%~nA"
	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -i "%%A" -map 0:v -c copy "%%~nA\%%~nA.mp4" -map 0:a:0 -c copy "%%~nA\%%~nA 1.aac" -map 0:a:1 -c copy "%%~nA\%%~nA 2.aac")
pause