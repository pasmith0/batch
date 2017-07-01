REM This doesn't work, any filenames that contain "!" will
REM not be echoed correctly.
@echo off
setlocal EnableExtensions
rem setlocal DisableDelayedExpansion
echo Doesn't work
for /r . %%j in (*.flac) do (
  echo  %%j
)

REM A kludgy way to do it.
REM Got this from http://www.computerhope.com/forum/index.php?topic=98365.0
set TMPFILE=var.tmp
echo Does work
for /r . %%k in (*.flac) do (
  echo %%k > "%TMPFILE%"
  call :setfname "%TMPFILE%"
  echo  "%fname%"
)

if EXIST %TMPFILE% del %TMPFILE%
endlocal
exit/b

:setfname
rem set the env variable fname to the string in param %1
rem echo %1
set /p fname= <%1
rem echo "%fname%"
exit/b

