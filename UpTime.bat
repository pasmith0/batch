@echo off
rem
rem Returns the uptime as a string in the following format:
rem   DAYS HOURS MINUTES SECONDS MILLISECONDS
rem

rem Make sure we have a parameter to put the uptime in.
if "%1"=="" goto usage

rem setlocal enableextensions 
setlocal enabledelayedexpansion

rem Variable to be used as return
set retval=Unavailable

rem echo start uptime script
rem echo   parameter is %1

for /f "delims=" %%a in ('wmic OS Get LastBootUpTime ^| find "."') do set up=%%a
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a

set beg=%up:~0,4%-%up:~4,2%-%up:~6,2%T%up:~8,2%-%up:~10,2%-%up:~12,2%-%up:~15,3%
set end=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%T%dt:~8,2%-%dt:~10,2%-%dt:~12,2%-%dt:~15,3%


rem TimeDifference params: Return_Variable Start_Date_Time Stop_Date_Time
call :TimeDifference retval %end% %beg%

rem echo %beg%
rem echo %end%
rem echo   Uptime is: %retval%


set "%1=%retval"

rem echo   %%1 before endlocal: %1%
rem echo   retval before endlocal: %retval%
endlocal & set %1=%retval%
rem echo   %%1 after endlocal: %1%
rem echo   retval after endlocal: %retval%

rem echo %days% day(s), %hours% hour(s), %mins% minute(s), %secs% second(s)
rem Return the uptime in the first parameter
rem set %1=%uptime%
rem set %1=%uptime%
rem set %1=Hello World

rem echo end uptime script 

goto :eof

:usage
echo Need a parameter!
goto :eof

:TimeDifference Return_Variable Start_Date_Time Stop_Date_Time
:: Version -0 2009-12-25 Frank P. Westlake
:: Calculate the difference in time between parameter 2 and parameter 3
:: and return the values in the variable named by parameter 1.
::
:: Parameters 2 and 3 are ISO8601 DATE/TIMEs of the format
::
::     YYYY-MM-DDThh-mm-ss
::
:: where '-' may be any of '/:-., '.
::
:: RETURN:
:: The variable named by %1 will be set with a string containing each of
:: the following values seperated by spaces:
::
::   DAYS HOURS MINUTES SECONDS MILLISECONDS
::
:: EXAMPLE: Call :TimeDifference diff "2009-12-01T 1:00:00.00" "2009-11-30T13:00:00.01"
::          Sets variable "DIFF=0 12 0 0 10"
SetLocal EnableExtensions EnableDelayedExpansion
For /F "tokens=1-14 delims=T/:-., " %%a in ("%~2 %~3") Do (
  Set "h2=0%%d" & Set "h3=0%%k" & Set "n2=%%g00" & Set "n3=%%n00"
  Set /A "y2=%%a, m2=1%%b-100, d2=1%%c-100, h2=1!h2:~-2!-100, i2=1%%e-100, s2=1%%f-100, n2=1!n2:~0,3!-1000"
  Set /A "y3=%%h, m3=1%%i-100, d3=1%%j-100, h3=1!h3:~-2!-100, i3=1%%l-100, s3=1%%m-100, n3=1!n3:~0,3!-1000"
)
Set /A "t2=((h2*60+i2)*60+s2)*1000+n2, t3=((h3*60+i3)*60+s3)*1000+n3"
Set /A "a=(14-m2)/12, b=y2-a, j2=(153*(12*a+m2-3)+2)/5+d2+365*b+b/4-b/100+b/400"
Set /A "a=(14-m3)/12, b=y3-a, j3=(153*(12*a+m3-3)+2)/5+d3+365*b+b/4-b/100+b/400"
Set /A "d=j3-j2, t=t3-t2"
If %d% LEQ 0 (If %d% LSS 0 (Set /A "d=j2-j3, t=t2-t3") Else If %t% LSS 0 (Set /A "t=t2-t3"))
If %t% LSS 0 (Set /A "t+=(1000*60*60*24), d-=1")
Set /A "n=t %% 1000, t/=1000, s=t %% 60, t/=60, m=t %% 60, t/=60"
EndLocal & Set "%~1=%d% %t% %m% %s% %n%"
Goto :EOF
:: END SCRIPT ::::::::::::::::::::::::::::::::::::::::

