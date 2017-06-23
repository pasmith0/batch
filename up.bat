@echo off
setlocal enableextensions 

REM up script takes the following arguments
REM    first arg is the file (default is *6761* file in directory)
REM    second arg is the server (default is HE1 server)

set defaultfile="*6761*"

REM WARNING passwords in plain text here!

REM set he1server=mas01.dev01.he01.lab.mystrotv.com
set he1server=10.254.112.26 
set he1user=mystro
set he1password=mystro

set he10server=10.254.114.86
rem set he10server=mas01.dev06.he10.lab.mystrotv.com
set he10user=mystro
rem set he10password=mys564trO
set he10password=mystro

set he4server=mas01.dev04.he08.lab.mystrotv.com
set he4user=mystro
set he4password=mystro

REM FTP script and log files
set tmpscript=upscript.txt
set ftplog=ftp.log

if [%1] == [] (
  set testfile=%defaultfile%
) else (
  set testfile=%1
)

rem echo testfile is %testfile%

if EXIST %testfile% (
  for /f "tokens=*" %%a in ('DIR/B %testfile%') do (
    set file=%%a
	 set name=%%~na
	 set ext=%%~xa
  )
) else (
  echo File %testfile% not found, you must enter a valid file name, wildcards are OK.
  goto done
)

rem echo full filename is %file%
rem echo filename only is %name%
rem echo ext is %ext%

REM Default to HE1
if [%2] == [] (
  set server=%he1server%
  set user=%he1user%
  set password=%he1password%
) else (
  if "%2" == "1" (
    set server=%he1server%
    set user=%he1user%
    set password=%he1password%
  ) else (
      if "%2" == "10" (
        set server=%he10server%
        set user=%he10user%
        set password=%he10password%
      ) else (
        if "%2" == "4" (
          set server=%he4server%
          set user=%he4user%
          set password=%he4password%
        ) else (
          echo Invalid head end, only 1, 4 and 10 are supported.
          goto done
       )
    )
  )
)

rem Warn if some files are missing

if NOT exist %name%.zip (
REM echo Missing %name%.zip file
)

if NOT exist %name%.bls (
REM echo Missing %name%.bls file
)

rem echo File is %file%
rem echo Server is %server%

REM Make the FTP script.
echo open %server%> %tmpscript%
echo %user%>> %tmpscript%
echo %password%>> %tmpscript%
echo binary>> %tmpscript%
echo cd /usr/local/mystro/clientapps/ocap>> %tmpscript%
echo put %name%.zip >> %tmpscript%
echo put %name%.bls >> %tmpscript%
echo bye>> %tmpscript%


echo Uploading %name%.zip and %name%.bls to %server%

REM Turn echo on so we can see what happens during the
REM FTP session.

@echo on
ftp -s:%tmpscript% > %ftplog%
@REM echo ftp errorlevel %ERRORLEVEL%
@REM FTP doesn't seem to set errorlevel, use
@REM this hack instead
@find/i "Transfer complete" %ftplog% >nul
@rem echo FTP status %ERRORLEVEL%
@echo off

if  %ERRORLEVEL% GTR 0 (
   echo FTP error
) else (
   echo FTP OK
)

del %tmpscript%
del %ftplog%

:done
endlocal

