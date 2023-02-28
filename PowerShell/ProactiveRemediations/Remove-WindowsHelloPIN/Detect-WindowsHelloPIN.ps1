$LastLoggedOnProviderGUID = (Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -Name LastLoggedOnProvider)."LastLoggedOnProvider"
$LastLoggedOnProvider = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\$LastLoggedOnProviderGUID" | Get-ItemProperty | Select-Object -ExpandProperty "(default)"

try {
    if (($LastLoggedOnProvider -eq "PINLogonProvider")) {
        Write-Host "PINLogonProvider detected, running PIN removal."
        exit 1
    }
    else {
        Write-Host "$LastLoggedOnProvider detected, no action required."
        exit 0
    }
}
catch {
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    exit 1
}
