Function ConvertTo-UnixEpoch {
<#
.SYNOPSIS
    Converts a datetime to a UnixEpoch which is the number of seconds since '1/1/1970 12:00:00 AM'
.DESCRIPTION
    Converts a datetime to a UnixEpoch which is the number of seconds since '1/1/1970 12:00:00 AM'
.EXAMPLE
    ConvertTo-UnixEpoch -DateTime "1/25/2018 8:34:31 AM"

    Would return the value

    1516869271
.EXAMPLE
    ConvertTo-UnixEpoch '2/1/2018 4:27:59 PM'

    Would return the value

    1517502479
.EXAMPLE
    "3/15/2018 12:00:00.545 PM" | ConvertTo-UnixEpoch

    Would return the value

    1521115200.545
.EXAMPLE
    ConvertTo-UnixEpoch '2/1/2018 4:27:59 PM' -Verbose

    Would return the following output

    VERBOSE: You entered a Local Time of:  '02/01/2018 16:27:59'
    VERBOSE: The beginning of a Unix Epoch is: '01/01/1970 00:00:00'
    VERBOSE: The date '02/01/2018 16:27:59' is 1517502479 seconds in the future of '01/01/1970 00:00:00'
    1517502479
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([double])]
    Param
    (
        [Parameter( Mandatory = $true,
                    ValueFromPipeline = $true,
                    Position=0)]
        [datetime] $DateTime
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    } #close begin block

    process {
        write-verbose "You entered a Local Time of:  '$DateTime'"
        $BeginUnixEpoch = get-date "1/1/1970"
        write-verbose "The beginning of a Unix Epoch is: '$BeginUnixEpoch'"
        $UnixEpoch = [timespan] ($DateTime - $BeginUnixEpoch)
        write-verbose "The date '$DateTime' is $($UnixEpoch.TotalSeconds) seconds in the future of '$BeginUnixEpoch'"
        write-output $UnixEpoch.TotalSeconds
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close end block

} #EndFunction ConvertTo-UnixEpoch
