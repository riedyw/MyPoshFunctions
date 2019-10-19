Filter Out-Clipboard  {
<#
.SYNOPSIS
    Takes input, converts it to a string and copies to the clipboard
.DESCRIPTION
    Takes input, converts it to a string and copies to the clipboard
.PARAMETER Text
    Either specified as an argument or it can be fed from the pipeline.
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    '123' | Out-Clipboard -Verbose
    Would return:
    VERBOSE: Sending [123

    ] to the clipboard.
.EXAMPLE
    $profile | Out-Clipboard
    Would return:
    Nothing, but would place the contents of the $profile variable and place into the Windows clipboard.
.OUTPUTS
    [null]  Instead it places a string into the clipboard
.LINK
    https://www.Google.com
#>

    [cmdletbinding()]
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        [AllowEmptyString()]
        $Text
    )

    begin {
        $sb = New-Object -Typename System.Text.StringBuilder
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        $null = $sb.AppendLine($Text)
    }

    end {
        write-verbose "Sending [$($sb.ToString() | out-string)] to the clipboard."
        $sb.ToString() | clip.exe
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }
}
