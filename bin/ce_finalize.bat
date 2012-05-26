@echo off
REM Final step when building CodeExport component, called by CE_BLD_Build method.
REM Do not execute this script manually, it is called by CodeExport.

REM Argument list:
REM 1 - 4D application process ID  

REM Check for Argument; if not passed script was probably called manually.
IF "%1" EQU "" (GOTO CE_USAGE) ELSE (GOTO CE_START)

:CE_USAGE
echo Do not execute this script manually, it is called by CodeExport.
GOTO CE_ERROR


:CE_START
set NumPIDApp=%1
set /A numTries=1

REM Wait for 4D to quit.
:CE_DelayForQuit4D
	cls
	
	REM Let the user know what's happening, and how many times.
	echo Waiting for 4D to quit...%numTries%
	
	REM Delay for 1 second
	PING 127.0.0.1 -n 2 >NUL
	
	REM Check to see if 4D is running.
	tasklist /FI "PID eq %NumPIDApp%" | findstr "%NumPIDApp%" >NUL
	
	REM Above code returns 1 if found.
	set /A is4DRunning=%ERRORLEVEL%
	
	set /A numTries=%numTries% +1
	
	REM If 4D is still running, loop again.
IF %is4DRunning% NEQ 1 (GOTO CE_DelayForQuit4D)

echo 4D has quit!

GOTO CE_CopyFiles


:CE_CopyFiles
set component_dir=..\component\CodeExport.4dbase
set source_dir=..\matrix\CodeExport.4dbase

REM Files we need:
REM   -4DB
REM   -4DINDY

echo Copying structure file...
copy "%source_dir%\CodeExport.4DB" "%component_dir%\CodeExport.4DB"

echo Copying structure index file...
copy "%source_dir%\CodeExport.4DIndy" "%component_dir%\CodeExport.4DIndy"

echo Build complete!
pause
exit

:CE_ERROR
