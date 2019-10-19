Function Parse-Bool {
    <#
    .SYNOPSIS
        Parse a string and convert it to a Boolean
    .DESCRIPTION
        Parse a string and convert it to a Boolean
    .PARAMETER InputVal
        The string to be evaluated
    .NOTES
        Author:     Bill Riedy
        Parse-Bool will .Trim() the InputVal before trying to parse it.
    .EXAMPLE
        Parse-Bool 'true'

        Would return
        True
    .EXAMPLE
        Parse-Bool 't'

        Would return
        True
    .EXAMPLE
        Parse-Bool 'on'

        Would return
        True
    .EXAMPLE
        Parse-Bool 0

        Would return
        False
    .EXAMPLE
        Parse-Bool 1

        Any NON-zero numeric would return
        True
    .EXAMPLE
        Parse-Bool 'nonsense'

        Would return
        False
    .OUTPUTS
        [bool]
    .LINK
        about_Properties
    #>

    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(Position = 0)]
        [System.String] $InputVal
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        $inputVal = $inputVal.Trim()
        if (($inputVal -eq '') -or ($null -eq $inputVal)) {
            $false
        }
        else {
            if (test-isNumeric $inputVal) {
                if ($inputVal -eq 0) {
                    $false
                }
                else {
                    $true
                }
            }
            else {
                switch -regex ($inputVal) {
                    "^(true|yes|on|enabled|t|y)$" { $true }
                    default { $false }
                }
            }
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} # endfunction parse-bool
