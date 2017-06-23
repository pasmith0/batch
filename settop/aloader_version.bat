@echo off
REM 
REM This batch file lists the ODN Aloader version for a settop.
REM Requires curl and awk.
REM


if [%1] == [] (
  echo Usage: aloader_version IP_ADDR
  exit/b
)

set AWK_PROG=c:\cygwin64\bin\gawk.exe
set IP_ADDR=%~1

REM Get the ODN diags page from the settop and output the html file to odnDiagnostics.html
curl http://%IP_ADDR%/odnDiagnostics -s -o odnDiagnostics.html

grep -A1 "ALoader Version" odnDiagnostics.html > version.html

call strip_html_tags.bat version.html > version.txt
sed 'N;/\n/s/\n//' version.txt

if EXIST odnDiagnostics.html del odnDiagnostics.html
if EXIST version.html del version.html
if EXIST version.txt  del version.txt
