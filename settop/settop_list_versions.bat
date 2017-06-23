@echo off

set SETTOPDB=C:\bin\batch\settop\settopdb.txt
set ERRORLEVEL=0

for /f "tokens=1,2 delims=," %%i in (%SETTOPDB%) do (
  call ping %%j  -n 1 -w 5000 > nul
  rem echo %ERRORLEVEL%
  if %ERRORLEVEL% EQU 0 (
    call echoNoNewline.bat %%j 
    call sw_version.bat %%j 
    call aloader_version.bat %%j 
    echo.
    
  ) else (
    echo Settop %%j is down
  )
)
