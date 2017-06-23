@echo off
setlocal enabledelayedexpansion
setlocal enableextensions
set ipa=

set SETTOPDB=C:\bin\batch\settop\settopdb.txt

for /f "tokens=1,2 delims=," %%i in (%SETTOPDB%) do (
  rem i contains settop name, j contains ip addr
  rem Remove leading and trailing space, yes this is complicated.
  echo "%%j"
  set ipa=%%j
  echo %ipa%
  for /f "tokens=* delims= " %%a in ("%ipa%") do set ipa=%%a
  for /l %%a in (1,1,100) do if "!ipa:~-1!"==" " set ipa=!ipa:~0,-1!

  echo Disabling animations on settop %ipa% [%%i]...
  rem call settop_disable_animation.bat %ipaddr% 
)
:end
)
