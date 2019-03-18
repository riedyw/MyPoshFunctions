Function Test-NtpDateVsNow {
<#
.SYNOPSIS
    To test whether local time and NTP time fall within a particular tolerance
.DESCRIPTION
    To test whether local time and NTP time fall within a particular tolerance. The NTP protocol allows for an acceptable drift between local and NTP time.
    Will return a [Boolean] and accepts the -Verbose parameter
.PARAMETER ComputerName
    The name or IPv4 address of the computer running NTP
.PARAMETER Tolerance
    The acceptable number of seconds difference between local and NTP time. Default = 300. Valid range 1-3600 seconds (1 hour)
.NOTES
    Author:     Bill Riedy
    Will return a value of $False if either: a) the time difference is greater than the $Tolerance; or b) the time server does not reply to the NTP time request being sent by this function
.EXAMPLE
    Test-NtpDateVsNow $DC
    Assuming $DC holds the name of the domain controller then would return the boolean
    $True
.EXAMPLE
    Test-NtpDateVsNow "DoesNotExist"
    Assuming "DoesNotExist" doesn't actually exist as a computer name then would return the boolean
    $False
.OUTPUTS
    A boolean $true or $false indicating if comparing local time to NTP time falls within a tolerance
.LINK
    NTP - Network Time Protocol
.LINK
    w32tm.exe
.LINK
    http://www.pool.ntp.org/en/
#>
#region Parameters
    [CmdletBinding()]
    [OutputType([bool])]
    Param (
        # Specifies the NTP server to communicate with
        [parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   Position=0,
                   HelpMessage='Enter a ComputerName or IpAddress of a system acting as a time server [domain controller] or appliance')]
        [Alias("NtpServer")]
        [string] $ComputerName,

        # Specifies the acceptable number of seconds difference between local and NTP time
        [parameter(ValueFromPipeLineByPropertyName=$True)]
        [ValidateRange(1,3600)]
        [int] $Tolerance = 300
    )
#endregion Parameters

    begin
    {
    }

    process
    {
        $Ntp = Get-NtpDate ($ComputerName)
        write-verbose -message "Getting NTP time from $ComputerName and time is $Ntp"
        $Now = Get-Date
        write-verbose -message "Getting local time and time is $Now"
        $AbsDiff = [math]::Abs(($ntp - $now).TotalSeconds)
        write-verbose -message "There are $AbsDiff seconds difference between times, and comparing to $Tolerance is"
        if ($AbsDiff -gt $Tolerance) {
            write-output -inputobject $false
        } else {
            write-output -inputobject $true
        }
    }
} #EndFunction Test-NtpDateVsNow

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Test-NtpDateVsNow'
$FuncAlias       = ''
$FuncDescription = 'To test whether local time and NTP time fall within a particular tolerance'
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

