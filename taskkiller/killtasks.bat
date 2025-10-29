@ECHO OFF
:: credit to https://stackoverflow.com/a/24665214
NET file 1>NUL 2>NUL
IF NOT %errorlevel% == 0 (
    POWERSHELL Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1
    EXIT /b
)

:: Change directory with passed argument. Processes started with
:: "runas" start with forced C:\Windows\System32 workdir
CD /d %1

:: Gotta love it when you name the batch file the same name as taskkill and losing hours of your time being confused
FOR /F %%G IN (tasks.txt) DO (
	TASKKILL /IM "%%G" /F
)
PAUSE