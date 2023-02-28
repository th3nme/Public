If (Test-Path "${Env:ProgramFiles(x86)}\Microsoft Intune Management Extension") {
    $LogPath = "$Env:ProgramData\Microsoft\IntuneManagementExtension\Logs"
}
else {
    $LogPath = $env:TEMP
}
$ScriptName = "Cleanup-WindowsImage.ps1"
$LogFile = "$LogPath\$ScriptName.log"

#$ErrorActionPreference = "Stop"

Start-Transcript $logFile

Try {
    Start-Process -Wait cmd.exe -ArgumentList "/c DISM.exe /Online /Cleanup-Image /RestoreHealth" -NoNewWindow -RedirectStandardOutput $LogPath\DISM-Output.log
    Start-Process -Wait cmd.exe -ArgumentList "/c SFC.exe /scannow" -NoNewWindow -RedirectStandardOutput $LogPath\SFC-Output.log
    Start-Process -Wait cmd.exe -ArgumentList "/c REAgentC.exe /enable" -NoNewWindow -RedirectStandardOutput $LogPath\REAgentC-Output.log
    Copy-Item -Path C:\Windows\Logs\CBS\CBS.log -Destination $LogPath -Force
    Copy-Item -Path C:\Windows\Logs\DISM\dism.log -Destination $LogPath -Force
    $Return = 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    $Return = 1
}

Stop-Transcript
Exit $Return
