@echo off

REM This batch file continously polls the ODN RAM log buffer and 
REM saves it to a date/time stamped file.
REM 
REM It retrieves the binary version of the file so the log files will
REM require decoding by the BinlogTools utility.
REM 
REM Requires WinCurl
REM

if [%1] == [] (
  echo.
  echo Please enter IP address of box.
  exit/b
)

set ipaddr=%~1

REM This runs forever!

echo This script continously polls the settop at the IP address specified
echo forever.
choice /D N /T 10 /M Continue?

if  %ERRORLEVEL% NEQ 1 (
  exit/b
)


:start

REM get date in a nice format (YYYYMMDD)
set isodate=%date:~10,4%%date:~4,2%%date:~7,2%
set isodate=%isodate: =0%
 
REM get time in a nice format (HHMMSS)
set isotime=%time:~0,2%%time:~3,2%%time:~6,2%
set isotime=%isotime: =0%

echo Retrieving RAM buffer
curl --compress "http://%ipaddr%/Logging?filter=all&retrieve.from=buffer&retrieve.as=binary&retrieve=all" > 10.255.2.97-%isodate%-%isotime%.blg

REM wait a bit between polls
timeout /t 600 /nobreak >nul

goto :start

