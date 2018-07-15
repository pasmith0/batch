@Echo off
REM This batch file backs up files to the H: drive
REM using robocopy to mirror the files.

SETLOCAL EnableDelayedExpansion 

if [%1] == [] (
   echo Must enter destination drive letter.
   goto EOF
)

set REMOTEBACKUPDRIVE=%~1
set MYHOMEDRIVE=C:
set MYHOMEDIR=\Users\E128531
set SOURCEBACKUPDIR=%MYHOMEDRIVE%%MYHOMEDIR%
rem set REMOTEBACKUPDRIVE=H:
set REMOTEBACKUPROOTDIR=\backup\laptop
set BACKUPCMD=robocopy/MIR /R:2 /W:2
set REMOTEBACKUPDIR=%REMOTEBACKUPDRIVE%%REMOTEBACKUPROOTDIR%%MYHOMEDIR%

REM Check some prereqs before starting.
REM 
REM Check if Outlook et al are running. If these are running the backup of
REM the Outlook data file will hang because it is in use.
REM Ask user if it's OK to terminate them. If not, abort.
REM 
REM UcMapi64.exe - Microsoft Lync 2010 MAPI COM server
REM Outlook.exe  - Outlook
REM Any more?
goto skip 
tasklist /FI "IMAGENAME eq Outlook.exe" 2>NUL | find /I /N "Outlook.exe">NUL 
if "!ERRORLEVEL!" == "0" (
  choice /D N /T 10 /m "Terminate Outlook"
  echo You chose !ERRORLEVEL!
  if "!ERRORLEVEL!" == "1" (
    taskkill /F /IM Outlook.exe 
  ) else (
    echo Aborting!
    goto EOF
  )
) else (
  echo Outlook is NOT running, continuing
)

tasklist /FI "IMAGENAME eq UcMapi64.exe" 2>NUL | find /I /N "UcMapi64.exe">NUL 
if "!ERRORLEVEL!" == "0" (
  choice /D N /T 10 /m "Terminate UcMapi64"
  echo You chose !ERRORLEVEL!
  if "!ERRORLEVEL!" == "1" (
    taskkill /F /IM UcMapi64.exe 
  ) else (
    echo Aborting!
    goto EOF
  )
) else (
  echo UcMapi64 is NOT running, continuing
)

:skip

REM **********************************************
REM ** Start backup
REM **********************************************

REM Do this one directory at a time. Don't want to backup all the 
REM things in my home directory.

REM The home directory. Note this uses a different backup command (one that doesn't 
REM copy all the sub direcories.
robocopy /R:2 /W:2 "%MYHOMEDRIVE%\%MYHOMEDIR%"        "%REMOTEBACKUPDIR%"

REM Sometimes I put important stuff on the desktop
title Backing up Desktop...
%BACKUPCMD% "%MYHOMEDRIVE%\%MYHOMEDIR%\Desktop"       "%REMOTEBACKUPDIR%\Desktop"
title Backing up Downloads...
%BACKUPCMD% "%MYHOMEDRIVE%\%MYHOMEDIR%\Downloads"     "%REMOTEBACKUPDIR%\Downloads"
title Backing up Documents...
%BACKUPCMD% "%MYHOMEDRIVE%\%MYHOMEDIR%\My Documents"  "%REMOTEBACKUPDIR%\My Documents"
title Backing up Pictures... 
%BACKUPCMD% "%MYHOMEDRIVE%\%MYHOMEDIR%\My Pictures"   "%REMOTEBACKUPDIR%\My Pictures"
title Backing up Videos... 
%BACKUPCMD% "%MYHOMEDRIVE%\%MYHOMEDIR%\My Videos"     "%REMOTEBACKUPDIR%\My Videos"
title Backing up bin... 
%BACKUPCMD% "%MYHOMEDRIVE%\%MYHOMEDIR%\bin"           "%REMOTEBACKUPDIR%\bin"
REM Dev stuff - this is not ODN development code.
title Backing up dev... 
%BACKUPCMD% "%MYHOMEDRIVE%\%MYHOMEDIR%\dev"           "%REMOTEBACKUPDIR%\dev"
title Backing up devkit... 
%BACKUPCMD% "%MYHOMEDRIVE%\%MYHOMEDIR%\devkit"        "%REMOTEBACKUPDIR%\devkit"

REM Eclipse workspaces
title Backing up Eclipse workspaces...
%BACKUPCMD% "%SOURCEBACKUPDIR%\3.Dev"         "%REMOTEBACKUPDIR%\3.Dev"
%BACKUPCMD% "%SOURCEBACKUPDIR%\dumpcat"       "%REMOTEBACKUPDIR%\dumpcat"
%BACKUPCMD% "%SOURCEBACKUPDIR%\8.0"           "%REMOTEBACKUPDIR%\8.0"
%BACKUPCMD% "%SOURCEBACKUPDIR%\ChannelPlayerRefactor"  "%REMOTEBACKUPDIR%\ChannelPlayerRefactor"
%BACKUPCMD% "%SOURCEBACKUPDIR%\Trunk"         "%REMOTEBACKUPDIR%\Trunk"
%BACKUPCMD% "%SOURCEBACKUPDIR%\umptest"       "%REMOTEBACKUPDIR%\umptest"
%BACKUPCMD% "%SOURCEBACKUPDIR%\server"        "%REMOTEBACKUPDIR%\server"
%BACKUPCMD% "%SOURCEBACKUPDIR%\servertest"    "%REMOTEBACKUPDIR%\servertest"

REM Outlook files including the archive file
rem title Backing up Outlook files...
rem %BACKUPCMD% "%SOURCEBACKUPDIR%\AppData\Local\Microsoft\Outlook"  "%REMOTEBACKUPDIR%\Outlook"
rem %BACKUPCMD% "%SOURCEBACKUPDIR%\Documents\Outlook Files"  "%REMOTEBACKUPDIR%\Outlook Files"

rem title Backing up VMWare virtual machines...
rem Don't need to do this, it is done above when Documents directory is backed up.
rem %BACKUPCMD% "%SOURCEBACKUPDIR%\Documents\Virtual Machines"  "%REMOTEBACKUPROOTDIR%\VMWare"

REM Restore title to default
title Command Prompt

:EOF

