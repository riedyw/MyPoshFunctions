Filter grep {
<#
.SYNOPSIS
    A simple text filter to search for a string
.DESCRIPTION
    A simple text filter to search for a string
.PARAMETER Keyword
    The string searching for
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    'Hello','There' | grep 'Hello'
    Would return
    Hello
.OUTPUTS
    [string]
.LINK
    about_Functions
#>

#region Parameter
    [cmdletbinding()]
    [OutputType([string])]
    Param(
        [Parameter(Mandatory = $False, ValueFromPipeline = $True)]
        [string[]] $String,

        [Parameter(Mandatory = $False, ValueFromPipeline = $False)]
        [string] $Keyword

    )
#endregion Parameter

    Begin {
        write-verbose "String to search for is [$Keyword]"
        $Line = 0
        $Count = 0
    }

    Process {
        foreach ($s in $String) {
            $Line ++
            $Count ++
            write-verbose "Line $Line is [$($s)]"
            if ($s) {
                $s | where-object { $_ -match $keyword }
            }
        }
    }

    End {
        if (-not $Count) {
            write-verbose "No input"
        }
    }
}
