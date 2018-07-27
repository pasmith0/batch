@echo off
setlocal enableextensions 

REM up script takes the following arguments
REM    first arg is the file (default is *6761* file in directory)
REM    second arg is the server (default is HE1 server)

set he1server=10.254.112.26 
set he1user=mystro
set he1password=mystro

set tmpscript=upscript.txt
set ftplog=ftp.log

if [%1] == [] (
  echo Must enter filename
  exit/b
) else (
  set logfile=%1
)

echo Getting file %logfile%

set server=%he1server%
set user=%he1user%
set password=%he1password%

REM Make the FTP script.

echo open %server%> %tmpscript%
echo %user%>> %tmpscript%
echo %password%>> %tmpscript%
echo binary>> %tmpscript%
echo cd /usr/local/mystro/scripts/ODNscripts >> %tmpscript%
echo get %logfile%>> %tmpscript%
echo bye>> %tmpscript%

REM Turn echo on so we can see what happens during the
REM FTP session.

@echo on
ftp -s:%tmpscript% > %ftplog%
@REM echo ftp errorlevel %ERRORLEVEL%
@REM FTP doesn't seem to set errorlevel, use
@REM this hack instead
REM @find/i "File receive OK" %ftplog% >nul
@echo off

REM if  %ERRORLEVEL% GTR 0 (
REM    echo FTP error
REM ) else (
REM    echo FTP OK
REM )

rem type %ftplog%

del %tmpscript%
del %ftplog%
:done
endlocal

