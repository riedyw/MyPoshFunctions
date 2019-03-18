Function Ping-ComputerName {
<#
.SYNOPSIS
    To test whether a particular computer is reachable on the network
.DESCRIPTION
    To test whether a particular computer is reachable on the network
.PARAMETER ComputerName
    The name or IPv4 address of the computer you are attempting to communicate with
.NOTES
    Author:     Bill Riedy
    Version:    1.0
    Date:       2018/03/13
    Notes:      Ping (ICMP traffic) will be limited to within a VLAN in network baseline 4.0. ICMP traffic will NOT cross a firewall boundary in that baseline
.EXAMPLE
    Ping-ComputerName $DC
    Assuming $DC holds the name of the domain controller and it is running then would return the boolean
    $True
.EXAMPLE
    Ping-ComputerName "DoesNotExist"
    Assuming "DoesNotExist" doesn't actually exist as a computer name then would return the boolean
    $False
.OUTPUTS
    A boolean indicating if ICMP communication was successful or not
#>
    [CmdletBinding()]
    Param (
        # Specifies the name or IP address of the computer you are trying to test connectivity with.
        [parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   Position=0)]
        [string] $ComputerName
    )

    $oldEA = $erroractionpreference
    $ErrorActionPreference = "stop"

    $ping = new-object system.net.networkinformation.ping
    try {
        $ret = $ping.send($ComputerName)
        write-output $True
        write-verbose "Pinging $ComputerName and underlying IPAddress of $($ret.address.ipaddresstostring) was successful"
    } catch {
        write-output $False
        write-verbose "Pinging $ComputerName failed"
    }

    $ErrorActionPreference = $oldEA
} #EndFunction Ping-ComputerName

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Ping-ComputerName'
    $FuncAlias       = ''
    $FuncDescription = 'Will ping a computer'
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
