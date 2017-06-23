@echo off
setlocal EnableExtensions
setlocal EnableDelayedExpansion

echo This batch file demonstrates the Substring, StrLength, and GetLength subroutines.
echo You may run the command with or without a parameter.

if [%1] == [] (
  set TestStr=Hello World
) else (
  set TestStr=%~1
)

echo TestStr is %TestStr%

call StrLength.bat "%TestStr%" length 
echo Length of TestStr from StrLength is %length%

call GetLength.bat "%TestStr%" length
echo Length of TestStr from GetLength is %length%

call Substring.bat "%TestStr%" substr 1 4
echo Substring(1,4) of TestStr is %substr% 

:: Done with this demo
exit/b


