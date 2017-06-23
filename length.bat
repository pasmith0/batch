@echo off
::setlocal EnableDelayedExpansion

set a=%~1
rem echo "%a%"
if "%a%" == "" (
  echo Please enter a parameter
  goto :EOF
)

set length=0

:loop1
  if "%a%" == "" (
    goto :DONE
  )
  set/a length += 1
  set a=%a:~1%
  rem echo "%a%"
goto loop1

:DONE
echo Str length is %length%

:EOF

