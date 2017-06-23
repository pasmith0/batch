@echo off

rem Colorized version of fs.bat

if "%1" == "" goto usage

rem Initialization for ColorText subroutine.
SETLOCAL EnableDelayedExpansion
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
rem Prepare a file "X" with only one dot
<nul > X set /p ".=."

rem Work is done here.
rem findstr using for/f loop
rem Tokens are stored in %i, %j, %k
for /f "tokens=1,2,3 delims=:" %%i in ('"findstr/s /i /n /a:03 /c:"%1" *.c *.cpp *.h *.java *.dep *.js *.xml *.html *.htm *.bat *.properties *.manifest *.txt *.log"') do (
   rem echo Processing line %%i%%j%%k
   set fn=%%i
   set ln=%%j
   set tx=%%k
   
   rem echo %%k
   
   rem DON'T CALL COLORTEXT WITH THE FILENAME AS
   rem A PARAMETER IT WILL DELETE THE FILE!
   rem call :ColorText 0F !fn!
   echo|set/p=!fn!:
   call :ColorText 0F "!ln!"
   echo|set/p=:
   call :ColorText 0C "!tx!"
   rem echo|set/p="!tx!"
   echo.
)

if exist X rm X

goto :eof

:ColorText
set "param=^%~2" !
set "param=!param:"=\"!"
echo on
echo param is %param%
echo off
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b

:usage 
echo Usage: fs str_to_find
:end
