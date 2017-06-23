@echo off
REM This file counts the number of files specified by a wildcard string
REM that are in the current directory.
REM Returns the count in variable specified in param 2.
REM Both parameters are required.
REM Optionally can specify "QUIET" for third parameter
REM to disable output of echo messages.

setlocal EnableDelayedExpansion
set QUIET=0

if [%1] == [] goto usage
REM "QUIET" can be the 2nd or 3rd parameter
if [%2] == [QUIET] set QUIET=1
if [%3] == [QUIET] set QUIET=1

rem if %QUIET% == 1 echo QUIET is on

set filespec=%~1
set curdir=%CD%
set i=0

if NOT exist %filespec% goto nofiles

rem echo Looking for %filespec% files in current directory ...

for /f "tokens=*" %%a in ( 'dir/b %%filespec%%' ) do ( 
  set/a i=i+1
  rem set cmdout=!cmdout! [!i!] %%a 
  rem echo %%a
)

if %QUIET% == 0 echo There are %i% %filespec% files in %curdir%
if "%2" NEQ "" endlocal&set "%~2=%i%"
exit/b

:nofiles
if %QUIET% == 0 echo No %filespec% files found in %curdir%
if "%2" NEQ "" endlocal&set "%~2=%i%"
exit/b

:usage
echo Usage: countfiles filespec [var] [QUIET]
echo where
echo    filespec = files to count, for example *.txt
echo    var = an optional environment variable to receive the total
echo    QUIET = optional 3rd param that will turn off echo 
echo            messages
