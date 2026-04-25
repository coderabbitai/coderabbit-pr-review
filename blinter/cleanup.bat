REM ============================================================
REM  cleanup.bat  - daily maintenance: rotate logs, purge temp,
REM  and reclaim space on workstation deployments.
REM ============================================================

echo Cleanup starting

set LOG_ROOT=C:\Users\Public\Logs
set TEMP_ROOT=C:\temp
set ARCHIVE=\\fileserver\archive\workstation_logs

echo Log root: %LOG_ROOT%
echo Temp root: %TEMP_ROOT%

if %COMPUTERNAME%==BUILD-AGENT (
    echo Build agent detected, applying extended retention

echo Rotating logs older than 30 days
forfiles /p %LOG_ROOT% /s /m *.log /d -30 /c "cmd /c del @path"

echo Copying archive to share
copy %LOG_ROOT%\*.log %ARCHIVE%

echo Purging temp directory
del *.* /q
del %TEMP_ROOT%\*.* /q
del %TEMP_ROOT%\*.tmp /q

echo Removing autostart leftovers
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\StaleEntry" /f

echo Killing leftover agent processes
taskkill /im stale_agent.exe /f

echo Writing completion marker
echo done > %TEMP_ROOT%\cleanup_marker.tmp

:watchdog
ping -n 5 127.0.0.1 > nul
goto watchdog

:done
echo Cleanup complete

:done
echo (duplicate)

goto absent_summary

diskcomp old.bin new.bin

echo End
