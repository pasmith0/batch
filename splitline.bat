@echo off

REM Found here:
REM http://www.computing.net/answers/programming/insert-carriage-return-w-batch/13548.html
REM 
REM OK, this slightly modified version saves the separator; 
REM I used the character @, but you can choose any other under 
REM the condition that is not a symbol typed in the text.
REM 
REM To save the output to a new file type
REM Split File_Name delimiter > File_Out

if [%1] == [] (
  echo Enter a filename and a delimiter
  exit/b
)

if [%2] == [] (
  echo Enter a filename and a delimiter
  exit/b
)

set DELIMITER=%2%

for /f "tokens=* delims=" %%a in (%*) do (
  call :SPLIT %%a
)
goto :EOF

:SPLIT
set line=%*
set line=%line:#=#@%
for /f "tokens=1,* delims=%DELIMITER%" %%a in ('echo %line%') do (%
  echo.%%a
  if not "%%b"=="" call :SPLIT %%b
)
goto :EOF

