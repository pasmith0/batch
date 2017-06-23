@echo off

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Strlength subroutine
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::StrLength
::StrLength(string,retval)
::returns the length of the string specified in %1 and stores it in %2
set substr=%~1
set length=0

:loop1
if "%substr%" == "" (
  goto :DONE
)
set /a length += 1 
set substr=%substr:~1%
::echo substr="%substr%"
goto loop1

:DONE
set "%~2=%length%"

