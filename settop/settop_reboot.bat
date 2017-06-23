@echo off
setlocal enabledelayedexpansion
set/a i=0 
set SETTOPDB=C:\bin\batch\settop\settopdb.txt
for /f "tokens=1,2 delims=," %%i in (%SETTOPDB%) do (
  echo Rebooting settop %%i at %%j
  curl "http://%%j/inspect?class=org.ocap.hardware.Host&method=getInstance&method=reboot" -s -o temp.html
)

