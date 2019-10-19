Filter Remove-BlankOrComment {
<#
.SYNOPSIS
    A simple text filter to remove blank lines or lines that begin with a comment character '#'
.DESCRIPTION
    A simple text filter to remove blank lines or lines that begin with a comment character '#'
.PARAMETER String
    The input string
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    '#Hello','','There' | Remove-BlankOrComment
    Would return:
    There
.EXAMPLE
    Remove-BlankOrComment -verbose
    Would return:
    VERBOSE: No input
.EXAMPLE
    '#Hello','','There' | Remove-BlankOrComment -verbose
    VERBOSE: Line 1 is [#Hello]
    VERBOSE: Line 2 is []
    VERBOSE: Line 3 is [There]
.OUTPUTS
    [string]
.LINK
    about_Functions
#>

#region Parameter
    [cmdletbinding()]
    [OutputType([string])]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = $True)]
        [string[]] $String
    )
#endregion Parameter

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
        $Line = 0
        $Count = 0
    }

    Process {
        foreach ($s in $String) {
            $Line ++
            $Count ++
            write-verbose "Line $Line is [$($s)]"
            if ($s) {
                $s | where-object { $_ -notmatch '^[\s]*#' -and $_ -notmatch '^[\s]*$' }
            }
        }
    }

    End {
        if (-not $Count) {
            write-verbose "No input"
        }
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }
}
