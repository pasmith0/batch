@echo off
rem doskey alias=doskey/macros
doskey alias=if ".$*." == ".." (doskey /macros) else (doskey $*)

rem doskey printcat=java -jar c:\depot\settop\atlas\tools\printCat\dist\printCat.jar $* 

rem doskey vi=vim $*
rem doskey vi="C:\Program Files (x86)\Vim\vim80\gvim" $*
rem doskey vim="C:\Program Files (x86)\Vim\vim80\gvim" $*
rem doskey gvim="C:\Program Files (x86)\Vim\vim80\gvim" $*
rem doskey edit="C:\Program Files (x86)\Notepad++\notepad++.exe" $*

set binpath=%USERPROFILE%\bin\batch
rem Pretty path
rem doskey path=%binpath%\path.bat

rem Use cygwin ls command. Cygwin bin dir must be in path.
rem doskey l=ls -alF --color 
rem This doesn't work
rem doskey l=ls -l -A -F -g -G -h --group-directories-first --time-style="+%m/%d/%Y  %I:%M %p"
rem This doesn't get set correctly
rem doskey l=dir/ogn $* | find/V "Volume in drive" | find/V "Volume Serial" | find/V "Directory of" | find/V "<DIR>          ." | find/V "<DIR>          .." | find/V "Dir(s)" | find/V "File(s)"  
doskey l=dir/ogn $*

rem Turn off prompting for date/time
doskey time=time/t 
doskey date=date/t

rem Choose which version of find to use
rem doskey find=dir/s/b $*
doskey find=%USERPROFILE%\dev\unixutils\find.exe $*

rem should have unalias command
doskey unalias=doskey $*=

rem stuff for settop commands 
doskey settop=dir/b "%binpath%\settop\*.bat"

rem dumpcat
doskey dumpcat=%USERPROFILE%\dev\dumpcat\debug\dumpcat.exe $*

rem I think the Windows where command is similar to whereis
doskey whereis=where $*
rem 
doskey which=where $*

rem Program that looks for gaps in logging. Yeah it's a stupid name.
doskey fileread=java -jar %USERPROFILE%\dev\java_exercises\fileread\fileRead.jar $* 

rem binlogtools
rem doskey binlogtools=java -jar C:\depot\OCAP\Tools\Command_2000\PCDataScripts\bin\BinlogTools.jar $* 
rem doskey binlogtools=java -jar c:\depot\OCAP\Trunk\_Tools\LoggingTools\BinlogTools.jar $*
doskey binlogtools=%binpath%\binlogtools.bat $*

rem cd commands
doskey d=cd %USERPROFILE%\Desktop
doskey odn=cd \depot\OCAP\Trunk
rem The home variable is not defined by Windows, so make
rem sure it is set or this won't work
rem Currently set to cygwin home dir, i.e., C:\cygwin64\home\E128531
rem doskey home=cd "%HOME%"
doskey godev=cd %USERPROFILE%\dev
doskey gobld=cd %OCAP_HOME%\Trunk\build
doskey goobf=cd %OCAP_HOME%\Trunk\newoutput\obfxlets
doskey goxlets=cd %OCAP_HOME%\Trunk\newoutput\xlets
doskey gorti=cd %OCAP_HOME%\Trunk\newoutput\rti\results

doskey grep=grep --binary-file=text $*
