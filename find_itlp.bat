@echo off

rem Make sure we have the expected parameters
rem The first parameter is the variable to put the count in.
rem The second parameter is the starting directory.
if [%1] == [] goto usage
if [%2] == [] goto usage

setlocal enabledelayedexpansion

set /a dircount=0
set /a filecount=0
set /a foundm4a=0
rem set "START_DIR=C:\Users\Paul\Music\iTunes\iTunes Media"
set START_DIR="%~2"
rem echo Start dir is %START_DIR%

for /d /r %START_DIR% %%i in (*.itlp) do (
  set /a foundm4a=0
  set /a dircount=dircount+1
  rem echo %%~pi
  
  rem count the M4A files in the itlp dir and it's subdirectories
  for /f "tokens=*" %%a in ( 'dir/s/b "%%i\*.m4a" 2^<nul' ) do ( 
    set /a foundm4a=1
    set/a filecount=filecount+1
    rem echo Found m4a file in %%~pi 
  ) 
  
  if !foundm4a! EQU 0 (
    rem echo *** Not found in %%~pi
  )
  
  rem echo there are %filecount% M4A files in dir %%~pi
  
)

echo There are %filecount% M4A audio files in %dircount% ITLP directories

endlocal & set %1=%filecount%
goto :eof

:usage
echo Usage: find_itlp variable_to_put_count_in directory
  
