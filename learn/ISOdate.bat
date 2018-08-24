@echo OFF
rem CLS
echo ISO 8601 date and time formats in Batch files.
echo The following are generated from the current system date (%date%) and time (%time%).
echo.
 
rem ISO 8601 Date and Time in extended format (YYYY-MM-DDTHH:MM:SS)
set isodt=%date:~10,4%-%date:~4,2%-%date:~7,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%
set isodt=%isodt: =0%
echo ISO 8601 Date and Time in extended format (YYYY-MM-DDTHH:MM:SS): %isodt%
 
rem ISO 8601 Date and Time in basic format (YYYYMMDDTHHMMSS)
set isodt=%date:~10,4%%date:~4,2%%date:~7,2%T%time:~0,2%%time:~3,2%%time:~6,2%
set isodt=%isodt: =0%
echo ISO 8601 Date and Time in basic format (YYYYMMDDTHHMMSS): %isodt%
 
rem ISO 8601 Date in extended format (YYYY-MM-DD)
set isodt=%date:~10,4%-%date:~4,2%-%date:~7,2%
set isodt=%isodt: =0%
echo ISO 8601 Date in extended format (YYYY-MM-DD): %isodt%
 
rem ISO 8601 Date in basic format (YYYYMMDD)
set isodt=%date:~10,4%%date:~4,2%%date:~7,2%
set isodt=%isodt: =0%
echo ISO 8601 Date in basic format (YYYYMMDD): %isodt%
 
rem ISO 8601 Time in extended format (HH:MM:SS)
set isodt=%time:~0,2%:%time:~3,2%:%time:~6,2%
set isodt=%isodt: =0%
echo ISO 8601 Time in extended format (HH:MM:SS): %isodt%
 
rem ISO 8601 Time in basic format (HHMMSS)
set isodt=%time:~0,2%%time:~3,2%%time:~6,2%
set isodt=%isodt: =0%
echo ISO 8601 Time in basic format (HHMMSS): %isodt%
 
 
rem ISO 8601 Date and Time (not including seconds) in basic format (YYYYMMDDTHHMM)
set isodt=%date:~10,4%%date:~4,2%%date:~7,2%T%time:~0,2%%time:~3,2%
set isodt=%isodt: =0%
echo ISO 8601 Date and Time (not including seconds) in basic format (YYYYMMDDTHHMM): %isodt%


