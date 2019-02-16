@echo off

setlocal enabledelayedexpansion

set "ffmpegDir=C:\demez_archive\video_editing\ffmpeg\current\bin\"

if not exist "combined tracks\" MD "combined tracks"
echo ----------------------------------------------------------------------------------------

FOR /F "delims=*" %%A IN ('dir /b *.MP4') DO (
	@REM !ffmpegDir!ffmpeg.exe -y -v warning -i "%%A" -fliter_complex "[0:1][0:2] amerge=inputs=2" -c:a libopus -b:a 128k -c:v copy -map 0:1 -map 0:2 "combined tracks\%%~nA.mkv"
	
	echo %%A
	
	if not exist "combined tracks\%%~nA.mkv" (
		@REM combine the audio tracks
		echo Combining Audio...
		!ffmpegDir!ffmpeg.exe -y -v 0 -i "%%A" -filter_complex "[0:1][0:2] amerge=inputs=2" -c:a aac -b:a 448k -c:v copy -map 0:a "combined tracks\%%~nA.mka"
		
		@REM combine the merged audio with the video
		echo Combining Merged Audio with Video...
		!ffmpegDir!ffmpeg.exe -y -v 0 -i "%%A" -i "combined tracks\%%~nA.mka" -c copy -map 1 -map 0 "combined tracks\%%~nA.mkv"
		
		del "combined tracks\%%~nA.mka"
	) else (
		echo Already combined, skipping
	)
	
	echo ----------------------------------------------------------------------------------------
)
pause