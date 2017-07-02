@echo off
rem  This batch file checks that all subdirectories with 
rem  a flac file contains a reasonably large sized folder.jpg
rem  file.
rem 
rem  http://stackoverflow.com/questions/1199645/how-can-i-check-the-size-of-a-file-in-a-windows-batch-script

setlocal

set rootPath=.
if [%1] NEQ [] set rootPath=%1

rem setlocal EnableDelayedExpansion
rem setlocal

REM Loop through all subdirectories and look for one with flac files 
REM in them.

rem set FOLDERJPGSIZE=0
set ERRCOUNT=0

for /d /r %rootPath% %%n in (*) do (

   pushd "%%n"
   
   if EXIST *.flac  (
      rem echo Checking directory "%%n"
      rem call :setsize 0
      if EXIST folder.jpg (
         for %%j in (folder.jpg) do call :setsize %%~zj
         call :checksize "%%n"
         rem echo LOOP: FOLDERJPGSIZE is %FOLDERJPGSIZE%
         rem if [%FOLDERJPGSIZE%] LSS [30000]  echo WARNING: folder.jpg size %FOLDERJPGSIZE% in %%n
      ) else (
         echo WARNING: folder.jpg not found in "%%n"
         set/a ERRCOUNT=ERRCOUNT+1
      )
   )

   popd
  
)

echo Total errors: %ERRCOUNT%
goto end

REM sub setsize 
REM in: param1 = size
REM out: FOLDERJPGSIZE set to size
:setsize
rem echo setsize %~1
set "FOLDERJPGSIZE=%~1"
rem echo exit setsize, FOLDERJPGSIZE=%FOLDERJPGSIZE%
exit/b

REM sub checksize
REM in: param1 = directory being checked
REM in: FOLDERJPGSIZE variable set to size to check
REM out: echo messages
REM Comment out size check messages since we have
REM a better way now.
:checksize
rem echo checksize FOLDERJPGSIZE is %FOLDERJPGSIZE%
if %FOLDERJPGSIZE% LSS 30000 (
  rem echo WARNING: folder.jpg size %FOLDERJPGSIZE% in "%~1"
  rem set/a ERRCOUNT = ERRCOUNT+1
)
exit/b

REM cleanup
:end
