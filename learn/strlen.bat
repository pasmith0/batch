@echo off
setlocal EnableDelayedExpansion

set MyStr="The quick brown fox jumps over the lazy dog."
if [%1] NEQ [] set MyStr=%1
rem call :StrLength length %MyStr%
rem echo length of string %MyStr% from StrLength is %length%
call :GetLength %MyStr% length
echo length of string %MyStr% from GetLength is %length%
exit/b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutines
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: extract the suffix
rem call:Substring suffix,%fileroot%,%length%,0

:Substring
::Substring(retVal,string,startIndex,length)
:: extracts the substring from string starting at startIndex for the specified length 
 SET string=%2%
 SET startIndex=%3%
 SET length=%4%
 
 if "%4" == "0" goto :noLength
 CALL SET _substring=%%string:~%startIndex%,%length%%%
 goto :substringResult
 :noLength
 CALL SET _substring=%%string:~%startIndex%%%
 :substringResult
 set "%~1=%_substring%"
GOTO :EOF
 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutines
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:StrLength
::StrLength(retVal,string)
::returns the length of the string specified in %2 and stores it in %1
set #=%2%
set length=0
:stringLengthLoop
if defined # (
  set #=%#:~1% 
  echo str="%#%"
  set /A length += 1 
  if !length! GEQ 100 (
    GOTO PT1
  )
  goto stringLengthLoop
)
:PT1
::echo the string is %length% characters long!
set "%~1=%length%"
GOTO :EOF

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Subroutines
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
