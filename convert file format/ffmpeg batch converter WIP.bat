
:input_file_format
REM inputs
echo =============================================
echo File Formats and Containers available to build:
echo 	nothing - mkv
echo 	1 - mp4
REM echo 	2 - aac
REM echo 	3 - flac
echo Or type in a format not listed here: 
echo -------------------------------------
set /p input="Input File Format: "


REM ============================================================
REM input convert to file format extension

:select_input_other
REM checks if the variable is empty
if [%input%] == [] (set inputs=.mkv & goto select_project_default
) else goto select_input_0

:select_input_1
REM this searches for the character 1 in %input%, and goes to input_1 if it finds it, else it goes to select_input_2
(echo %input% | findstr /i /c:"1" >nul) && (set input=.mp4 ) || (goto select_input_2)

:select_input_8
(echo %input% | findstr /i /c:"8" >nul) && (set grp_08=+game ) || (goto input_combine)

:input_add
echo ------------------------------
echo Enter project inputs you want
echo Make sure each input looks like this: +example
echo And space each word out

set /p grp_add=inputs: 
echo ------------------------------
goto select_input_1

:input_combine
REM combines all project values into one
call set inputs=%grp_01%%grp_02%%grp_03%%grp_04%%grp_05%%grp_06%%grp_07%%grp_08%%grp_add% 
goto select_project_default

for /F "delims=*" %%A IN ('dir /b *.mkv') DO (
	if not exist "mkv\" MD "mkv"
	"D:\demez_archive\ffmpeg\current\bin\ffmpeg.exe" -i "%%A" -map 0 -c copy  "mkv\%%~nA.mkv" )
pause