Function Format-WrapText {
<#
.SYNOPSIS
    Wraps text at a particular column width
.DESCRIPTION
    Wraps text at a particular column width (Default=80)
.PARAMETER Text
    The text to be formatted
.PARAMETER Width
    Column width to wrap at. Default = 80
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    Format-WrapText -Text "word1 word2 word3 word4 word5" -Width 10
    Would return
.OUTPUTS
    [String]
.LINK
    Format-Table
    Format-List
#>
    #region Parameter
    [cmdletbinding(ConfirmImpact = 'low')]
    [OutputType([string])]
    Param(
        [Parameter(
            Mandatory = $True,
            HelpMessage = 'Enter a long string of text',
            Position = 0,
            ValueFromPipeline = $True)
        ]
            [string] $Text,
        [Parameter(
            Position = 1)]
            [int] $Width = 80
        )
    #endregion Parameter

    begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process
    {
    #    [string] $text = $text
        $Words = $Text -split "\s+"
        $Col = 0
        [string] $Line = $null
        foreach ( $Word in $Words ) {
            $Col += $Word.Length + 1
            $Line += "$word "
            if ( $Col -gt $Width ) {
                Write-output -inputobject "$line"
                [string] $line = $null
                $Col = 0 # $word.Length + 1
            }
        }
        if ($null -ne $line) {
            write-output -inputobject "$line"
        }
    }
    end {Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"}
} #EndFunction Format-WrapText

Set-Alias -Name 'WrapText' -Value 'Format-WrapText'
