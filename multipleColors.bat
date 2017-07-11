@echo off
rem Print multiple colors of text on a line in a batch file.
rem Note this does not use external programs.
rem Found here: http://stackoverflow.com/questions/4339649/how-to-have-multiple-colors-in-a-batch-file/
rem 
rem See color command for color hex values.

SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
echo say the name of the colors, don't read

call :ColorText f1 " blue "
call :ColorText f2 " green "
call :ColorText f4 " red "
echo(
call :ColorText 0e " yellow "
call :ColorText f0 " black "
call :ColorText 0f " white "

goto :eof

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof