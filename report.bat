@echo off

setlocal EnableDelayedExpansion
setlocal EnableExtensions

rem this block of code gets the current directory into variable CURDIR

pushd %~dp0
for %%* in (.) do @echo %%~n* > dir.out
set /p CURDIR=<dir.out
del dir.out
rem echo Current dir is %CURDIR%
popd

rem initialize variables

set NUMFILES=0
set TOTAL=0
set RET=0

rem start loop that searches for music files

for /r /d %%i in (.) do (
  rem echo %%~fi
  if /I %%~ni EQU %CURDIR% (
    rem echo Skipping current dir
  ) else (
    call :HasMusicFiles RET "%%~fi"
    rem echo RET=!RET!
    if !RET! EQU 1  (
      rem echo Processing directory %%~fi
      pushd "%%~fi"
      dir /b /a-d "*.m4a" "*.m4p" "*.mp3" 2>nul | find "" /v /n /c > total.out
      set /p NUMFILES=<total.out
        if !NUMFILES! GTR 0 (
        echo Music files in directory %%~fi: !NUMFILES! 
        set /a TOTAL=TOTAL+NUMFILES
      )
      del total.out
      popd
    ) else (
      echo No music files in directory %%~fi
    )
  )
)
echo Total music files: %TOTAL%
goto :EOF

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutine
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:HasMusicFiles
rem echo HasMusicFiles enter %1 %2
set HAS=0
if EXIST "%2\*.m4a" (
  rem echo %2 has m4a
  set HAS=1
)
if EXIST "%2\*.m4p" (
  rem echo %2 has m4p
  set HAS=1
)
if EXIST "%2\*.mp3" (
  rem echo %2 has mp3
  set HAS=1
)
rem echo HAS %HAS%
set %1=%HAS%
exit/b

