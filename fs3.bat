@echo off

rem Colorized version of fs.bat
rem Kind of slow

setlocal enableDelayedExpansion

if "%1" == "" goto usage

rem Initialization for colorPrint subroutines.
call :initColorPrint

rem Work is done here.
rem findstr using for/f loop
rem Tokens are stored in %i, %j, %k
for /f "tokens=1,2,3 delims=:" %%i in ('"findstr/s /i /n /a:03 /c:"%1" *.c *.cpp *.h *.java *.dep *.js *.xml *.html *.htm *.bat *.properties *.manifest *.txt *.log"') do (
   rem echo Processing line %%i%%j%%k
   set fn=%%i
   set ln=%%j
   set tx=%%k

   call :colorPrint 0A "!fn!"
   echo|set/p=:
   call :colorPrint 0F "!ln!"
   echo|set/p=:
   call :colorPrint 0C "!tx!"
   echo.
)

call :cleanupColorPrint
exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colorPrint Color  Str  [/n]
setlocal
set "str=%~2"
call :colorPrintVar %1 str %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined %~2 exit /b
setlocal enableDelayedExpansion
set "str=a%DEL%!%~2:\=a%DEL%\..\%DEL%%DEL%%DEL%!"
set "str=!str:/=a%DEL%/..\%DEL%%DEL%%DEL%!"
set "str=!str:"=\"!"
pushd "%temp%"
findstr /p /A:%1 "." "!str!\..\x" nul
if /i "%~3"=="/n" echo(
exit /b

:initColorPrint
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "DEL=%%a"
<nul >"%temp%\x" set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%.%DEL%"
exit /b

:cleanupColorPrint
del "%temp%\x"
exit /b

:usage 
echo Usage: fs str_to_find

