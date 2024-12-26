@echo off
REM      Batch File for blocking of all .dll and .exe files in directory through Windows Firewall
cls

:WAITKEY
choice /C YN /N /M "Press Y to proceed or press N to exit:"
IF %ERRORLEVEL%==1 (GOTO :start)
IF %ERRORLEVEL%==2 (GOTO :ESC)
GOTO :WAITKEY

:start
net session >nul 2>&1
    if %errorLevel% == 0 (
        ECHO.
    ) else (
        GOTO :NOPERM
    )

REM Use batch file's directory, else use folder's if provided via drag-and-drop
IF "%~1"=="" (
    REM
    SET "TARGET_DIR=%~dp0"
) ELSE (
    REM
    SET "TARGET_DIR=%~1"
)
SET "TARGET_DIR=%TARGET_DIR:~0,-1%"  REM Remove trailing backslash

SETLOCAL EnableDelayedExpansion

REM Automatically set rule name to the last part of the directory path (folder name)
for %%* in (%TARGET_DIR%) do set RULENAME=%%~nx*

ECHO - Add Firewall rules for all *.exe ^& *.dll files,
ECHO.
ECHO - located at '%TARGET_DIR%' (including subfolders),
ECHO - creating '%RULENAME%' as the Firewall rule name.
ECHO.
ECHO.
ECHO Press any key to continue
pause >nul
cls
Echo.

REM Block *.exe files
FOR /r "%TARGET_DIR%" %%G in ("*.exe") Do (
    @echo %%G
    NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=in program="%%G" action="block" enable="yes"
)
FOR /r "%TARGET_DIR%" %%G in ("*.exe") Do (
    @echo %%G
    NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=out program="%%G" action="block" enable="yes"
)

REM Block *.dll files
FOR /r "%TARGET_DIR%" %%G in ("*.dll") Do (
    @echo %%G
    NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=in program="%%G" action="block" enable="yes"
)
FOR /r "%TARGET_DIR%" %%G in ("*.dll") Do (
    @echo %%G
    NETSH advfirewall firewall add rule name="%RULENAME%-%%~nxG" dir=out program="%%G" action="block" enable="yes"
)

Echo.
Echo done.
GOTO :Finish

:Finish
Echo.
Echo Completed successfully wouhou
Echo.
Echo Press any button to close 
pause >nul
Goto :END

:NOPERM
ECHO.
ECHO   You must run this file in CMD as 'Administrator'
ECHO.
ECHO   Press any key to stop ...
Pause >NUL
ECHO.
ECHO   Goodbye
ECHO.
ECHO.
:END
