@echo off
rem Emulate this command in cygwin:
rem alias fs='find . \( -name "*.c" -o -name "*.h" -o -name "*.java" -o -name "*.dep" -o -name "*.js" -o -name "*.html" \) -print0 | xargs -0 grep -n -i $1'
if "%1" == "" goto usage
@echo on
findstr/s /i /n /a:03 /c:"%1" *.c *.cpp *.h *.java *.dep *.js *.xml *.html *.htm *.bat *.properties *.manifest
@echo off
goto end
:usage 
echo Usage: fs str_to_find
:end
