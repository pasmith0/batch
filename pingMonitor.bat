
@setlocal enableextensions enabledelayedexpansion
@echo off

REM found this at http://stackoverflow.com/questions/3050898/how-to-check-if-ping-responded-or-not-in-a-batch-file

set ipaddr=%1
:loop
set state=down
for /f "tokens=5,7" %%a in ('ping -n 1 !ipaddr!') do (
    if "x%%a"=="xReceived" if "x%%b"=="x1," set state=up
)
echo.Link is !state!
ping -n 6 127.0.0.1 >nul: 2>nul:
goto :loop
endlocal