Function ConvertFrom-IcsDateTime () {
<#
.SYNOPSIS
    Converts an ICS datetime into a normal datetime value.
.DESCRIPTION
    Converts an ICS datetime into a normal datetime value.

    IcsDateTime is of the form "yyyymmddTHHMMSSZ"

    Where
        yyyy    is the 4 digit year
        mm      is the 2 digit month
        dd      is the 2 digit day of the month
        HH      is the 2 digit in 24 hour format (00-23, 1 pm = 13)
        MM      is the 2 digit minute (00-59)
        SS      is the 2 digit second (00-59)
        T       is the letter T
        Z       is an optional suffix indicating UTC or Zulu time
.EXAMPLE
    ConvertFrom-icsDateTime "20161124T225058Z" -verbose

    Would return the datetime
    Thursday, November 24, 2016 5:50:58 PM
.NOTES
    Author:     Bill Riedy
    Info:
#>
    #region Parameter
    [CmdletBinding()]
    [Alias()]
    [OutputType([datetime])]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   Position=0)]
        [string] $IcsDateTime
    )
    #endregion Parameter

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"

        $regexp = '^(\d\d\d\d\d\d\d\d)(T)(\d\d\d\d\d\d)(Z)?$'
    } #close begin block

    process {
        if ( -not ($IcsDateTime -match $regexp)) {
            write-verbose -message "The ICS date time should be of the form 'yyyymmddTHHMMSSZ'"
            write-output -inputobject $false
        } else {
            if ( $matches[4]) { # the ICS datetime ends with 'Z'
                [datetime]::parseexact($IcsDateTime,'yyyyMMddTHHmmssZ',$null)
            }
            else {
                [datetime]::parseexact($IcsDateTime,'yyyyMMddTHHmmss',$null)
            }
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close end block

} #EndFunction ConvertFrom-IcsDateTime
