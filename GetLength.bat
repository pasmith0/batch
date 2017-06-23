@echo off

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: GetLength subroutine
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
::echo _Str = %_Str%
If NOT Defined _Str Goto :EOF
Set _Str=%_Str:"=.%987654321
::echo _Str = %_Str%
:_Loop
If NOT "%_Str:~18%"=="" Set _Str=%_Str:~9% & Set /A _Len+=9 & Goto _Loop
Set _Num=%_Str:~9,1%
Set /A _Len=_Len + _Num
EndLocal & Set %2=%_Len% & Goto :EOF

