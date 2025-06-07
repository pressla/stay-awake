<#
.SYNOPSIS
    Prevents screen saver activation by simulating a Shift key press every minute.
.DESCRIPTION
    This script uses the Windows SendKeys functionality to simulate pressing the Shift key
    every minute, preventing the screen saver from activating. It can run in the background
    and can be stopped using the stop-stay-awake.ps1 script.
.NOTES
    File Name      : stay-awake.ps1
    Author         : System
    Prerequisite   : PowerShell
#>

# Create a unique identifier for this process
$processId = [System.Guid]::NewGuid().ToString()
$processIdFile = Join-Path $PSScriptRoot "stay-awake-process.id"
$processId | Out-File -FilePath $processIdFile

# Log file for debugging
$logFile = Join-Path $PSScriptRoot "stay-awake.log"
"$(Get-Date) - Stay Awake process started with ID: $processId" | Out-File -FilePath $logFile -Append

# Create the SendKeys assembly
Add-Type -AssemblyName System.Windows.Forms

# Function to simulate key press
function Send-ShiftKey {
    [System.Windows.Forms.SendKeys]::SendWait("+")
    "$(Get-Date) - Shift key pressed" | Out-File -FilePath $logFile -Append
}

# Display startup message
Write-Host "Stay Awake script is running. Press Ctrl+C to stop or run stop-stay-awake.ps1"
Write-Host "Process ID saved to: $processIdFile"
Write-Host "Log file: $logFile"
Write-Host "Running in background..."

try {
    while ($true) {
        # Check if the process ID file still exists
        if (-not (Test-Path $processIdFile)) {
            "$(Get-Date) - Process ID file not found. Exiting." | Out-File -FilePath $logFile -Append
            break
        }
        
        # Check if the process ID in the file matches this process
        $currentId = Get-Content -Path $processIdFile -ErrorAction SilentlyContinue
        if ($currentId -ne $processId) {
            "$(Get-Date) - Process ID mismatch. Exiting." | Out-File -FilePath $logFile -Append
            break
        }
        
        # Simulate pressing the Shift key
        Send-ShiftKey
        
        # Wait for 1 minute
        Start-Sleep -Seconds 60
    }
}
finally {
    # Clean up if this is the current process
    if ((Test-Path $processIdFile) -and ((Get-Content -Path $processIdFile) -eq $processId)) {
        Remove-Item -Path $processIdFile -Force -ErrorAction SilentlyContinue
    }
    "$(Get-Date) - Stay Awake process stopped" | Out-File -FilePath $logFile -Append
}
