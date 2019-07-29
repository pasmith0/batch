@echo off

setlocal

set "START_DIR=%1"
if NOT [%1] == [] (
  set START_DIR=%~1
) else (
  rem set START_DIR=%USERPROFILE%\Music\iTunes\iTunes Media
  set START_DIR=D:\Users\Paul\Music\iTunes\iTunes Media
)

echo Summary of music in %START_DIR%

rem set "START_DIR=%USERPROFILE%\Music\iTunes\iTunes Music"
rem set /a CALCTOTAL = 0
set /a MUSICTOTAL = 0

rem itlp audio files
rem These will get subtracted from the count of m4a files
rem but included in the total music files.
rem The assumption here is there will always be audio files
rem in the .itlp directories but this is not always the case.
rem Skip this check for now.
rem dir /s /b /a-d "%START_DIR%\Music\*.itlp" 2>nul | find "" /v /n /c > total.out
rem set /p ITLPAUDIOFILES= <total.out
rem set MyStr="ITLP audio files:"
rem call :PrintIt %MyStr% %ITLPAUDIOFILES%
rem del total.out

REM Calculate it now so we can subtract it from the MP4 file total.
REM It will be displayed later.
rem call findItlp ITLPAUDIOFILES "%START_DIR%"
set ITLPAUDIOFILES=0
rem ITLPAUDIOFILES is %ITLPAUDIOFILES%

echo.
echo -----------------------------------------
echo ******* MUSIC FILES *******
echo -----------------------------------------
dir /s /b /a-d "%START_DIR%\Music\*.m4a" 2>nul | find "" /v /n /c > total.out
set /p M4ATOTAL= <total.out
set /a M4ATOTAL = M4ATOTAL - ITLPAUDIOFILES
rem set /a CALCTOTAL = CALCTOTAL + M4ATOTAL
set MyStr="M4A music files:"
call :PrintIt %MyStr% %M4ATOTAL%
del total.out

rem m4p music files
dir /s /b /a-d "%START_DIR%\Music\*.m4p" 2>nul | find "" /v /n /c > total.out
set /p M4PTOTAL= <total.out
rem set /a CALCTOTAL = CALCTOTAL + M4PTOTAL
set MyStr="M4P music files:"
call :PrintIt %MyStr% %M4PTOTAL%
del total.out

rem mp3 music files
dir /s /b /a-d "%START_DIR%\Music\*.mp3" 2>nul | find "" /v /n /c > total.out
set /p MP3TOTAL= <total.out
rem set /a CALCTOTAL = CALCTOTAL + MP3TOTAL
set MyStr="MP3 music files:"
call :PrintIt %MyStr% %MP3TOTAL%
del total.out

set MyStr="Total music files:"
set /a MUSICTOTAL = M4ATOTAL + M4PTOTAL + MP3TOTAL
call :PrintIt %MyStr% %MUSICTOTAL%

rem 
echo.
echo -----------------------------------------
echo ******* NON MUSIC FILES *******
echo -----------------------------------------
dir/s/b/ad "%START_DIR%\Music\*.itlp" 2>nul | find "" /v /n /c > total.out
set /p ITLPAUDIODIR= <total.out
set MyStr="iTunes LPs:"
call :PrintIt %MyStr% %ITLPAUDIODIR%
del total.out

REM Now print the ITLP audio file total.
set MyStr="ITLP audio files:"
call :PrintIt %MyStr% %ITLPAUDIOFILES%

rem music video files
dir /s /b /a-d "%START_DIR%\Music\*.m4v" "*.mpg" 2>nul | find "" /v /n /c > total.out
set /p VIDEOTOTAL= <total.out
rem set /a CALCTOTAL = CALCTOTAL + VIDEOTOTAL
set MyStr="Music videos:"
call :PrintIt %MyStr% %VIDEOTOTAL%
del total.out

rem Skip the calculation check for now -- it doesn't work
goto skipit

rem total music and video files
dir /s /b /a-d "%START_DIR%\Music\*.m4a" "*.m4p" "*.m4v" "*.mp3" 2>nul | find "" /v /n /c > total.out
set /p DIRTOTAL= <total.out
set MyStr="Total music and video files:"
call :PrintIt %MyStr% %DIRTOTAL%
del total.out

if %CALCTOTAL% NEQ %DIRTOTAL% (
  echo WARNING! Calculated total %CALCTOTAL% 
  echo not equal to total found by dir command %DIRTOTAL%
)

:skipit

rem iTunes Extra (ite) files
rem These will get subtracted from the count of movie files
dir /s /b /a-d "%START_DIR%\Movies\*.ite" 2>nul | find "" /v /n /c > total.out
set /p ITE_MOVIE= <total.out
set MyStr="ITE movies:"
call :PrintIt %MyStr% %ITE_MOVIE%
del total.out

rem Movies
dir /s /b /a-d "%START_DIR%\Movies\*.m4v" "*.mpg" 2>nul | find "" /v /n /c > total.out
set /p MOVIETOTAL= <total.out
set /a MOVIETOTAL = MOVIETOTAL - ITE_MOVIE
set MyStr="Movies:"
call :PrintIt %MyStr% %MOVIETOTAL%
del total.out

exit /b


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutine
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:PrintIt
SetLocal
call :GetLength %1 length
rem echo String %1 is %length% characters
call :NumDigits %2 n
rem echo Numdigits is %n%
set /a NumSpaces=40-%length%-%n%
rem echo NumSpaces is %NumSpaces%
echo/|set /p=%1
call :PrintSpaces %NumSpaces% %2
rem echo/|set /p=%2
rem echo.
exit /b


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutine
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:PrintSpaces
set numspaces=%1%
set spaces="                                          "
call set space=%%spaces:~1,%numspaces%%%
echo %space% %2
rem echo/|set /p=%space%
exit /b


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutine
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:NumDigits
set numdigits=0
if %1 GTR 9999 (
  set numdigits=5
) else (
  if %1 GTR 999 (
    set numdigits=4
  ) else (
    if %1 GTR 99 (
      set numdigits=3
    ) else (
      if %1 GTR 9 (
        set numdigits=2
      ) else (
        set numdigits=1
      )
    )
  )
)

set %2=%numdigits%
rem echo NUMDIGITS is %numdigits%
exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutine
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GetLength
:: Gets the length of a passed variable
:: Arguments : "string" rvar
:: Returns   : Length of string in specified return var
:: Usage
:: Call :_GetLength "%str%" rvar
::    "%str%"    : String to find length of. Must be quoted if contains spaces
::    rvar        : Name of variable to be used to return the length
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SetLocal
Set _Len=0
Set _Str=%~1
If NOT Defined _Str Goto :EOF
Set _Str=%_Str:"=.%987654321
:_Loop
If NOT "%_Str:~18%"=="" Set _Str=%_Str:~9% & Set /A _Len+=9 & Goto _Loop
Set _Num=%_Str:~9,1%
Set /A _Len=_Len + _Num
EndLocal & Set %2=%_Len% & Goto :EOF
exit/b
