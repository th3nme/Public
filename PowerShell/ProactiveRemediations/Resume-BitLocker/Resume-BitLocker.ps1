If (Test-Path "${Env:ProgramFiles(x86)}\Microsoft Intune Management Extension") {
    $LogPath = "$Env:ProgramData\Microsoft\IntuneManagementExtension\Logs"
}
else {
    $LogPath = $env:TEMP
}
$LogFile = "$LogPath\Resume-BitLocker.ps1.log"
#$ScriptPath = (Get-Location).path
#$ErrorActionPreference = "Stop"

Start-Transcript $LogFile

Try {
    Resume-BitLocker -MountPoint "C:"
    $Return = 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    $Return = 1
}

Stop-Transcript
Exit $Return
