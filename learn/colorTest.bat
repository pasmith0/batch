@echo off
rem Test to print multiple colors in a batch file.
rem Uses code found here: 
rem http://stackoverflow.com/questions/4339649/how-to-have-multiple-colors-in-a-batch-file
rem 
rem Color attributes are specified by TWO hex digits -- the first
rem corresponds to the background; the second the foreground.  Each digit
rem can be any of the following values:
rem 
rem     0 = Black       8 = Gray
rem     1 = Blue        9 = Light Blue
rem     2 = Green       A = Light Green
rem     3 = Aqua        B = Light Aqua
rem     4 = Red         C = Light Red
rem     5 = Purple      D = Light Purple
rem     6 = Yellow      E = Light Yellow
rem     7 = White       F = Bright White
rem 
rem See color command for more details.
rem 
rem The code that echos strings without a newline was found at:
rem http://stackoverflow.com/questions/7105433/windows-batch-echo-without-new-line

rem Initialization for ColorText subroutine.
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

rem Initialization for write subroutine.
call :writeInitialize

rem This echos without newline.
rem The normal way to do this is set/p but 
rem it doesn't work with the bracket characters
rem call :write "Dark colors ==>>"

call :write "||"
rem call :ColorText 01 "01 Dark Blue"
rem call :ColorText 01 "01    Dk Blue"

call :write "||"
call :ColorText 02 "02 Dark Green"
call :write "||"
call :ColorText 03 "03 Dark Aqua"
call :write "||"
call :ColorText 04 "04 Dark Red"
call :write "||"
call :ColorText 05 "05 Dark Purple"
call :write "||"
call :ColorText 06 "06 Dark Yellow"
call :write "||"
call :ColorText 07 "07 Dark White"
call :write "||"
call :ColorText 08 "08 Dark Grey"
call :write "||"

echo(
call :write "Lite colors ==>>"

call :write "||"
call :ColorText 09 "09 Lite Blue"
call :write "||"
call :ColorText 0A "0A Lite Green"
call :write "||"
call :ColorText 0B "0B Lite Aqua"
call :write "||"
call :ColorText 0C "0C Lite Red"
call :write "||"
call :ColorText 0D "0D Lite Purple"
call :write "||"
call :ColorText 0E "0E Lite Yellow"
call :write "||"
call :ColorText 0F "0F Lite White"
call :write "||"

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
