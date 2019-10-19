Function ConvertFrom-UnixEpoch {
<#
.SYNOPSIS
    Converts a Unix Epoch value to a datetime
.DESCRIPTION
    Converts a Unix Epoch value to a datetime
.EXAMPLE
    ConvertFrom-UnixEpoch -UnixEpoch 1521115200

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the datetime

    Thursday, March 15, 2018 12:00:00 PM
.EXAMPLE
    ConvertFrom-UnixEpoch 1517502479

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the datetime

    Thursday, February 01, 2018 4:27:59 PM
.EXAMPLE
    ConvertFrom-UnixEpoch 1517502479 -Verbose

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the following output:

    VERBOSE: You entered a Unix Epoch of:  '1517502479'
    VERBOSE: The beginning of a Unix Epoch is: '01/01/1970 00:00:00'
    VERBOSE: The date '02/01/2018 16:27:59' is 1517502479 seconds in the future of '01/01/1970 00:00:00'
    Thursday, February 01, 2018 4:27:59 PM
#>
    #region Parameter
    [CmdletBinding()]
    [Alias()]
    [OutputType([datetime])]
    param(
        [parameter(Mandatory=$true,
                   ValueFromPipeline = $true,
                   Position=0 )]
        [int64] $UnixEpoch
    )
    #endregion Parameter

    Begin {
        Write-Verbose "Starting $($MyInvocation.Mycommand)"
        $BeginUnixEpoch = get-date "1/1/1970"
    } #close begin block

    Process {
        write-verbose "You entered a Unix Epoch of:  '$UnixEpoch'"
        write-verbose "The beginning of a Unix Epoch is: '$BeginUnixEpoch'"
        $TempTime = $BeginUnixEpoch.AddSeconds($UnixEpoch)
        write-verbose "The date '$TempTime' is $UnixEpoch seconds in the future of '$BeginUnixEpoch'"
        write-output $TempTime
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #EndFunction ConvertFrom-UnixEpoch
