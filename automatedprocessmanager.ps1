while ($true) {
    # Infinite loop to continuously check the time and perform actions
    $currentTime = Get-Date  # Get the current date and time
    if ($currentTime.Hour -eq 19 -and $currentTime.Minute -eq 0) {
        # Check if the current time is exactly 7:00 PM
        Stop-Process -Name "msedge"  # Close Microsoft Edge (msedge) process
        wsl.exe --shutdown  # Shut down Windows Subsystem for Linux (WSL)
        Start-Sleep -Seconds 60  # Wait for 60 seconds before continuing the loop
    } elseif ($currentTime.Hour -eq 9 -and $currentTime.Minute -eq 0) {
        # Check if the current time is exactly 9:00 AM
        $pwafolderPath = "P:\DOPE\PowerShell\edgereboot\shortcuts"  # Define the folder path where shortcuts are stored
        if (Test-Path $folderPath) {
            # Check if the folder exists
            Get-ChildItem -Path $pwafolderPath -File -Filter "*.lnk" | ForEach-Object {
                # Get all shortcut files (.lnk) in the folder and iterate over them
                try {
                    Start-Process -FilePath $_.FullName  # Attempt to start each shortcut (application)
                }
                catch {
                    Write-Host "Error starting $($_.FullName): $_"  # Handle any errors starting the shortcut and display an error message
                }
            }
        } else {
            Write-Host "Folder not found: $folderPath"  # Print a message if the folder does not exist
        }
        $wslfolderpath = "C:\Program Files\WindowsApps" # Dictates where Windows Apps are (defined as for WSL)
        if (Test-Path $wslfolderpath) {
            # Test to make sure PATH exists
            $kalifilepath = Get-ChildItem -Path $wslfolderpath -Recurse -Filter "kali.exe" -ErrorAction SilentlyContinue # Find kali.exe recursively inside $wslfolderpath
            & $kalifilepath # Execute file (should be kali.exe)
        } else {
            Write-Host "File not found: $kalifilepath"  # Print a message if the file does not exist
        }
        Start-Sleep -Seconds 60  # Wait for 60 seconds before continuing the loop
    }
    Start-Sleep -Seconds 30  # Wait for 30 seconds before checking the time again
}
