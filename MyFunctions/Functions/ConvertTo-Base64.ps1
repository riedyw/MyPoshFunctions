Function ConvertTo-Base64 ($stringto) {
<#
.SYNOPSIS
    ConvertTo-Base64 converts a normal string to a base 64 string
.DESCRIPTION
    ConvertTo-Base64 converts a normal string to a base 64 string
.PARAMETER StringTo
    The string you want manipulated
.NOTES
    Author:     Bill Riedy
.OUTPUTS
    [string]
.LINK
    about_Properties
#>

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {

        $bytesto  = [System.Text.Encoding]::Unicode.GetBytes($stringto)
        $encodedto = [System.Convert]::ToBase64String($bytesto)
        write-output $encodedto
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}

Set-Alias -Name 'Base64Encode' -Value 'ConvertTo-Base64' -Description 'Alias for ConvertTo-Base64'
