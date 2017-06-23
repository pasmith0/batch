@echo off
setlocal enabledelayedexpansion
set/a i=0 
set SETTOPDB=C:\bin\batch\settop\settopdb.txt
for /f %%s in (%SETTOPDB%) do ( 
  set/a i=i+1 
  echo !i!: %%s 
)

