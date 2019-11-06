# inspired by: https://gallery.technet.microsoft.com/Execute-PowerShell-Script-38881dce

function Get-PasswordFromSecureString {

    [cmdletbinding()]
    Param (
        [parameter(Mandatory=$True)]
        [System.Security.SecureString] $SecureString
    )

    $UserName = 'domain\user'
    $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword
    $Credentials.GetNetworkCredential().Password

}
