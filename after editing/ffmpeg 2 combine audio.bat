FOR /F "delims=*" %%A IN ('dir /b *.MP4') DO (
	if not exist "combined tracks\" MD "combined tracks"
	"C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe" -i "%%A" -i "%%~nA mic.mp4" -filter_complex amerge -c:a aac -b:a 448k -c:v copy -q:a 4 "combined tracks\%%A")
pause