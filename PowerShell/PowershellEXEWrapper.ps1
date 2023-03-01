If (Test-Path "${Env:ProgramFiles(x86)}\Microsoft Intune Management Extension") {
    $LogPath = "$Env:ProgramData\Microsoft\IntuneManagementExtension\Logs"
}
elseif (Test-Path -Path Z:\Control\CustomSettings.ini) {
    $TSEnv = New-Object -COMObject Microsoft.SMS.TSEnvironment
    $LogPath = $TSEnv.Value("LogPath")
}
else {
    $LogPath = $env:TEMP
}
$ScriptName = $MyInvocation.MyCommand.Name
$LogFile = "$LogPath\$ScriptName.log"
$ScriptPath = (Get-Location).path
#$ErrorActionPreference = "Stop"

#Enter EXE file and any arguments
$EXEFile = ""
$ArgumentList = @(
    "/verysilent"
    "/norestart"
    )

Start-Transcript $LogFile

Try {
    Start-Process "$ScriptPath\$EXEFile" -Wait -ArgumentList $ArgumentList -NoNewWindow
    #Enter any additional steps here
    $Return = 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    $Return = 1
}

Stop-Transcript
Exit $Return
