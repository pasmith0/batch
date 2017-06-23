@echo off
rem This batch file prints each directory in the path on a separate line so it
rem is easier to read.

setlocal enabledelayedexpansion

rem The simplest way to do this is to use batch variable
rem substitution to replace the path
rem separator ';' with a newline.

rem Create a variable that contains the newline character.
set LF=^& echo.
rem Put the path in a variable.
for /f "delims=" %%a in ('path') do @set mypath=%%a
rem Skip the PATH= at the beginning of the string.
set mypath=%mypath:~5%
rem Substitute the semicolons that separate the directories in the path
rem with the linefeed character.
set mypath=%mypath:;=!LF!%
rem Print it.
echo %mypath%
