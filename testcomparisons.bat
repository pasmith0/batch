REM test comparisons

set LARGE=1234
set MEDIUM=56
set SMALL=8

if %LARGE% GTR %SMALL% ( 
   echo %LARGE% is GTR %SMALL%
)

if %LARGE% GTR %MEDIUM% ( 
   echo %LARGE% is GTR %MEDIUM%
) else (
   echo %LARGE% is NOT GTR %MEDIUM%
)

if %MEDIUM% GTR %LARGE% (
   echo %MEDIUM% is GTR %LARGE%
) else (
   echo %MEDIUM% is NOT GTR %LARGE%
)

if %MEDIUM% GTR %SMALL% (
   echo %MEDIUM% is GTR %SMALL%
) else (
   echo %MEDIUM% is NOT GTR %SMALL%
)


	
