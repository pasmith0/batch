@echo off
@setlocal enabledelayedexpansion

if [%1] == [] (
  echo Usage: get_series IP_ADDR
  exit/b
)

set IP_ADDR=%~1
set result=0

for /l %%i in (1,1,100000) do (

  for /f "tokens=*" %%j in ('curl http://%IP_ADDR%:8092/sl/live/channelList -s -i -o noout -w "%%{http_code}" -XGET --connect-timeout 1 --header "Content-Type: application/json" --header "guid: 1234"') do (
    set result=%%j
  )
  
  echo !time! : !result!
  
  timeout /t 1 1>NUL
)

if exist noout del noout
