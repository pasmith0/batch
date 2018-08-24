@echo off
rem  This batch file checks that all flac files in the current
rem  directory and it's subdirectories have a "/" in the track number 
rem  string. The "/" is the separator between the track number
rem  and the total number of tracks.
rem
rem  Uses the following programs:
rem  metaflac.exe - part of flac download
rem

setlocal EnableExtensions

set rootPath=.
if [%1] NEQ [] set rootPath=%1

set TRKTMP=track.tmp
set FILETMP=file.tmp
set MetaProg=metaflac.exe
set errors=0
set count=0

rem Create a variable that contains just a <cr>
rem got this from
setlocal EnableDelayedExpansion
for /f %%a in ('copy "%~f0" nul /z') do set "CR=%%a"
rem <nul set /p ".=Test CR... !CR!"
rem timeout /t 3 /nobreak >nul
setlocal DisableDelayedExpansion

rem Someday we'll add logging
rem if EXIST "report.log" del report.log

for /r %rootPath% %%j in (*.flac) do (

  REM Process the filenames this way instead of using delayed 
  REM expansion to handle exclamation marks in filenames.
  echo %%j > "%FILETMP%"
  call :setFilename "%FILETMP%"
  call :incCount
  
  rem setlocal EnableDelayedExpansion
  rem <nul set /p ".=Analyzing file %count% !CR!"
  call :printProcessingMsg
  rem setlocal DisableDelayedExpansion
  rem timeout /t 5 /nobreak >nul
  
  call :makeTrackFile
  call :setSize
  call :checkSize 
)

if EXIST "%TRKTMP%" del "%TRKTMP%" 
if EXIST "%FILETMP%" del "%FILETMP%"
echo Files checked: %count% Errors: %errors%
goto :FINISHED

rem   These subroutines are here to workaround
rem   issues with delayed expansion.

:incCount
  set/a count=count+1
  exit/b
  
:setFilename
  set /p FLACFILENAME=<%1
  rem echo exit setFilename, FLACFILENAME=%FLACFILENAME%
  exit/b

:setSize
  for %%k in (%TRKTMP%) do set FILESIZE=%%~zk
  rem echo exit setSize, FILESIZE=%FILESIZE%
  exit/b

REM rename me
:checkSize
  if [%FILESIZE%] EQU [0] (
    echo Missing track number for file "%FLACFILENAME%"
    set/a errors=errors+1
  ) else (
    rem echo size OK
    call :setTrackNum 
    call :checkTrackNum
  )
  exit/b
  
:setTrackNum
  set /p TRACKNUM= < %TRKTMP%
  rem echo exit setTrackNum, TRACKNUM=%TRACKNUM%
  exit/b

:makeTrackFile
  rem echo makeTrackFile: %FLACFILENAME%
  %MetaProg% --show-tag=TRACKNUMBER "%FLACFILENAME%" > %TRKTMP%
  exit/b

:checkTrackNum
  echo %TRACKNUM% |>nul find "/"
  if [%errorlevel%] EQU [0] (
	 rem echo Good track data for file %FLACFILENAME% : %TRACKNUM%
  ) else (
    echo Bad track number for file "%FLACFILENAME%" : %TRACKNUM%
    rem call :printErrorMsg %TRACK%
    set/a errors=errors+1
    rem call :incError
  )
  exit/b
  
rem :printErrorMsg 
rem if [%1] EQU [] (
rem   echo Bad or missing track data for file %FLACFILENAME%
rem ) else (
rem   echo Bad or missing track data for file %FLACFILENAME% : %1
rem )
rem exit/b

:printProcessingMsg
  setlocal EnableDelayedExpansion
  rem One way to echo string without newline
  <nul set /p ".=Analyzing file %count% !CR!"
  rem timeout /t 1 /nobreak >nul
  setlocal DisableDelayedExpansion
  exit/b

:FINISHED 
endlocal
