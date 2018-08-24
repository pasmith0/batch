@echo off
rem 
rem demonstrates echoing with no newline and echoing carriage return <CR> character
rem
rem References
rem http://stackoverflow.com/questions/25773052/windows-cmd-echo-without-new-line-but-with-cr?rq=1

setlocal enableextensions enabledelayedexpansion

rem create a variable that contains just a <cr>
for /f %%a in ('copy "%~f0" nul /z') do set "CR=%%a"

set "count=0"
for %%a in (*) do (
   set /a "count+=1"
    rem One way to echo string without newline
   <nul set /p ".=working on file !count! %%~na%%~xa                                                        !CR!" 
	timeout /nobreak /t 1 >nul
)

echo.
echo Done
