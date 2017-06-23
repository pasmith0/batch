@Echo off
REM This batch file backs up files to a USB flash drive
REM using robocopy to mirror the files.

SETLOCAL EnableDelayedExpansion 

set MYHOMEDIR=C:\Users\E128531
set USBDRIVEDIR=F:\work\
set BACKUPCMD=robocopy/MIR

if [%1] NEQ [] (
  set USBDRIVEDIR=%~1
)

echo Backing up to %USBDRIVEDIR%...

REM **********************************************
REM ** Start backup
REM **********************************************

REM Bin dir which has some commands I want to backup. 
title Backing up bin...
%BACKUPCMD% C:\bin  %USBDRIVEDIR%\bin

REM Dev stuff - this is not ODN development code.
title Backing up dev...
%BACKUPCMD% C:\dev  %USBDRIVEDIR%\dev

REM Sometimes I put important stuff on the desktop
rem title Backing up Desktop...
rem %BACKUPCMD%        %MYHOMEDIR%\Desktop                                   %USBDRIVEDIR%\Desktop

REM Eclipse workspaces
title Backing up Eclipse workspaces...
%BACKUPCMD%        %MYHOMEDIR%\3.Dev                                     "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\8.0                                       "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\ChannelPlayerRefactor                     "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\dumpcat                                   "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\Eclipse_Mars_JEE_workspace                "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\IpStbPlatformTest-integrated-branch       "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\TCAT                                      "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\Trunk                                     "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\Trunk.Juno                                "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\Trunk.Luna                                "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\Trunk.Mars                                "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\workspace                                 "%USBDRIVEDIR%\Eclipse workspaces"
%BACKUPCMD%        %MYHOMEDIR%\umptest                                   "%USBDRIVEDIR%\Eclipse workspaces"

REM Outlook files including the archive file
rem title Backing up Outlook files...
rem %BACKUPCMD%        %MYHOMEDIR%\AppData\Local\Microsoft\Outlook           %USBDRIVEDIR%\Outlook
rem %BACKUPCMD%        "%MYHOMEDIR%\Documents\Outlook Files"                 "%USBDRIVEDIR%\Outlook Files"

REM Other useful stuff in Documents folder.
REM Do this one directory at a time. Don't want to backup all the 
REM things in my home directory.
title Backing up Downloads...
%BACKUPCMD%        %MYHOMEDIR%\Downloads                                 %USBDRIVEDIR%\Downloads
title Backing up Documents...
%BACKUPCMD%        %MYHOMEDIR%\Documents                                 %USBDRIVEDIR%\Documents
title Backing up Pictures... 
%BACKUPCMD%        %MYHOMEDIR%\Pictures                                  %USBDRIVEDIR%\Pictures
title Backing up Videos... 
%BACKUPCMD%        %MYHOMEDIR%\Videos                                    %USBDRIVEDIR%\Videos

rem title Backing up Virtual PC virtual machines... 
rem %BACKUPCMD%        "%MYHOMEDIR%\Virtual Machines"                        "%USBDRIVEDIR%\Virtual PC"
rem %BACKUPCMD%        "%MYHOMEDIR%\AppData\Local\Microsoft\Windows Virtual PC" "%USBDRIVEDIR%\Virtual PC"

REM Restore title to default
title Command Prompt

:EOF

