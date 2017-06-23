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
echo "Toggling power to settop %SETTOPNUM% at addr %IPADDR%..."
curl "http://%IPADDR%/RemoteControl?116,13" -s -o temp.out 

if EXIST temp.out del temp.out

:end

