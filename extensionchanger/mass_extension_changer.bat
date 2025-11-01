@ECHO OFF
:: Set the color codes (REF: https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797)
SET lime=[38;5;82m
SET norm=[0m

SET folderprompt=Drag / Type a folder path here: %lime%

:: Add support to drag a folder in, idiot proof it by checking if it's a file too
:retry_folder
IF "%~1" == "" (
	SET /P _folder=%folderprompt%
) ELSE (
	:: Check if this is a directory or a file (REF: https://stackoverflow.com/a/1466528)
	IF EXIST %1\* (
		SET _folder="%~1"
	) ELSE (
		:: Strip out the filename (REF: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/call)
		SET _folder="%~dp1"
	)
)

CLS
SET /P _q=%norm%<NUL

:: If it's not a valid folder, go back
CD %_folder% || GOTO retry_folder

:retry_extension
::CLS
ECHO %folderprompt%%_folder%%norm%

SET /P _t1="Extension to replace: "
SET /P _t2="Extension to use: "

:: Assume valid input
SET _e1=%_t1%
SET _e2=%_t2%

:: Check for invalid input
IF "%_t1%" == "" (
	GOTO retry_extension
)

IF "%_t2%" == "" (
	GOTO retry_extension
)

IF %_t1:~0,1% == . (
	IF "%_t1:~1%" == "" (
		GOTO retry_extension
	)
	SET _e1=%_t1:~1%
)

IF %_t2:~0,1% == . (
	IF "%_t2:~1%" == "" (
		GOTO retry_extension
	)
	SET _e2=%_t2:~1%
)

SET /P _p="Are you sure you want to replace all %lime%%_e1%%norm% with %lime%%_e2%%norm% (y/n)? "

IF %_p:~0,1% == y (
	:: Attempt rename
	CLS
	REN *.%_e1% *.%_e2% || GOTO retry_extension
	ECHO %lime%Renamed files successfully!%norm%
) ELSE (
	CLS
	GOTO retry_extension
)

PAUSE