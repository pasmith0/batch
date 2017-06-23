@echo off
REM 
REM This batch file disables animation for a settop.
REM Requires curl.
REM


if [%1] == [] (
  echo Usage: disable_animation IP_ADDR
  exit/b
)

rem set AWK_PROG=c:\cygwin64\bin\gawk.exe
set IP_ADDR=%~1

REM Get the ODN diags page from the settop and output the html file to odnDiagnostics.html
curl "http://%IP_ADDR%/Animations?fadeEnabledId=false&fadeStepsId=5&fadeDelayId=33" -s -o temp.html

rem grep -A1 "ODN Version" odnDiagnostics.html > version.html

rem call strip_html_tags.bat version.html > version.txt
rem sed 'N;/\n/s/\n//' version.txt

if EXIST temp.html del temp.html
