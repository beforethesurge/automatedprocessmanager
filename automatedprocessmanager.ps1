while ($true) {
    $currentTime = Get-Date
    if ($currentTime.Hour -eq 19 -and $currentTime.Minute -eq 0) {
        # Ends MSEdge and WSL
        Stop-Process -Name "msedge"
        wsl.exe --shutdown
        Start-Sleep -Seconds 60
    } 
    elseif ($currentTime.Hour -eq 9 -and $currentTime.Minute -eq 0) {
        # Check if shortcuts exist and start them
        $pwafolderPath = "P:\DOPE\PowerShell\edgereboot\shortcuts" # Specify where PWA lnk files are
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

        Start-Sleep -Seconds 60
    }
    Start-Sleep -Seconds 30
}
