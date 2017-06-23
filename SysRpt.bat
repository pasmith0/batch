@echo off
rem
rem This batch file generates a report of the system's hostname, ip address, gateway and uptime.
rem It uses the netsh and wmic commands.
rem

setlocal enabledelayedexpansion
setlocal enableextensions

rem Set a variable to the current date.
for /f "delims=" %%a in ('date/t') do @set rptdate=%%a 
rem Remove leading and trailing space, yes this is complicated.
for /f "tokens=* delims= " %%a in ("%rptdate%") do set rptdate=%%a
for /l %%a in (1,1,100) do if "!rptdate:~-1!"==" " set rptdate=!rptdate:~0,-1!

rem Set a variable to the current time.
for /f "delims=" %%a in ('time/t') do @set rpttime=%%a
rem Remove leading and trailing space, yes this is complicated.
for /f "tokens=* delims= " %%a in ("%rpttime%") do set rpttime=%%a
for /l %%a in (1,1,100) do if "!rpttime:~-1!"==" " set rpttime=!rpttime:~0,-1!

rem Show header
echo.
set header=Report generated
set/p=%header% %rptdate%, %rpttime% <nul
echo.

rem This seems lame.
for /f "delims=" %%a in ('hostname') do @set myhostname=%%a
echo     Hostname:                             %myhostname%

for /f "delims=" %%a in ('netsh interface ip show address "Local Area Connection" ^| findstr/c:"IP Address"') do @set myaddr=%%a
echo %myaddr%

for /f "delims=" %%a in ('netsh interface ip show address "Local Area Connection" ^| findstr/c:"Default Gateway"') do @set mygateway=%%a
echo %mygateway%

rem This is a little lame.
rem for /f "delims=" %%a in ('wmic OS Get LastBootUpTime ^| findstr/c:"."' ) do @set myboottime=%%a
rem echo     Boot time:                %myboottime%

rem This seems lame.
rem for /f "delims=" %%a in ('systeminfo ^| findstr /c:"System Boot Time"') do @set myboottime=%%a
rem echo     %myboottime%

rem Call the uptime batch file
call uptime.bat myuptime

rem Uptime is returned in the following format:
rem   DAYS HOURS MINUTES SECONDS MILLISECONDS
rem Output in desired format.
set /a i=0
for %%a in (%myuptime%) do (
   set /a i=i+1
   rem echo !i!
   rem echo %%a
   if !i! EQU 1 (
      set days=%%a
   ) else (
      if !i! EQU 2 (
         set hours=%%a
      ) else (
         if !i! EQU 3 (
            set mins=%%a
         ) else (
            if !i! EQU 4 (
               set secs=%%a
            )
         )
      )
   )
)

echo     Uptime:                               %days% day(s), %hours% hour(s), %mins% minute(s), %secs% second(s)


