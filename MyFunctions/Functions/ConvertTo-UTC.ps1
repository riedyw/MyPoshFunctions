Function ConvertTo-UTC {
<#
.SYNOPSIS
    Converts a datetime from local time to UTC
.DESCRIPTION
    Converts a datetime from local time to UTC
.EXAMPLE
    ConvertTo-UTC -DateTime "1/25/2018 8:34:31 AM"

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

    Thursday, January 25, 2018 1:34:31 PM
.EXAMPLE
    ConvertTo-UTC '2/1/2018 4:27:59 PM'

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

    Thursday, February 01, 2018 9:27:59 PM
.EXAMPLE
    "3/15/2018 12:00:00 PM" | ConvertTo-UTC

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

    Thursday, March 15, 2018 4:00:00 PM
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([datetime])]
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
        $strCurrentTimeZone = (Get-CimInstance win32_timezone).Description
        write-verbose "Your local timezone is '$strCurrentTimeZone'"
        $DateTime = $DateTime.ToUniversalTime()
        write-verbose "The UTC time is: '$DateTime'"
        write-output $DateTime
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close end block

} #EndFunction ConvertTo-UTC
