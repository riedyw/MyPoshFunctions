# inspired by: https://blogs.technet.microsoft.com/heyscriptingguy/2017/02/01/powertip-convert-from-utc-to-my-local-time-zone/

Function ConvertFrom-UTC {
<#
.SYNOPSIS
    Converts a datetime from UTC to local time
.DESCRIPTION
    Converts a datetime from Universal Coordinated Time to local time
.EXAMPLE
    ConvertFrom-UTC -DateTime "1/25/2018 1:34:31 PM"

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the datetime

    Thursday, January 25, 2018 8:34:31 AM
.EXAMPLE
    ConvertFrom-UTC '2/1/2018 9:27:59 PM'

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the datetime

    Thursday, February 01, 2018 4:27:59 PM
.EXAMPLE
    "3/15/2018 12:00:00 PM" | ConvertFrom-UTC

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the datetime

    Thursday, March 15, 2018 8:00:00 AM
.LINK
    [System.TimeZoneInfo]
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([datetime])]
    param(
        [parameter(Mandatory=$true,
                   ValueFromPipeline = $true,
                   Position=0 )]
        [string] $UTCTime
    )
    $newUTCTime = get-date $UTCTime
    write-verbose "You entered a UTC Time of:  '$UTCTime'"
    $strCurrentTimeZone = (Get-WmiObject win32_timezone).StandardName
    $strCurrentTimeZoneDescription = (Get-WmiObject win32_timezone).Description
    write-verbose "Your local timezone is '$strCurrentTimeZoneDescription'"
    $TZ = [System.TimeZoneInfo]::FindSystemTimeZoneById($strCurrentTimeZone)
    $LocalTime = [System.TimeZoneInfo]::ConvertTimeFromUtc($newUTCTime, $TZ)
    write-verbose "Your local time is: '$LocalTime'"
    write-output $LocalTime
} #EndFunction ConvertFrom-UTC

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported

    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

    $FuncName        = 'ConvertFrom-UTC'
    $FuncAlias       = ''
    $FuncDescription = 'Converts a datetime from UTC to local time'
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

