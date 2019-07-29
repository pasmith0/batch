@echo off

rem setlocal EnableDelayedExpansion
rem setlocal EnableExtensions

rem this block of code gets the current directory into variable CURDIR

set CURDIR=%cd%
rem echo Current dir is %CURDIR%
popd

rem initialize variables

rem set NUMFILES=0
set TOTAL=0

rem start loop that searches for music files

for /r /d %%i in (.) do (
  rem echo full path %%~fi
  if /I "%%~fi" EQU "%CURDIR%" (
    rem echo Skipping current dir
  ) else (
    rem echo Processing directory %%~fi
    pushd "%%~fi"
    call :numMusicFiles 
    popd
  )
)
echo Total music files: %TOTAL%
goto :EOF

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutine
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:numMusicFiles 
   dir /b /a-d "*.m4a" "*.m4p" "*.mp3" 2>nul | find "" /v /n /c > total.out
   set /p NUMFILES=<total.out
   del total.out
   echo Music files in directory %cd%: %NUMFILES%
   set /a TOTAL=TOTAL+NUMFILES
   exit/b
