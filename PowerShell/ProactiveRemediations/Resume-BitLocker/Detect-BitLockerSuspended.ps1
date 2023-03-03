$ProtectionStatus = (Get-BitLockerVolume -MountPoint "C:").ProtectionStatus
$KeyProtector = (Get-BitLockerVolume -MountPoint "C:").KeyProtector

try {
    if ($KeyProtector -like "*TpmPin*" -And $ProtectionStatus -eq "On") {
        Write-Host "BitLocker not suspended, no action required."
        exit 0
    }
    elseif ($KeyProtector -like "*TpmPin*" -And $ProtectionStatus -eq "Off") {
        Write-Host "BitLocker is suspended, resuming BitLocker now."
        exit 1
    }
}
catch {
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    exit 1
}
