@ECHO OFF

REM ----------------------------------------------------------------
REM which command line tool, to find the location of the executable 
REM that will run when called.
REM
REM by Rubén Martínez Cabello <ad@martinezad.es>
REM
REM Script v0.1 2018-11-29 - Initial version, tested on 
REM Windows 10, Windows 7
REM 
REM ----------------------------------------------------------------
REM EMBER, REMEM BER, THE FIFTH OF NOV EMBER! 
REM ember too that :: is NOT a proper comment, only a wasted label,
REM which can cause the parser of command.com and cmd.exe to fail 
REM sometimes.
REM
REM     "which" is a command that locates the EXECUTABLE file that 
REM would have been called by exploring the directories in the PATH.
REM This function is OS dependant, because depending of the OS used,
REM file extensions mark the files as executables (like Microsoft's
REM does in MS-DOS/Windows) or file attributes/permissions are used
REM instead (done in UNIX-variants like Linux/Android/BSD/others).
REM
REM     The equivalent in different OS are:
REM
REM 1. 'which' for GNU Unix variants: the executables are marked by
REM    an execution permission/attribute, so you need to find solely
REM    the file named exactly as specified, in any of the parts of 
REM    the PATH.
REM 
REM Documentation:
REM 
REM 
https://stackoverflow.com/questions/304319/is-there-an-equivalent-of-which-on-the-windows-command-line
REM 
https://stackoverflow.com/questions/1653472/whats-the-relative-order-with-which-windows-search-for-executable-files-in-path 
REM
REM https://en.wikipedia.org/wiki/Which_(Unix)
REM https://manpages.debian.org/stretch/debianutils/which.1.en.html
REM http://gnuwin32.sourceforge.net/packages/which.htm
REM     'which' returns the pathnames of the files (or links) which 
REM would be executed in the current environment, had it been given 
REM as commands. It does search the current directory and other PATH 
REM directories for an executable file matching the name of the 
REM argument. It does NOT canonicalize path names (resolving 
REM symlinks).
REM 
REM 2.  'where.exe' is a Windows Win32 equivalent from Windows 2003 
REM Server and succesors: Windows 95/98/Me/2000/XP does not have it
REM yet.
REM 
REM http://man7.org/linux/man-pages/man1/whereis.1.html
REM     Do not mix-up with Unix' whereis with which or where.exe.
REM
REM https://en.wikipedia.org/wiki/List_of_DOS_commands#TRUENAME
REM 3.  TRUENAME does not find the file, only translates virtual 
REM paths (subst/join) into real ones. So if you call "TRUEPATH FC",
REM from C:\USER, it will return C:\USER\FC.EXE because you can
REM execute it from the current directory due to it beingh in the 
REM PATH, instead of the expected answer of C:\DOS\FC.EXE.
REM



REM Enable Delayed Expansion for loops.
SetLocal EnableExtensions EnableDelayedExpansion
Set ScriptName=%~n0
Set FindMode=first
Set Verbose=no

REM Check for modifiers
If "%1" == "-a" GoTo ChangeFindMode
If "%1" == "-all" GoTo ChangeFindMode
If "%1" == "/a" GoTo ChangeFindMode
If "%1" == "/all" GoTo ChangeFindMode
GoTo SkipFindModeAll
:ChangeFindMode
Set FindMode=all
REM Skip modifier
Shift
:SkipFindModeAll


REM Needs an argument.
If "%~1" == "" (
    Echo Usage:		%ScriptName% ^[-a^] ^<progName^>^+
	Exit /b
)

REM Has more than one argument
If Not "%~2" == "" Set Verbose=yes
REM ECHO ArgumentsLoop:Begin
:BeginArgumentsLoop
If Not "%Verbose%" == "no" Echo %~1

Set MyPaths=%CD%;%PATH%
Set MyExtensions=.;%PATHEXT%
REM ECHO 	PathsLoop:Begin
:BeginPathsLoop
REM Why does it work? Because ...in ("%path:;="^ "%")... converts 
REM a path like a;b;c to "a" "b" "c" and iterates over it, an item
REM per quote (it treats it as file names).
REM ...in ("%path:;=";"%")... also works.

For %%D In ("%MyPaths:;="^ "%") Do (

	REM Remove inconsisten tailing slash
	Set MyDirectory=%%~D
	If !MyDirectory:~-1!==\ Set MyDirectory=!MyDirectory:~0,-1!

	For %%E In ("%MyExtensions:;=";"%") Do (

		Set MyFile=!MyDirectory!\%~1%%~E
		Set MyAction=PrintTrueName
		If Exist "!MyFile!" (
			Call :!MyAction! "!MyFile!"
			If "!FindMode!" == "first" (
					REM Ideally break a loop Here
					Set MyAction=DoNothing
				)
			)
			
		)
		
	)

)
rem Call :FindInPath "%~1"
:EndPathsLoop
REM ECHO 	PathsLoop:End
ECHO.

Shift
If Not "%~1" == "" GoTo BeginArgumentsLoop
:EndArgumentsLoop
REM ECHO ArgumentsLoop:End
ECHO.
GoTo :eof


:PrintTrueName
Echo.	%~dpnx1
Exit /b 0

:DoNothing
Exit /b 0

	

:eof
REM ErrorLevel 0
Exit /b 0
