@echo off
setlocal enabledelayedexpansion

rem
rem This file is used to test the uptime batch file.
rem

call uptime.bat sysuptime

rem echo Uptime is: %sysuptime%

rem Uptime is returned in the following format:
rem   DAYS HOURS MINUTES SECONDS MILLISECONDS
rem Output in desired format.
set /a i=0
for %%a in (%sysuptime%) do (
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

echo %days% day(s), %hours% hour(s), %mins% minute(s), %secs% second(s)

