@echo off

set mylist=0 1 2 3 4 5 6 
set /a i=0
 
setlocal ENABLEDELAYEDEXPANSION

for %%a in (%mylist%) do (
   set /a i=i+1
   rem echo item is %%a, loop counter is !i!
   if !i! EQU 1 (
      echo One
   ) else (
      if !i! EQU 2 (
         echo Two
      ) else (
         if !i! EQU 3 (
            echo Three
         ) else (
            if !i! EQU 4 (
               echo Four
            ) else (
               echo No case for !i!
            )
         )
      )
   )
)

endlocal
