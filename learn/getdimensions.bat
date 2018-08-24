@echo off
REM get dimensions of jpg file
REM from http://stackoverflow.com/questions/18855048/get-image-file-dimensions-in-bat-file
REM uses tooltipinfo.bat file
setlocal enabledelayedexpansion

if [%1] == [] goto usage

set "filespec=%~1"
rem echo filespec=%filespec%
set outstr=
REM tooltipinfo returns all the info from the tooltip.
REM Extract just the dimensions.
rem for /f "delims=? tokens=2" %%a in ('tooltipinfo "%filespec%" ^| find "Dimensions:"') do set outstr=%filespec%: %%a
for /f "delims=? tokens=2" %%a in ('tooltipinfo "%filespec%" ^| find "Dimensions:"') do set outstr=%%a
echo outstr=%outstr%
if ["%outstr%"] EQU [""] (
  echo No dimensions
  exit/b
)

REM The output from the tooltip is "x_size x y_size", in other words
REM the dimensions are separated by the letter x.
REM This makes the output hard to parse.
REM 
REM This section substitutes a ":" for the "x" separating the dimensions.
REM This makes the output "x_size:y_size"
REM Much easier to parse, and since the letter x can be in 
REM a filename but the ":" cannot, it is more robust.

set target=%outstr%
set "replace= x "
set "with=:"
set target=!target:%replace%=%with%!
REM echoed output should be "filename":x_size:y_size
echo "%filespec%":%target%
exit/b

:usage
echo Usage: getdimensions filespec
echo where
echo    filespec = image file to get dimensions (jpg, png, etc)
