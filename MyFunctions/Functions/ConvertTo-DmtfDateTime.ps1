Function ConvertTo-DmtfDateTime () {
<#
.SYNOPSIS
    Converts a datetime into a DTMF formatted datetime string
.DESCRIPTION
    Converts a datetime into a DTMF formatted datetime string

    DmtfDateTime is of the form "yyyymmddHHMMSS.mmmmmmsUUU"

    Where
        yyyy    is the 4 digit year
        mm      is the 2 digit month
        dd      is the 2 digit day of the month
        HH      is the 2 digit in 24 hour format (00-23, 1 pm = 13)
        MM      is the 2 digit minute (00-59)
        SS      is the 2 digit second (00-59)
        mmmmmm  is the 6 digit microsecond
        s       is the plus or minus to indicate offset from UTC
        UUU     is the 3 digit number of minutes offset from UTC (000-720)
.EXAMPLE
    ConvertTo-DmtfDateTime -DateTime "1/25/2018 8:34:31 AM"

    Assuming a timezone of "Eastern Time" and a culture of "en-US" this would return the string

    20180125083431.000000-300
.EXAMPLE
    ConvertTo-DmtfDateTime '2/1/2018 4:27:59 PM'

    Assuming a timezone of "Eastern Time" and a culture of "en-US" this would return the string

    20180201162759.000000-300
.EXAMPLE
    "3/15/2018 12:00:00 PM" | ConvertTo-DmtfDateTime

    Assuming a timezone of "Eastern Time" and a culture of "en-US" this would return the string and an offset of -240 as this would be Daylight Savings Time.

    20180315120000.000000-240
.EXAMPLE
    ConvertTo-DmtfDateTime '2/1/2018 4:27:59 PM' -Verbose

    Assuming a timezone of "Eastern Time" and a culture of "en-US" this would return the string

    VERBOSE: You entered a datetime of: '02/01/2018 16:27:59'
    20180201162759.000000-300
.NOTES
    Author:     Bill Riedy
    Info:       For further information on DMTF time formats see https://docs.microsoft.com/en-us/windows/desktop/wmisdk/cim-datetime
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   Position=0)]
        [datetime] $DateTime
    )
    Write-verbose -message "You entered a datetime of: '$DateTime'"
    $DmtfDateTime = [Management.ManagementDateTimeConverter]::ToDmtfDateTime(($DateTime))
    write-output -inputobject $DmtfDateTime
} #EndFunction ConvertTo-DmtfDateTime

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'ConvertTo-DmtfDateTime'
    $FuncAlias       = ''
    $FuncDescription = 'Converts a datetime into a DTMF formatted datetime string'
    $FuncVarName     = ''
    if (-not (test-path -Path Variable:AliasesToExport))
    {
        $AliasesToExport = @()
    }
    if (-not (test-path -Path Variable:VariablesToExport))
    {
        $VariablesToExport = @()
    }
    if ($FuncAlias)
    {
        set-alias -Name $FuncAlias -Value $FuncName
        $AliasesToExport += $FuncAlias
    }
    if ($FuncVarName)
    {
        $VariablesToExport += $FuncVarName
    }
    # Setting the Description property of the function.
    (get-childitem -Path Function:$FuncName).set_Description($FuncDescription)
#endregion Metadata
