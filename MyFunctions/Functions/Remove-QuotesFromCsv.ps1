Function Remove-QuotesFromCsv {
<#
.SYNOPSIS
    Removes quotes from a CSV data set. Can optionally set $Delimiter to another character.
.DESCRIPTION
    Removes quotes from a CSV data set. Can optionally set $Delimiter to another character.
.PARAMETER CSV
    The CSV string data.
.PARAMETER Delimiter
    A single [char] delimiter. Defaults to ','. Can be set to "`t"
.EXAMPLE
    '"f1","f2"' | Remove-QuotesFromCsv

    Will return
    f1,f2
.EXAMPLE
    "`"f1`"`t`"f2`"" | Remove-QuotesFromCsv -Delimiter "`t" -verbose

    Will return
    VERBOSE: Starting Remove-QuotesFromCsv
    f1      f2
    VERBOSE: Ending Remove-QuotesFromCsv
.EXAMPLE
    $array | ConvertTo-Csv -NoTypeInformation | Remove-QuotesFromCsv

    Will return
    blah,blah,blah
.INPUTS
    None
.OUTPUTS
    [string[]]
.NOTES
    Author:      Bill Riedy
.LINK
    ConvertFrom-Csv
#>
    [CmdletBinding(ConfirmImpact='Low',SupportsShouldProcess = $true)]
    [OutputType([string[]])]
    param(
        [parameter(ValueFromPipeLine=$True,Mandatory=$True)]
        [string[]] $csv,

        [parameter()]
        [char] $Delimiter = ','
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        foreach ($line in $csv) {
            write-verbose ("Current line: " + $line)
            # .replace method uses literal strings to search for
            # -replace operator uses regex string expressions to search for text
            $line | foreach-object { $_.replace(('"' + $Delimiter),'|').replace(($Delimiter +'"'),'|') -replace '^"','' -replace '"$', ''}
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #EndFunction Remove-QuotesFromCsv
