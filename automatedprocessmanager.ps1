while ($true) {
    $currentTime = Get-Date
    if ($currentTime.Hour -eq 19 -and $currentTime.Minute -eq 0) {
        # Ends MSEdge, PWSH and WSL
        Stop-Process -Name "msedge"
        #Stop-Process -Name "pwsh" # Keeping this off for now until I find a better way to stop only the pwsh terminal window, not the integrated one in vscode
        wsl.exe --shutdown

        Start-Sleep -Seconds 60
    } 
    elseif ($currentTime.Hour -eq 9 -and $currentTime.Minute -eq 0) {
        # Check if shortcuts exist and start them
        $pwafolderPath = "P:\DOPE\PowerShell\automatedprocessmanager\shortcuts" # Specify where PWA lnk files are
        if (Test-Path $pwafolderPath) {
            Get-ChildItem -Path $pwafolderPath -Filter "*.lnk" | ForEach-Object {
                try { Start-Process $_.FullName }
                catch { Write-Host "Error: $_" }
            }
        } else { Write-Host "Folder not found: $pwafolderPath" }

        # Start Kali if it's available
        $kalifilepath = Get-ChildItem "C:\Program Files\WindowsApps" -Recurse -Filter "kali.exe" -ErrorAction SilentlyContinue
        if ($kalifilepath) { & $kalifilepath } 
        else { Write-Host "Kali not found" }

        # Start PowerShell Terminal
        $pwshfilepath = "C:\Program Files (x86)\PowerShell\7\pwsh.exe"
        if ($pwshfilepath) { & $pwshfilepath}
        else { Write-Host "PWSH not found" }

        Start-Sleep -Seconds 60
    }
    Start-Sleep -Seconds 30
}
