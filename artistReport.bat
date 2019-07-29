
@echo off
rem
rem setlocal EnableDelayedExpansion
set /a TOTAL=0

for /d %%i in (*) do (
 cd "%%~si" 
 rem echo short filename %%~si
 set ARTIST=%%~ni
 dir /b /s /a-d "*.m4a" "*.m4p" "*.mp3" 2>nul | find "" /v /n /c > dircount.out
  if !ERRORLEVEL! GTR 0 (
    rem echo Directory [%%~ni] CONTAINS NO MUSIC FILES   
    echo Directory CONTAINS NO MUSIC FILES   
  ) else (
    set /p DIRCOUNT= < dircount.out
    set /a TOTAL = TOTAL + DIRCOUNT
    SETLOCAL ENABLEDELAYEDEXPANSION
    echo Directory [!ARTIST!] contains !DIRCOUNT! music files
    ENDLOCAL
  )
  del dircount.out 
  cd ..
)
echo total songs %TOTAL%