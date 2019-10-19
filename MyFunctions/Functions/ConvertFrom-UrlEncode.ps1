Function ConvertFrom-UrlEncode {
<#
.SYNOPSIS
    Converts a URL encoded string back into a normal string
.DESCRIPTION
    Converts a URL encoded string back into a normal string
.PARAMETER URL
    The encoded URL string
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    ConvertFrom-UrlEncode 'https%3a%2f%2fwww.google.com%2f'

    Would return
    https://www.google.com/
.EXAMPLE
    ConvertFrom-UrlEncode 'http%3a%2f%2fLong+filename.docx'

    Would return
    http://Long filename.docx
.OUTPUTS
    [string]
.LINK
    about_Properties
#>

[cmdletbinding()]
Param(
    [Parameter()]
    [string] $URL
)

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    } #close begin block

    Process {
        $Decode = [System.Web.HttpUtility]::UrlDecode($URL)
        Write-Output $Decode
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close end block

}

Set-Alias -Name 'UrlDecode' -Value 'ConvertFrom-UrlEncode' -Description 'Alias for ConvertFrom-UrlEncode'
