@ECHO OFF
:: Do not add spaces around the "=" sign, it will just unset the var
:: Variables are treated extremely literally %_var:~0,1% returns y not "y"

SET /P _var="Do you want some apples? "
IF %_var:~0,1% == y (
	ECHO "Have some apples! (`) (`)"
) ELSE (
	ECHO "More for me!"
)
PAUSE