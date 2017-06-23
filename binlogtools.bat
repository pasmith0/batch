@echo off

rem echo 0=%0
rem echo 1=%1
rem echo 2=%2
rem echo all = %*

rem Make sure we have at least one parameter.

if [%1] == [] (
  echo USAGE:
  echo binlogtools 
  echo    cmd=decode 
  echo    schema=schemaFile.bls 
  echo    binlog=binaryLogFile.blg 
  echo    output=optional output file name
  echo    OPTIONAL: ignoreversion to ignore the version of the bls file.
) else (
  set binlogtools=java -jar c:\depot\OCAP\Trunk\_Tools\LoggingTools\BinlogTools.jar
  %binlogtools% %*
)

