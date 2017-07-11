@echo off
REM Checks the dimensions of all folder.jpg files in all subdirectories.
REM If the file's dimensions are less than 800 x 800, it writes
REM an error message to stdout.
REM
REM Uses the getdimensions.bat file which uses the tooltipinfo.bat file.
REM
REM This batch file runs slowly!
REM
REM It only writes output if there is an error so it may not look 
REM like anything is happening. NOT TRUE ANYMORE. 
REM
REM When complete, it writes a summary output of the number 
REM of files checked and the number of errors.
REM
REM It also is hard to cancel and currently requires multiple
REM control-C keystrokes.

setlocal EnableExtensions
setlocal EnableDelayedExpansion

set rootPath=.
if [%1] NEQ [] set rootPath=%1
set MINDIM=800
rem echo %rootPath%

set/a errors=0
set/a count=0
set prevpath=
set truncpath=

rem create a variable that contains just a <cr>
for /f %%a in ('copy "%~f0" nul /z') do set "CR=%%a"

for /r %rootPath% %%f in (*.jpg) do ( 
  
  REM this lets us echo the dire
  REM otherwise we can just 
  if ["%%~nf%%~xf"] NEQ ["folder.jpg"] (
    rem only echo path if it changes
    if ["%%~pf"] NEQ ["!prevpath!"] (
	   rem echo "%%~pf" "!prevpath!"
		rem timeout /t 1 /nobreak >nul
		set truncpath=%%~pf
		set truncpath=!truncpath:~0,100!
	   call :clearline
      rem One way to echo string without newline
      <nul set /p ".=Working on dir !truncpath! !CR!"
		set prevpath=%%~pf
    )
  ) else (
    for /f "tokens=2,3,4 delims=:" %%i in ( 'call getdimensions.bat "%%f"' ) do (
    set FILENAME=%%i
    REM remove quotes - the filename is surrounded by quotes by the getdimensions.bat file
    set FILENAME=!FILENAME:"=!
    REM set XSIZE=%%j
    REM set YSIZE=%%k
    REM echo FILENAME is "!FILENAME!"
    rem echo %%i %%j %%k
      
    REM skip if any are empty
    if [%%i] EQU [] (
       REM do nothing
    ) else if [%%j] EQU [] (
       REM do nothing
    ) else if [%%k] EQU [] (
       REM do nothing
    ) else (
      
      REM Remove leading and trailing space, yes this is complicated.
      for /f "tokens=* delims= " %%a in ("%%j") do set xsize=%%a
      rem echo xsize1="!xsize!"
      for /l %%a in (1,1,100) do if "!xsize:~-1!"==" " set xsize=!xsize:~0,-1!
      rem echo xsize2="!xsize!"

      REM Remove leading and trailing space, yes this is complicated.
      for /f "tokens=* delims= " %%a in ("%%k") do set ysize=%%a
      rem echo ysize="!ysize!"
      for /l %%a in (1,1,100) do if "!ysize:~-1!"==" " set ysize=!ysize:~0,-1!
      rem echo ysize="!ysize!"
      
      REM echo File: !FILENAME! X: !xsize! Y: !ysize!
      set/a count=count+1
      rem One way to echo string without newline
      <nul set /p ".=Working on file !count! !CR!"
      
      if !xsize! LSS %MINDIM% (
		  call :clearline
        echo FILE TOO SMALL: !FILENAME! is !xsize! x !ysize!
        set/a errors=errors+1
      ) else (
        if !ysize! LSS %MINDIM% (
		    call :clearline
          echo FILE TOO SMALL: !FILENAME! is !xsize! x !ysize!
          set/a errors=errors+1
        ) else (
          REM echo FILE OK: !FILENAME!
        )
      )
    )
  )
  )
)

call :clearline
echo Files checked: %count% Errors: %errors%

exit/b

:clearline
rem                     1         2         3         4         5         6         7         8         9         0         1         2         3         4         5
rem            123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
<nul set /p ".=.                                                                                                            .!CR!"
exit/b

:usage
echo Usage: check_dimensions pathspec
echo where
echo    pathspec = directory to start search for image files (jpg, png, etc)
