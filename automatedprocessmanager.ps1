while ($true) {
    $currentTime = Get-Date
    if ($currentTime.Hour -eq 19 -and $currentTime.Minute -eq 0) {
        # Ends MSEdge, PWSH and WSL
        Stop-Process -Name "msedge"
        wsl.exe --shutdown
        Remove-Item -Recurse -Force "C:\Windows\Temp"

        Start-Sleep -Seconds 60
    }

    elseif ($currentTime.Hour -eq 9 -and $currentTime.Minute -eq 0) {
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
        $kalifilepath = Get-ChildItem "C:\Program Files\WindowsApps" -Recurse -Filter "kali.exe" -ErrorAction SilentlyContinue
        if ($kalifilepath) {
            Start-Process -FilePath $kalifilepath.FullName
        } else {
            Write-Host "Kali not found"
        }
        
        Start-Sleep -Seconds 60
    }

    # Checks if it's Friday (or whatever day you leave) and shuts down the workstation
    elseif ($currentTime.DayOfWeek -eq "Friday" -and $currentTime.Hour -eq 18 -and $currentTime.Minute -eq 45) {
        Stop-Computer -Force

        Start-Sleep -Seconds 60
    }

    # 30 second check for time
    Start-Sleep -Seconds 30
}
