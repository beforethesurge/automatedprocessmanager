while ($true) {
    $currentTime = Get-Date
    if ($currentTime.Hour -eq 19 -and $currentTime.Minute -eq 0) {
        # Ends MSEdge, PWSH and WSL; Clears Temp folder
        Stop-Process -Name "msedge"
        Get-Process powershell | Where-Object { $_.MainWindowTitle -eq 'NAMEOFPROGRAMWINDOW' } | Stop-Process
        wsl.exe --shutdown
        Remove-Item -Recurse -Force "C:\Windows\Temp"

        Start-Sleep -Seconds 60
    }
    elseif ($currentTime.Hour -eq 9 -and $currentTime.Minute -eq 0) {
        # Check if shortcuts exist and start them
        $pwafolderPath = "FOLDERWITHPWAS" # Specify where PWA lnk files are
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

        # Start PowerShell Terminal
        $pwshfilepath = "C:\Program Files (x86)\PowerShell\7\pwsh.exe" # Reference first if statement
        if ($pwshfilepath) { 
            Start-Process -FilePath $pwshfilepath.FullName
        } else {
            Write-Host "PWSH not found"
        }
        Start-Sleep -Seconds 60
    }
    # 30 second check for time
    Start-Sleep -Seconds 30
}
