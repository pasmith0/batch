@echo off
setlocal enabledelayedexpansion

if [%1] == [] (
  goto end 
) else (
  set SETTOPNUM=%~1
)

call settop_get %SETTOPNUM% > s.txt
set/p IPADDR= < s.txt
del s.txt
rem echo %IPADDR%
set IPADDR=!IPADDR:~3,999!
rem echo %IPADDR%
call echoNoNewline "Pinging settop %SETTOPNUM% at addr %IPADDR%..."
ping -w 2000 -n 1 %IPADDR% > nul

if %ERRORLEVEL% EQU 0 (
   echo OK
) else (
   echo Timed out
)

:end


