@echo off

rem  This batch file checks all subdirectories with 
rem  a flac file contain an image that is the same as 
rem  the folder.jpg in the directory.
rem  It also verifies the size of the folder.jpg
rem  is the minimum size.
rem 
rem  The following errors can be printed:
rem 
rem      ERROR01 A directory with a flac file is missing a folder.jpg file.
rem      ERROR02 A flac file is missing cover art.
rem      ERROR03 The folder file dimensions are too small.
rem      ERROR04 Flac file cover art dimensions are not equal to the folder.jpg file dimensions.
rem      ERROR05 The flac file cover art dimensions are too small.

setlocal

set rootPath=.
if [%1] NEQ [] set rootPath=%1

set MINDIM=800
set ERRCOUNT=0
set TOTALFILES=0
set TOTALDIRS=0


REM Loop through all subdirectories and look for one with flac files in it.

for /d /r %rootPath% %%i in (*) do (
   
   pushd "%%i"
   
   if EXIST *.flac  (
	   call :setCurrentDir %%i
      echo Checking directory %%i
      call :incrementDirCount
		
      if EXIST folder.jpg (
         for /f "tokens=2,3 delims=:" %%x in ( 'call getdimensions.bat "folder.jpg"' ) do (
           call :setsize %%x %%y
			  call :checkfoldersize
         )
         REM echo xsize=%xsize% ysize=%ysize%
         REM call :echosize

         REM loop through all the flac files
			call :checkFlacFiles
         
      ) else (
         call :incrementErrorCount
         rem echo    ERROR01: %%i folder.jpg not found, not checking any flac files in this directory
         echo    ERROR01: %%i folder.jpg not found
			
			REM Go ahead and check the size of the cover art in the flac files
			REM Set the size to zero so flac cover art size isn't compared to the nonexistent folder size.
         call :setsize 0 0
         REM loop through all the flac files
			call :checkFlacFiles
      )
   )

   popd
  
)

echo Directories checked: %TOTALDIRS%  Files checked: %TOTALFILES%  Errors: %ERRCOUNT%
goto end

REM   These subroutines exist to workaround issues with delayed expansion.
REM   variables available in these subroutines:
REM         folderxsize, folderysize
REM         flacfilename
REM         xsize, ysize
REM         ERRCOUNT
REM         TOTALFILES
REM         TOTALDIRS
REM         CURRENTDIR

:setCurrentDir
  set CURRENTDIR= %1
  exit/b

:setsize
  rem echo setsize %~1 %~2
  set "folderxsize=%~1"
  set "folderysize=%~2"
  exit/b

:echosize
  echo echosize, xsize=%xsize% ysize=%ysize%
  exit/b
  
:setflacfilename
  set "flacfilename=%~1"
  exit/b

:echoflacfilename
  echo echoflacfilename, flacfilename=%flacfilename%
  exit/b

:checkfoldersize
  if %folderxsize% LSS %MINDIM% (
	 call :incrementErrorCount
    echo    ERROR03: %CURRENTDIR% folder artwork too small: %folderxsize% x %folderxsize%
  ) else if %folderysize% LSS %MINDIM% (
	 call :incrementErrorCount
    echo    ERROR03: %CURRENTDIR% folder artwork too small: %folderxsize% x %folderxsize%
  )
  exit/b

:checksize
  REM echo ------------------
  REM echo MINDIM=%MINDIM%
  REM echo CURRENTDIR="%CURRENTDIR%"
  REM echo folderxsize=%folderxsize%
  REM echo folderysize=%folderysize%
  REM echo flacdimx=%1
  REM echo flacdimy=%2
  REM echo flacfilename="%flacfilename%"
  REM echo ------------------
  if %folderxsize% EQU 0 (
     goto skipcheck
  )
  if %folderysize% EQU 0 (
     goto skipcheck
  )
  
  if %folderxsize% NEQ %1 (
    call :incrementErrorCount
    echo    ERROR04: "%flacfilename%" cover art not same size as folder: %folderxsize% x %folderysize% Flac: %1 x %2
  ) else if %folderysize% NEQ %2 (
    call :incrementErrorCount
    echo    ERROR04: "%flacfilename%" cover art not same size as folder: %folderxsize% x %folderysize% Flac: %1 x %2
  ) else (
    rem echo    SUCCESS: File "%flacfilename%" is good %1 x %2
  )
  
:skipcheck  
  call :checkMinimumSize %1 %2
  exit/b

:checkMinimumSize
  rem Check for minimum size
  if %1 LSS %MINDIM% (
	 call :incrementErrorCount
    echo    ERROR05: "%flacfilename%" flac file artwork too small: %1 x %2
  ) else if %1 LSS %MINDIM% (
	 call :incrementErrorCount
    echo    ERROR05: "%flacfilename%" flac file artwork too small: %1 x %2
  )
  exit/b

:incrementErrorCount
  set/a ERRCOUNT=ERRCOUNT+1
  exit/b
  
:echoErrorCount
  echo ERRCOUNT=%ERRCOUNT%
  exit/b
  
:incrementFileCount
  set/a TOTALFILES=TOTALFILES+1
  exit/b
  
:incrementDirCount
  set/a TOTALDIRS=TOTALDIRS+1
  exit/b
  
:printMissingCoverArtError
  echo    ERROR: File %~1 missing cover art
  exit/b

:checkFlacFiles
  for %%k in (*.flac) do (
    REM echo flac file %%k
    call :incrementFileCount
    call :setflacfilename "%%k"
    REM call :echoflacfilename
    REM Extract image from flac file
    REM echo Getting picture for file %%k
    REM metaflac --export-picture-to="%%~nk.jpg" "%%k" 2>nul
    metaflac --export-picture-to="tmp.jpg" "%%k" 2>nul
    REM echo %errorlevel%
       
    if NOT EXIST "tmp.jpg" (
      call :incrementErrorCount
      echo    ERROR02: %%k file missing cover art
          
    ) else (
      REM echo SUCCESS: getting image file from file %%k
      for /f "tokens=2,3 delims=:" %%a in ( 'call getdimensions.bat "tmp.jpg"' ) do (
        REM a=x size
        REM b=y size
        REM echo x=%%a yg=%%b
		  call :checksize %%a %%b
      )
		del "tmp.jpg"
    )
	 REM call :echoErrorCount
  )
  exit/b

REM cleanup
:end
endlocal
