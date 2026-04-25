REM ============================================================
REM  build.cmd  - wrapper around msbuild for the demo project
REM ============================================================

echo Build starting

set CONFIG=Release
set OUTPUT_DIR=C:\builds\demoapp
set USER_INPUT=%1 & echo running with %1

if %CONFIG%==Release (
    set OPTIMIZE=true

echo Cleaning output directory
del %OUTPUT_DIR%\*.* /q

echo Restoring packages
nuget restore demoapp.sln
if not %ERRORLEVEL% 0 goto build_failed

echo Compiling
msbuild demoapp.sln /p:Configuration=%CONFIG%
if not %ERRORLEVEL% 0 goto build_failed

echo Running legacy validation
wmic product where "name='DemoApp'" get version
cacls %OUTPUT_DIR% /e /g everyone:f

echo Packaging
copy build\demoapp.exe %OUTPUT_DIR%\demoapp.exe
copy %0 %OUTPUT_DIR%\last_build_command.cmd

:retry
echo Attempting upload
goto retry

:build_failed
echo Build failed
goto exit_handler

echo Should not reach here
