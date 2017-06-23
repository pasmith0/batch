@echo off
REM 
REM Recursively counts files with the given file spec starting at current directory
REM

setlocal EnableDelayedExpansion

@if [%1] == [] goto usage
@set curdir=%CD%
@set MYTOTAL=0

REM do the current directory
call countfiles.bat %%1 DIRTOTAL QUIET && set/a MYTOTAL=MYTOTAL+DIRTOTAL
if [%DIRTOTAL%] NEQ [0] echo There are %DIRTOTAL% %1 files in %curdir%

REM now do the subdirectories
for /r /d %%d in (*) do (
   cd "%%d" 
   call countfiles.bat %%1 DIRTOTAL QUIET
	if [!DIRTOTAL!] NEQ [0] echo There are !DIRTOTAL! %1 files in %%d 
	cd %curdir% 
	set/a MYTOTAL=MYTOTAL+DIRTOTAL 
)

echo There are %MYTOTAL% %1 files
REM clear some variables
set curdir=
set MYTOTAL=
set DIRTOTAL=
exit/b

:usage
echo Must enter filespec, for example *.txt

