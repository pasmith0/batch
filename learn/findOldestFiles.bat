@echo off
REM This script works as follows:
REM 1) iterate through all of the folders in the same directory as this script,
REM 2) determine the 4 most recent files in each folder, and
REM 3) delete any files that are older.
REM To change the number of files kept, modify the value in the skip=4 string.
for /r /d %%a in (*) do (
    for /f "skip=4 eol=* delims=" %%b in ('dir /b /a-d /o-d "%%a\*"') do (
        echo "%%a\%%b"
    )
) 2>nul
