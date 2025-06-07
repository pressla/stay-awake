# Stay Awake

A simple utility to prevent screen saver activation by simulating a Shift key press every minute.

## Files

- `stay-awake.ps1` - The main PowerShell script that simulates key presses
- `stop-stay-awake.ps1` - PowerShell script to stop the main script
- `start-stay-awake.bat` - Batch file to easily start the script in the background
- `stop-stay-awake.bat` - Batch file to easily stop the script

## Usage

### Starting the Script

1. Double-click on `start-stay-awake.bat`
2. The script will start running in the background
3. A hidden PowerShell window will be created that simulates pressing the Shift key every minute

### Stopping the Script

1. Double-click on `stop-stay-awake.bat`
2. The script will signal the background process to stop
3. The process will terminate within 1 minute

## How It Works

- The script uses Windows Forms SendKeys to simulate pressing the Shift key
- It creates a process ID file to track the running instance
- The stop script removes this file, which signals the main script to exit
- A log file (`stay-awake.log`) is created in the same directory for troubleshooting

## Notes

- This script requires PowerShell to be installed (included by default in Windows)
- You may need to run the script as an administrator if you encounter permission issues
- The script will not interfere with normal keyboard usage
