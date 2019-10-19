Function Get-RandomDate {
<#
.SYNOPSIS
    Gets a random date
.DESCRIPTION
    Gets a random date. Can specify minimum and maximum dates. Can optionally specify -DateLimit to
    stay within the time limits of the possible datatypes. Can also use formatting switches -Format
    or -UFormat which function the same as Get-Date parameters of the same name.
.PARAMETER MinDate
    An optional [datetime] indicating the lowest date to return
.PARAMETER MaxDate
    An optional [datetime] indicating the highest date to return
.PARAMETER DateLimit
    A [string] validated against the set @('DateTime','UnixEpoch','FileTime'). Defaults to 'DateTime'
    DateLimit       MinDate                 MaxDate
    ===========     =====================   =====================
    DateTime        01/01/0001 12:00:00AM   12/31/9999 11:59:59PM
    UnixEpoch       01/01/1970 12:00:00AM   01/19/2038 03:14:07AM
    FileTime        01/01/1601 12:00:00AM   12/31/9999 11:59:59PM
.PARAMETER Format
    A [string] containing formatting information. See Get-Help Get-Date for further information
.PARAMETER UFormat
    A [string] containing formatting information. See Get-Help Get-Date for further information
.NOTES
    Author:     Bill Riedy
    If you specify both -Format and -UFormat the -Format setting takes precedence.
    If you specify -MinDate or -MaxDate, -MinDate must be less than or equal to -MaxDate.
.EXAMPLE
    Get-Randomdate  -MinDate 1/1/1969 -Max-Date 1/1/2040 -DateLimit UnixEpoch -verbose
    Would return something similar to the following:
    VERBOSE: $MinDate specified as [01/01/1969 00:00:00]
    VERBOSE: $MaxDate specified as [01/01/2040 00:00:00]
    VERBOSE: $MinDate ouside valid UnixEpoch setting to [01/01/1970 00:00:00]
    VERBOSE: $MaxDate ouside valid UnixEpoch setting to [01/19/2038 03:14:07]
    VERBOSE: The random date calculated is [12/26/1997 18:41:51]
    VERBOSE: The return value is [System.DateTime] datatype
    Friday, December 26, 1997 6:41:51 PM
.EXAMPLE
    Get-RandomDate  -MinDate 1/1/1969 -Max-Date 1/1/2040 -DateLimit UnixEpoch
    Would return something similar to the following:
    Friday, August 12, 2005 2:57:51 AM
.EXAMPLE
    Get-RandomDate  -MinDate 1/1/1576 -Max-Date 7/4/1776 -DateLimit FileTime -Verbose
    Would return something similar to the following:
    VERBOSE: $MinDate specified as [01/01/1576 00:00:00]
    VERBOSE: $MaxDate specified as [07/04/1776 00:00:00]
    VERBOSE: $MinDate ouside valid FileTime setting to [01/01/1601 00:00:00]
    VERBOSE: The random date calculated is [06/27/1615 16:45:27]
    VERBOSE: The return value is [System.DateTime] datatype
    Saturday, June 27, 1615 4:45:27 PM
.EXAMPLE
    Get-RandomDate  -MinDate 1/1/19 -MaxDate 2/1/19
    Would return something similar to the following:
    Wednesday, January 30, 2019 1:25:06 AM
.OUTPUTS
    [datetime]  if both -Format and/or -UFormat are NOT set
    [string]    if either -Format and/or -UFormat are set
.LINK
    Get-Date
#>

    #region Parameter
    [cmdletbinding(
        DefaultParameterSetName = '',
        ConfirmImpact = 'low'
    )]
    [OutputType([psobject])]
    Param(
        [Parameter(
            Mandatory = $False,
            Position = 0,
            ParameterSetName = '',
            ValueFromPipeline = $True)
            ]
            [datetime] $MinDate,

        [Parameter(
            Position = 1,
            Mandatory = $False,
            ParameterSetName = '')]
            [datetime] $MaxDate,

        [Parameter(
            ParameterSetName = '')]
            [ValidateSet('DateTime', 'UnixEpoch', 'FileTime')]
            [String] $DateLimit = "DateTime",

        [Parameter(
            ParameterSetName = '')]
            [String] $Format,

        [Parameter(
            ParameterSetName = '')]
            [String] $UFormat
        )
    #endregion Parameter

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }
    Process {
        if (-not $MinDate) {
            $MinDate = [datetime]::MinValue
            Write-Verbose "`$MinDate not specified, setting it to [$($MinDate)]"
        }
        else {
            Write-Verbose "`$MinDate specified as [$($MinDate)]"
        }
        if (-not $MaxDate) {
            $MaxDate = [datetime]::MaxValue
            Write-Verbose "`$MaxDate not specified, setting it to [$($MaxDate)]"
        }
        else {
            Write-Verbose "`$MaxDate specified as [$($MaxDate)]"
        }
        $UnixMinDate = Get-Date 1/1/1970
        $UnixMaxDate = $UnixMinDate.AddSeconds([int32]::MaxValue)
        $FileTimeMinDate = Get-Date 1/1/1601
        $FileTimeMaxDate = [datetime]::MaxValue
        switch ($DateLimit) {
            'FileTime' {
                if ($MinDate -lt $FileTimeMinDate) {
                    Write-Verbose "`$MinDate ouside valid FileTime setting to [$($FileTimeMinDate)]"
                    $MinDate = $FileTimeMinDate
                }
                if ($MaxDate -gt $FileTimeMaxDate) {
                    Write-Verbose "`$MaxDate ouside valid FileTime setting to [$($FileTimeMinDate)]"
                    $MaxDate = $FileTimeMinDate
                }
            }
            'UnixEpoch' {
                if ($MinDate -lt $UnixMinDate) {
                    Write-Verbose "`$MinDate ouside valid UnixEpoch setting to [$($UnixMinDate)]"
                    $MinDate = $UnixMinDate
                }
                elseif ($MinDate -gt $UnixMaxDate) {
                    Write-Verbose "`$MinDate ouside valid UnixEpoch setting to [$($UnixMaxDate)]"
                    $MinDate = $UnixMaxDate
                }
                if ($MaxDate -gt $unixMaxDate) {
                    Write-Verbose "`$MaxDate ouside valid UnixEpoch setting to [$($UnixMaxDate)]"
                    $MaxDate = $UnixMaxDate
                }
                elseif ($MaxDate -lt $UnixMinDate) {
                    Write-Verbose "`$MaxDate ouside valid UnixEpoch setting to [$($UnixMinDate)]"
                    $MaxDate = $UnixMinDate
                }
            }
            'DateTime' {
                # Normal limits on dates
            }
        }
        if ($MinDate -gt $MaxDate) {
            Write-Error "`$MinDate can not be greater than `$MaxDate"
            return
        }
        $ReturnValue = Get-Date (Get-Random -Min ($MinDate.Ticks) -Max ($MaxDate.Ticks + 1))
        Write-Verbose "The random date calculated is [$($ReturnValue)]"
        if ($Format) {
            $F = Get-Date $ReturnValue -Format $Format
            Write-Verbose "The return value is [$($F.gettype().FullName)] datatype"
            $F
        }
        elseif ($UFormat) {
            $UF = Get-Date $ReturnValue -UFormat $UFormat
            Write-Verbose "The return value is [$($UF.gettype().FullName)] datatype"
            $UF
        }
        else {
            Write-Verbose "The return value is [$($ReturnValue.gettype().FullName)] datatype"
            $ReturnValue
        }
    }
    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }
} #EndFunction Get-RandomDate
