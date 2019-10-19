Function ConvertTo-PlainText {
<#
.SYNOPSIS
    Converts the System.Security.SecureString to plain text.
.PARAMETER SecureString
    The encrypted string to convert.
.EXAMPLE
    PS C:\> ConvertTo-PlainText -SecureString (Get-Credential).Password
.NOTES
    Author:
    Michael West
#>
    [cmdletbinding()]
    [OutputType([string])]
    param(
        [System.Security.SecureString] $SecureString
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    } #close begin block

    process {
        [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString))
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close end block

} #EndFunction ConvertTo-PlainText
