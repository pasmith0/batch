@echo off

rem Print multiple colors of text on a line in a batch file.
rem Note this does not use external programs.
rem Found here: http://stackoverflow.com/questions/4339649/how-to-have-multiple-colors-in-a-batch-file/
rem 
rem See color command for color hex values.
rem 
rem This one handles strange characters better than the other one.

setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

rem Prepare a file "X" with only one dot
<nul > X set /p ".=."

call :color 1a "a"
call :color 03 "3"
call :color 1c "^!<>&| %%%%"*?"
exit /b

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b
