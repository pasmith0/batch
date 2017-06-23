@echo off

rem This batch file based on path.bat
rem Found some of the ideas found here:
rem http://stackoverflow.com/questions/141344/how-to-check-if-directory-exists-in-path#142381
rem and here:
rem http://stackoverflow.com/questions/5471556/pretty-print-windows-path-variable-how-to-split-on-in-cmd-shell/5472168#5472168
rem Also see colorTest.bat file

set tmpfile=zzyyzz.lst
setlocal enableDelayedExpansion
if exist %tmpfile% del %tmpfile%

rem Initialization for ColorText subroutine.
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
rem Initialization for write subroutine.
call :writeInitialize

rem Create file with each directory of path on a separate line
for %%a in ("%path:;=";"%") do @echo %%~a >> %tmpfile%
rem type zzyyzz

set/a i=0
for /f "tokens=*" %%b in (%tmpfile%) do (
  set/a i=i+1
  REM echo !i! %%b
  REM this is ugly but the last line in the tmp file is "ECHO is off."
  if "%%b" NEQ "ECHO is off." (
    if exist "%%b" (
      echo %%b [OK] 
	   rem call :ColorText 02 "%%b [OK]"
      rem echo.
    ) else (
      echo %%b [Directory not found]
	   rem call :ColorText 0C "%%b [Directory not found]"
      rem echo.
    )
  )
)

del %tmpfile%
goto :eof

REM BE CAREFUL WHAT YOU PASS INTO THIS SUBROUTINE,
REM IF THE 2ND PARAM IS A FILENAME IT WILL DELETE IT!
:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof

:write  Str
::
:: Write the literal string Str to stdout without a terminating
:: carriage return or line feed. Enclosing quotes are stripped.
::
:: This routine works by calling :writeVar
::
setlocal disableDelayedExpansion
set "str=%~1"
call :writeVar str
exit /b

:writeVar  StrVar
::
:: Writes the value of variable StrVar to stdout without a terminating
:: carriage return or line feed.
::
:: The routine relies on variables defined by :writeInitialize. If the
:: variables are not yet defined, then it calls :writeInitialize to
:: temporarily define them. Performance can be improved by explicitly
:: calling :writeInitialize once before the first call to :writeVar
::
if not defined %~1 exit /b
setlocal enableDelayedExpansion
if not defined $write.sub call :writeInitialize
set $write.special=1
if "!%~1:~0,1!" equ "^!" set "$write.special="
for /f delims^=^ eol^= %%A in ("!%~1:~0,1!") do (
  if "%%A" neq "=" if "!$write.problemChars:%%A=!" equ "!$write.problemChars!" set "$write.special="
)
if not defined $write.special (
  <nul set /p "=!%~1!"
  exit /b
)
>"%$write.temp%_1.txt" (echo !str!!$write.sub!)
copy "%$write.temp%_1.txt" /a "%$write.temp%_2.txt" /b >nul
type "%$write.temp%_2.txt"
del "%$write.temp%_1.txt" "%$write.temp%_2.txt"
set "str2=!str:*%$write.sub%=%$write.sub%!"
if "!str2!" neq "!str!" <nul set /p "=!str2!"
exit /b

:writeInitialize
::
:: Defines 3 variables needed by the :write and :writeVar routines
::
::   $write.temp - specifies a base path for temporary files
::
::   $write.sub  - contains the SUB character, also known as <CTRL-Z> or 0x1A
::
::   $write.problemChars - list of characters that cause problems for SET /P
::      <carriageReturn> <formFeed> <space> <tab> <0xFF> <equal> <quote>
::      Note that <lineFeed> and <equal> also causes problems, but are handled elsewhere
::
set "$write.temp=%temp%\writeTemp%random%"
copy nul "%$write.temp%.txt" /a >nul
for /f "usebackq" %%A in ("%$write.temp%.txt") do set "$write.sub=%%A"
del "%$write.temp%.txt"
for /f %%A in ('copy /z "%~f0" nul') do for /f %%B in ('cls') do (
  set "$write.problemChars=%%A%%B    ""
  REM the characters after %%B above should be <space> <tab> <0xFF>
)
exit /b

