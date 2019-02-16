@echo off
@REM | encodes all mkv's with hevc very high quality
@REM | i set this stuff up with StaxRip or IFME

setlocal enabledelayedexpansion

set "ffmpegDir=C:\demez_archive\video_editing\ffmpeg\current\bin\"

@REM temp thing for testing
set "crfLevel=14"
set "settings=-map 0 -c:a copy -c:v libx265 -preset medium -crf"
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
	
	if not !codec!==hevc (
		del codec.temp
		
		if not exist "raw\" MD "raw"
		if not exist "raw\%%A" (
			@REM move "%%A" "raw\%%A" >nul
			echo Moved to raw folder
		)
		
		echo Encoding from:		!codec! --^> hevc
		
		@REM get video duration and frames
		echo|set /p="Video Duration:		"
		!ffmpegDir!ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "%%A"
		
		@REM shows the progress of ffmpeg
		if !externalProgress!==1 (
			@REM start /WAIT cmd /c !ffmpegDir!ffmpeg.exe -i "%%A" !settings! "%%~nA - crf 64.mkv"		
			
			start /WAIT cmd /c "ffmpeg.bat" !ffmpegDir! -i %%A# -o %%~nA - crf !crfLevel!.mkv$ -c !settings! !crfLevel! @
			start /WAIT cmd /c "ffmpeg.bat" !ffmpegDir! -i %%A# -o %%~nA - crf 16.mkv$ -c !settings! 16 @
			start /WAIT cmd /c "ffmpeg.bat" !ffmpegDir! -i %%A# -o %%~nA - crf 18.mkv$ -c !settings! 18 @
			
			@REM shows the last line of ffmpeg, need to add soon
			@REM -report
			@REM this command outputs the full command line output of ffmpeg into a log
			@REM i will set up something to read it, get the last line, and show it here
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