@echo off
REM This code shows how to put the output of a command into
REM an environment variable
setlocal EnableExtensions
setlocal EnableDelayedExpansion

if NOT [%1] == [] (
  set filespec=%~1
) else (
  set filespec=*.txt
)

echo Looking for %filespec% files in current directory ...

set/a i=0

rem echo filespec is %filespec%

for /f "tokens=*" %%a in ( 'dir/b %%filespec%%' ) do ( 
  set/a i=i+1
  set cmdout=!cmdout! [!i!] %%a 
  rem echo %%a
)

if "%cmdout%" == "" (
  echo No %filespec% files in this directory.
) else (
  echo All %filespec% files in this directory: 
  echo %cmdout%
)
endlocal 

