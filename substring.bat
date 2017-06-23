@echo off

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Substring subroutine
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Substring
::Substring(string,retVal,startIndex,length)
:: extracts the substring from string starting at startIndex for the specified length 
SET string=%1%
SET startIndex=%3%
SET length=%4%
 
if "%4" == "0" goto :noLength
CALL SET _substring=%%string:~%startIndex%,%length%%%
goto :substringResult
:noLength
CALL SET _substring=%%string:~%startIndex%%%
:substringResult
set "%~2=%_substring%"

