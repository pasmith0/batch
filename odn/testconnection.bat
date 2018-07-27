
@setlocal enableextensions enabledelayedexpansion
@echo off

REM Useful curl command:
REM curl http://10.243.66.249:8092/sl/time/zone -XGET --connect-timeout 5 --retry 36000 --retry-delay 5 --trace-time --header "guid: 1234"

if [%1] == [] (
  echo Please enter IP address
  exit/b
)

set IP_ADDR=%~1
set LOGFILE=connect_logfile.txt


:loop

set connected=0

REM curl will return something like {"timeZone":"MST+7MDT,M3.2.0/2,M11.1.0/2"}
REM if it is successful

for /f "tokens=1,2 delims=:" %%a in ('curl http://%IP_ADDR%:8092/sl/time/zone -XGET --connect-timeout 5 --trace-time --header "guid: 1234"') do (
    echo Result is %%a | tee -a %LOGFILE%
	 echo Result is %%b | tee -a %LOGFILE%
    if [%%a] EQU [{"timeZone"] (
	    set connected=1
	 )
)

echo Connect state is !connected! at %time% | tee -a logfile.txt

if !connected! EQU 1 (
	rem echo Successfully connected to Jetty at %time% tee -a %LOGFILE%
	echo Sleeping 30 seconds after successful connect | tee -a %LOGFILE%
	sleep 30
)

goto :loop


endlocal
