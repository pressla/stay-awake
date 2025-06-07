@echo off
echo Stopping Stay Awake script...
powershell -ExecutionPolicy Bypass -File "%~dp0stop-stay-awake.ps1"
echo.
echo If the script was running, it will terminate within 1 minute.
pause
