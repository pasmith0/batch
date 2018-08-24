@echo off
REM 
REM This batch file strips HTML tags from the input file.
REM and outputs the result to stdout.
REM Requires awk.
REM

if [%1] == [] (
  echo Usage: strip_html_tags FILE
  exit/b
)

set AWK_PROG=c:\cygwin64\bin\gawk.exe
%AWK_PROG% '{gsub("<[^>]*>", "")}1' "%1" 
