Function ConvertFrom-Base64 {
<#
.SYNOPSIS
    Convert from a Base64 string to normal string
.DESCRIPTION
    Convert from a Base64 string to normal string
.PARAMETER StringFrom
    A base64 encoded string
.NOTES
    Author:     Bill Riedy
    Version:    1.0
.EXAMPLE
    ConvertFrom-Base64 "SABlAGwAbABvAA=="

    Would return
    Hello
.OUTPUTS
    [string]
.LINK
    about_Properties
#>

#region Parameter
    [cmdletbinding()]
    Param(
        [Parameter(Position=0,Mandatory=$True,ValueFromPipeLine=$True)]
        [string] $StringFrom
    )
#endregion Parameter

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    } #close begin block

    Process {
        $bytesfrom  = [System.Convert]::FromBase64String($stringfrom);
        $decodedfrom = [System.Text.Encoding]::Unicode.GetString($bytesfrom);
        write-output $decodedfrom

    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}

Set-Alias -Name 'Base64Decode' -Value 'ConvertFrom-Base64' -Description 'Alias for ConvertFrom-Base64'
