@echo off
echo Starting Stay Awake script in background...
powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0stay-awake.ps1"
echo Stay Awake script is now running in the background.
echo To stop it, run stop-stay-awake.bat
