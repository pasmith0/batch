@echo off
rem Call a couple of batch files to set up our environment variables

rem This one is for Ruby native gem
rem call "C:\Program Files\Ruby DevKit-mingw64-64-4.7.2\devkitvars.bat"

rem My aliases
rem call %USERPROFILE%\bin\batch\aliases.bat

rem Ansicon for ANSI colored command prompt
rem Don't need this on Windows 10
rem "C:\Program Files\ansicon\x64\ansicon" -p

rem Set my prompt
rem PROMPT=$E[32mPaul@NEWT$S$E[33m$P$_$E[37;40m$G$S
prompt=$E[32m%username%@%computername%$S$E[33m$P$E[0m$_$G$S
rem Bright colors
rem prompt $E[92;40m%username%@%computername%$S$E[93;40m$P$_$E[37;40m$G$S
