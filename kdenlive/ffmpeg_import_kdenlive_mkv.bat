@echo off

@REM | This allows me to use variables in for loops when i use !variable!
SETLOCAL ENABLEDELAYEDEXPANSION

@REM if you can't save, run the ApplicationExperience service

@REM This Batch file is mostly made for my OBS clips, so it needs a few tweaks for older shadowplay clips
@REM This is supposed to export every track in an mkv file.
@REM It checks the number of streams in a file
@REM with ffprobe to determine how many tracks to export.
@REM there might be a WAY simpler way to do this, but oh well

@REM Sets the ffmpeg path (even though i never change it, it can reduce the length of each line with it)
set "ffmpeg=C:\demez_archive\video_editing\ffmpeg\current\bin\ffmpeg.exe"
set "ffprobe=C:\demez_archive\video_editing\ffmpeg\current\bin\ffprobe.exe"

echo.

@REM any default ffmpeg settings i will use everytime i run it here
set "ffmpegdefault=-v warning -c copy -y"

set "showExtraInfo=0"

@REM if a file ending in .mkv is present, then run these commands
FOR /F "delims=*" %%A IN ('dir /b *.mkv') DO (
	echo ----------------------------------------------------------
	echo %%A
	echo.
	
	set "exportdir=kdenlive\%%~nA"
	
 	if not exist "!exportdir!\" MD "!exportdir!"
	
	@REM attempt at another for loop for every audio track in the file
	@REM !ffprobe! -i "%%A" -v 0 -show_entries stream=index -of csv="p=0"
	
	@REM need to export this to a file so the for loop can read it
	@REM !ffprobe! -i "%%A" -v 0 -show_entries stream=index -of csv="p=0" >> temp.txt
	!ffprobe! -i "%%A" -v 0 -show_entries stream=codec_type,index -of csv="p=0"  > ffmpeg_import_kdenlive_mkv_TEMP
	
	FOR /F "delims=*" %%I IN (ffmpeg_import_kdenlive_mkv_TEMP) DO (
		set selectedStream=%%I
		@REM Find first character
		set findIndex=!selectedStream:~0,1!
		@REM Skip 2 characters and then extract everything else
		set findType=!selectedStream:~2!
		
		if !showExtraInfo!==1 (
			echo Index: !findIndex!
			echo Type: !findType!
		)
		
		IF !findType!==video (
			echo Exporting Video Track
			!ffmpeg! -i "%%A" !ffmpegdefault! -c copy -an "!exportdir!\V - %%A"
		)
		
		IF !findType!==audio (
			@REM change -1 to be how many lines there are containing video
			set /A audioTrack=!findIndex!-1
			echo Exporting Audio Track !audioTrack!
			@REM add a setting for the track name maybe?
			!ffmpeg! -i "%%A" !ffmpegdefault! -vn -map 0:a:!audioTrack! "!exportdir!\A!audioTrack! - %%~nA.mka"
		)
	)
	
	@REM now delete the file as its a temp file
	del ffmpeg_import_kdenlive_mkv_TEMP
	
	@REM !ffprobe! -i "%%A" -v 0 -show_entries stream=index -of csv="p=0"
	
	@REM mix stereo into mono, use for mics?
	@REM -i "%%A" -map 0 -ac:2 1 -ab 192k -filter:a "volume=0.5" -c:v copy "mono audio\%%A"
)

echo.
echo =========================================================
echo          Finished Running, press any key to quit         
echo =========================================================

pause >nul