@echo off
REM 
REM This batch file lists the scheduled series for a settop.
REM Requires curl and awk.
REM


if [%1] == [] (
  echo Usage: get_series IP_ADDR
  exit/b
)

set AWK_PROG=c:\cygwin64\bin\gawk.exe
set IP_ADDR=%~1
set OUTPUT_FILE=series_list.txt

echo Getting series from settop %IP_ADDR%...

REM Get the series from the settop and output the html file to series.html
REM Remove the -q for debugging
curl http://%IP_ADDR%/RecordingInfo?series -o series.html

rem echo pt1
REM Parse the HTML and produce list of series 
REM   -F fs --field-separator=fs
%AWK_PROG% '{ gsub("</tr>", "\n\r"); print $0; }' series.html |  %AWK_PROG% -F "</*td>" '/<\/*t[td]>.*[A-Z][A-Z]/ {print $4 "\t" $34}' > %OUTPUT_FILE%

rem echo pt2
REM Don't need this file anymore
rem del series.html

echo %OUTPUT_FILE%

for %F in (%OUTPUT_FILE%) do (
   if %~zF equ 0 (
	   echo No series found 
	)
)


