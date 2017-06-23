@echo off
REM 
REM This batch file lists the ODN sw version for a settop.
REM Requires curl and sed.
REM


if [%1] == [] (
  echo Usage: sw_version IP_ADDR
  exit/b
)

REM set AWK_PROG=c:\cygwin64\bin\gawk.exe
set IP_ADDR=%~1

REM Get the ODN diags page from the settop and output the html file to odnDiagnostics.html
curl http://%IP_ADDR%/odnDiagnostics -s -m 30 -o odnDiagnostics.html

if  %ERRORLEVEL% EQU 0 (
  grep -A1 "ODN Version" odnDiagnostics.html > version.html

  call strip_html_tags.bat version.html > version.txt
  sed 'N;/\n/s/\n//' version.txt
) else (
  echo Timeout or error getting ODN diags page 
)

if EXIST odnDiagnostics.html del odnDiagnostics.html
if EXIST version.html del version.html
if EXIST version.txt  del version.txt
