<#
.SYNOPSIS
    Stops the stay-awake.ps1 script.
.DESCRIPTION
    This script stops the stay-awake.ps1 script by removing the process ID file,
    which signals the main script to terminate gracefully.
.NOTES
    File Name      : stop-stay-awake.ps1
    Author         : System
    Prerequisite   : PowerShell
#>

$processIdFile = Join-Path $PSScriptRoot "stay-awake-process.id"

if (Test-Path $processIdFile) {
    $processId = Get-Content -Path $processIdFile -ErrorAction SilentlyContinue
    Write-Host "Stopping Stay Awake process with ID: $processId"
    
    # Remove the process ID file to signal the main script to stop
    Remove-Item -Path $processIdFile -Force
    
    Write-Host "Stay Awake process has been signaled to stop."
    Write-Host "The process should terminate within 1 minute."
} else {
    Write-Host "No Stay Awake process appears to be running (process ID file not found)."
}
