Function Get-NtpDate  {
<#
.SYNOPSIS
    To get the time from an NTP server
.DESCRIPTION
    To get the time from an NTP server.

    Will return a [DateTime] and accepts the -Verbose parameter. If request fails it will return "1/1/1900"
.PARAMETER ComputerName
    The name or IPv4 address of the computer running NTP
.NOTES
    Author:     Bill Riedy
    Version:    1.0
    Date:       2018/03/13
    Notes:      None at this time
.EXAMPLE
    Get-NtpDate $DC
    Assuming $DC holds the name of the domain controller then would return a datetime similar to
    Monday, March 05, 2018 9:52:57 AM
.EXAMPLE
    Test-NtpDateVsNow "DoesNotExist"
    Assuming "DoesNotExist" doesn't actually exist as a computer name then would return the datetime
    Monday, January 01, 1900 12:00:00 AM
.OUTPUTS
    A datetime object
#>
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   Position=0)]
        [Alias("NtpServer")]
        [string] $ComputerName
    )
    write-verbose -message "Attempting to get time from NTP server $ComputerName"
    $oldEA = $ErrorActionPreference
    $ErrorActionPreference = "Stop"
    $Socket = New-Object -typename Net.Sockets.Socket -argumentlist ( 'InterNetwork', 'Dgram', 'Udp' )
    $Socket.SendTimeOut    = 2000  # ms
    $Socket.ReceiveTimeOut = 2000  # ms
    try {
        $Socket.Connect( $ComputerName, 123 )
        $NTPData    = New-Object byte[] 48
        $NTPData[0] = 27 # Request header: 00 = No Leap Warning; 011 = Version 3; 011 = Client Mode; 00011011 = 27
        $Socket.Send(    $NTPData ) | Out-Null
        $Socket.Receive( $NTPData ) | Out-Null
        $Seconds = [BitConverter]::ToUInt32( $NTPData[43..40], 0 )
        (get-date -date '1/1/1900' ).AddSeconds( $Seconds ).ToLocalTime()
        write-verbose -message "Successfully received time from NTP $ComputerName"
    } catch {
        get-date -date '1/1/1900'
        write-verbose -message "Failed receiving time from $ComputerName, server not up, or not running NTP"
    }
    $ErrorActionPreference = $oldEA
} #EndFunction Get-NtpDate

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-NtpDate'
    $FuncAlias       = ''
    $FuncDescription = 'Queries an NTP server for the time'
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
