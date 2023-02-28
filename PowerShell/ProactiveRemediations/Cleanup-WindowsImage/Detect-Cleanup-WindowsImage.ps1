$LogPath = "$Env:ProgramData\Microsoft\IntuneManagementExtension\Logs"
$ScriptName = "Detect-Cleanup-WindowsImage.ps1"
$LogFile = "$LogPath\$ScriptName.log"

Start-Process -Wait cmd.exe -ArgumentList "/c DISM.exe /Online /Cleanup-Image /ScanHealth > $LogFile" -NoNewWindow

$Result = Get-Content -Path $LogFile -Tail 2

If ($Result -like "*The operation completed successfully.*" -and "*No component store corruption detected.*") {
    Write-Host "Windows image is healthy, no action required."
    Exit 0
}
else {
    Write-Host $Result
    Exit 1
}
