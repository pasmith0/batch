@echo off
rem Gets ODN SW versions of all settops currently in use.

rem CISCO8300 10.255.2.181
rem CISCO8642 10.243.66.125
rem CISCO4642 10.243.67.47
rem MOTO3600  10.243.66.145
rem MOTO3510  10.243.66.163
rem WorldBox  10.243.66.42
rem SAM3272   10.243.67.119

set IPADDRS=10.255.2.181,10.243.66.125,10.243.67.47,10.243.66.145,10.243.66.163,10.243.66.42,10.243.67.119

for %%i in (%IPADDRS%) do (
   @echo %%i
   call sw_version %%i
)


