while ($true) {
    $currentTime = Get-Date
    if ($currentTime.Hour -eq 20 -and $currentTime.Minute -eq 0) {
        # Ends MSEdge, Brave, PWSH and WSL
        Stop-Process -Name "msedge"
        Stop-Process -Name "brave"
        Stop-Process -Name "WindowsTerminal"
        wsl.exe --shutdown
        Remove-Item -Recurse -Force "$env:SystemRoot\Temp"
        Remove-Item -Recurse -Force "$env:TEMP"

        Start-Sleep -Seconds 60
    }

    elseif ($currentTime.Hour -eq 8 -and $currentTime.Minute -eq 55) {
        # Check if shortcuts exist and start them
        $pwafolderPath = "P:\DOPE\PowerShell\automatedprocessmanager\shortcuts" # Specify where PWA lnk files are
        if (Test-Path $pwafolderPath) {
            Get-ChildItem -Path $pwafolderPath -Filter "*.lnk" | ForEach-Object {
                try {
                    Start-Process $_.FullName
                } catch {
                    Write-Host "Error: $_"
                }
            }
        } else { 
            Write-Host "Folder not found: $pwafolderPath"
        }

        # Start Kali if it's available
        $kalifilepath = Get-ChildItem "$env:ProgramFiles\WindowsApps" -Recurse -Filter "kali.exe" -ErrorAction SilentlyContinue
        if ($kalifilepath) {
            Start-Process -FilePath $kalifilepath.FullName
        } else {
            Write-Host "Kali not found"
        }
        
        Start-Sleep -Seconds 60
    }

    # Checks if it's Friday (or whatever day you leave) and shuts down the workstation
    elseif ($currentTime.DayOfWeek -eq "Friday" -and $currentTime.Hour -eq 19 -and $currentTime.Minute -eq 0) {
        Restart-Computer -Force

        Start-Sleep -Seconds 60
    }

    # 30 second check for time
    Start-Sleep -Seconds 30
}
