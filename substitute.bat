@echo off
setlocal enabledelayedexpansion

rem This file shows how to do string substitution in batch file variables.
rem Takes three parameters
rem param 1 - Target string 
rem param 2 - String to be replaced
rem param 3 - String to replace it with

if [%1] == [] (
  goto :Usage
) else (
  set target=%~1
)

if [%2] == [] (
  goto :Usage
) else (
  set replace=%~2
)

if [%3] == [] (
  goto :Usage
) else (
  set with=%~3
)

rem set str=The fat cat
rem set str=%target%
rem set f=%replace%
rem set subst=%with%

rem echo.
rem echo          f = [%f%]

rem echo.
rem echo        str = [%str%]

rem echo.
rem echo        subst = [%subst%]

echo.
echo Substituting "%with%" for "%replace%" in the string "%target%"

set target=!target:%replace%=%with%!

echo.
echo New string: "%target%"

goto :EOF

:Usage

echo This file shows how to do string substitution in batch file variables.
echo Takes three parameters:
echo   param 1 - Target string 
echo   param 2 - String to be replaced
echo   param 3 - String to replace it with

:EOF

