@echo off
REM
REM This file decodes the ODN buffer and disk log files
REM Must enter the path to the bls file.
REM

if [%1] == [] (
  echo Must enter the path to the bls file
  exit/b
)

REM set binlogTools=java -jar C:\depot\OCAP\Tools\Command_2000\PCDataScripts\bin\BinlogTools.jar

REM Using ignoreversion to ignore the version of the bls file.

for %%i in (*.blg) do (
  java -jar BinlogTools.jar cmd=decode binlog=%%i schema=%1 outfile=%%~ni.txt
)

REM @echo.
REM @echo Output is in OdnLog.txt and DiskLog.txt
