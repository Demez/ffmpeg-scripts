@echo off
@REM | encodes all mkv's with hevc very high quality
@REM | i set this stuff up with StaxRip or IFME

setlocal enabledelayedexpansion

set "ffmpegDir=C:\demez_archive\video_editing\ffmpeg\current\bin\"
@REM set "settings=-y -map 0 -c:a copy -c:v libx265 -crf 8 -preset medium"
set "settings=-y -map 0 -c:a copy -c:v libx265 -crf 8 -preset medium"
@REM set "settings=-y -map 0 -c:a copy -c:v libx265 -x265-params lossless=1 -preset medium"
@REM just makes the file bigger

set "externalProgress=1"
@REM set to 0 for errors only really

@REM -x265-params lossless=1

echo.
echo Encoding Settings:	!settings!
echo.
echo =======================================================================


FOR /F "delims=*" %%A IN ('dir /b *.MKV') DO (
	echo Selected:		%%A
	@REM check the codec of the video
	!ffmpegDir!ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "%%A" >codec.temp
	set /p codec= <codec.temp
	
	if not !codec!==h264 (
		del codec.temp
		
		if not exist "raw\" MD "raw"
		@REM eif not exist "raw\%%A" (
			@REM emove "%%A" "raw\%%A" >nul
			@REM echo Moved to raw folder
		@REM e)
		
		echo Encoding from:		!codec! --^> hevc
		
		@REM get video duration and frames
		echo|set /p="Video Duration:		"
		!ffmpegDir!ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "%%A"
		
		@REM !ffmpegDir!ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "raw\%%A"
		
		@REM shows the progress of ffmpeg
		if !externalProgress!==1 (
			@REM start /WAIT cmd /c !ffmpegDir!ffmpeg.exe -i "%%A" !settings! "%%~nA - crf 64.mkv"
			
			@REM calls a ffmpeg batch file with these commands
			@REM start /WAIT cmd /c !ffmpegDir!ffmpeg.exe -i "%%A" !settings! "%%~nA - crf 64.mkv"
			set ffmpegLaunch=!ffmpegDir!ffmpeg.exe -i "%%A" !settings! "%%~nA - crf 64.mkv"
			SET "quoteInput=%%A"
			
			
			start /WAIT cmd /k "ffmpeg.bat" !ffmpegDir! -i %%A# -o new/the n word 27 times.mkv$ -c !settings! @
			pause
		) else (
			!ffmpegDir!ffmpeg.exe -i "%%A" !settings! "%%A"
		)
	) else (
		del codec.temp
		echo Already encoded in hevc, skipping
	)
	echo -----------------------------------------------------------------------
)

echo.
echo                All Files Encoded, press any key to exit               
echo.
echo =======================================================================
pause >nul