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
REM Script v0.3 2020-11-30 - Adding debug mode, verbose flag, minor fixes
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
REM Flags
Set FindMode=first
Set Verbose=no


REM Check for modifiers
REM ================================================================
If "%1" == "-a" GoTo ChangeFindMode
If "%1" == "-all" GoTo ChangeFindMode
If "%1" == "/a" GoTo ChangeFindMode
If "%1" == "/all" GoTo ChangeFindMode
GoTo SkipFindModeAll

:ChangeFindMode
Set FindMode=all
Shift
:SkipFindModeAll


If "%1" == "-v" GoTo ChangeVerboseMode
If "%1" == "-verbose" GoTo ChangeVerboseMode
If "%1" == "/v" GoTo ChangeVerboseMode
If "%1" == "/verbose" GoTo ChangeVerboseMode
GoTo SkipVerboseModeYes

:ChangeVerboseMode
Set Verbose=yes
Shift
:SkipVerboseModeYes
REM ================================================================



REM Cheeck if it is still missing needs an argument / executable name.
If "%~1" == "" (
    Echo Usage:		%ScriptName% ^[-a^] ^[-v^] ^<progName^>^+
	Exit /b -1
)

REM If it has more than one argument, auto sets up verbose (indented) mode
If Not "%~2" == "" Set Verbose=yes

REM DEBUG: Show flags
IF NOT "%DEBUG%" == "" ( ECHO DEBUG: FindMode = %FindMode%, VERBOSE = %Verbose%)


IF NOT "%DEBUG%" == "" ( ECHO DEBUG: ArgumentsLoop:Begin )

:BeginArgumentsLoop
If Not "%Verbose%" == "no" Echo %~1


Set MyPaths=%CD%;%PATH%
Set MyExtensions=.;%PATHEXT%

IF NOT "%DEBUG%" == "" ( ECHO DEBUG:	PathsLoop:Begin )
:BeginPathsLoop
REM Why does it work? Because ...in ("%path:;="^ "%")... converts 
REM a path like a;b;c to "a" "b" "c" and iterates over it, an item
REM per quote (it treats it as file names).
REM ...in ("%path:;=";"%")... also works.

For %%D In ("%MyPaths:;="^ "%") Do (
	REM ECHO ITERATION %%D
	REM Remove inconsisten tailing slash
	Set MyDirectory=%%~D
	If !MyDirectory:~-1!==\ Set MyDirectory=!MyDirectory:~0,-1!

	For %%E In ("%MyExtensions:;=";"%") Do (
		Set MyFile=!MyDirectory!\%~1%%~E
		Set MyAction=PrintTrueName
		
		IF NOT "%DEBUG%" == "" ( ECHO DEBUG:	Testing for file !MyFile! )
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
IF NOT "%DEBUG%" == "" ( ECHO DEBUG:	PathsLoop:End )


Shift
If Not "%~1" == "" GoTo BeginArgumentsLoop
:EndArgumentsLoop
IF NOT "%DEBUG%" == "" ( ECHO DEBUG: ArgumentsLoop:End )
GoTo eof

:PrintTrueName
REM Print path. If verbose mode is yes, results are indented, if is no, they are not.
If Not "%Verbose%" == "no" (Echo.	%~dpnx1) Else (Echo %~dpnx1)
Exit /b 0

:eof
REM ErrorLevel 0 - End of execution
Exit /b 0
