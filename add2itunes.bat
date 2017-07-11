@echo off
rem  This batch file adds all the flac files in the
rem  current directory to iTunes. It does this by
rem
rem  1) convert them to wave files
rem  2) extract the tag info from the flac file
rem  3) using iTunesEncode to submit them to iTunes
rem     for encoding to m4a, using the extracted
rem     tag info.
rem 
rem  Uses the following programs:
rem  flac.exe - part of flac download
rem  metaflac.exe - part of flac download
rem  iTunesEncode.exe - available at ???
rem

setlocal EnableDelayedExpansion

set FlacProg=flac.exe
set MetaProg=metaflac.exe
set iTunesEncodeProg=%USERPROFILE%\bin\iTunesEncode\iTunesEncode.exe
rem See usage for encoder options but the ones I usually use
rem are "AAC Encoder" or "Lossless Encoder"
set ENCODER="AAC Encoder"

rem echo FlacDir = %FlacDir%
rem echo FlacProg = %FlacProg%
rem echo MetaProg = %MetaProg%

for %%j in (*.flac) do (

  set FLACFILENAME=%%~nj
  echo.
  echo *** Processing [%%j] ***
  echo.
  %FlacProg% -d -f "%%j"
  %MetaProg% --show-tag=TITLE       "%%j" > title.out
  %MetaProg% --show-tag=ARTIST      "%%j" > artist.out
  %MetaProg% --show-tag=ALBUM       "%%j" > album.out
  %MetaProg% --show-tag=GENRE       "%%j" > genre.out
  %MetaProg% --show-tag=TRACKNUMBER "%%j" > track.out
  %MetaProg% --show-tag=DATE        "%%j" > year.out
  
  set /p TITLE=  < title.out
  set /p ARTIST= < artist.out
  set /p ALBUM=  < album.out
  set /p GENRE=  < genre.out
  set /p TRACK=  < track.out
  set /p YEAR=   < year.out
  
  echo.
  echo Extracted data:
  echo.
  echo Title:   "!TITLE:~6,999!"
  echo Artist:  "!ARTIST:~7,999!"
  echo Album:   "!ALBUM:~6,999!"
  echo Genre:   "!GENRE:~6,999!"
  echo Track:   "!TRACK:~12,999!"
  echo Year:    "!YEAR:~5,999!"
  echo.
  
  %iTunesEncodeProg% ^
          -t "!TITLE:~6,999!" ^
          -l "!ALBUM:~6,999!" ^
          -a "!ARTIST:~7,999!" ^
          -g "!GENRE:~6,999!" ^
          -n "!TRACK:~12,2!" ^
          -m "!TRACK:~15,999!" ^
          -y "!YEAR:~5,999!" ^
          -i "!FLACFILENAME!.wav" ^
          -e %ENCODER%
  echo.

  rem cleanup
  if EXIST "title.out" del title.out 
  if EXIST "artist.out" del artist.out 
  if EXIST "album.out" del album.out 
  if EXIST "genre.out" del genre.out 
  if EXIST "track.out" del track.out 
  if EXIST "year.out" del year.out

  if EXIST "*.wav" del/f *.wav

)

