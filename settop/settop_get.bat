@echo off
setlocal enabledelayedexpansion

if [%1] == [] (
  goto end 
) else (
  set SETTOPNUM=%~1
)

set SETTOPDB=C:\bin\batch\settop\settopdb.txt

set/a i=0 
for /f "tokens=1,2 delims=," %%s in (%SETTOPDB%) do ( 
  set/a i=i+1 
  if !i! EQU %SETTOPNUM% (
    echo !i!: %%t
  )
)
:end

