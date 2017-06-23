@echo off

rem Batch file to echo a row of dots (.) with
rem delay 

setlocal disableDelayedExpansion
call :writeInitialize
setlocal enableDelayedExpansion

set dot=.
for /l %%i in (1,1,30) do (
  call :writeVar dot
  rem sleep for a bit
  timeout /t 1 /nobreak >nul
)
echo.
echo DONE
exit /b

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
