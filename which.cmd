@ECHO OFF

REM ================================================================
REM
REM "which" command line tool, to find the location of an executable 
REM that will run when called.
REM
REM     by Rubén Martínez Cabello <ad@martinezad.es>
REM     https://github.com/runarorested/cmd-script
REM
REM ----------------------------------------------------------------
REM 
REM Script v0.1 2018-11-29 - Initial version
REM Script v0.2 2018-11-30 - External documentation, less comments
REM
REM Tested on Windows 10 x64, Windows 7 x64
REM 
REM ----------------------------------------------------------------
REM
REM EMBER, REMEM BER, THE FIFTH OF NOV EMBER! 
REM ember too that :: is NOT a proper comment, only a wasted label,
REM which can cause the parser of command.com and cmd.exe to fail 
REM sometimes.
REM
REM ================================================================



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
