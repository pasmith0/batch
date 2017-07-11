@echo off

takeown /f %1
icacls %1 /GRANT Paul:F
rem copy %1 %1.orig
