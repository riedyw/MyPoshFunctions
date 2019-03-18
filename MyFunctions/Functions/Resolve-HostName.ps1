Function Resolve-HostName {
<#
.SYNOPSIS
    Resolves a hostname to an IPv4 address.
.DESCRIPTION
    Specify a hostname as a parameter or pipelined in and it will resolve to an IPv4 address.
.PARAMETER Hostname
    The hostname that you want resolved
.EXAMPLE
    Resolve-HostName -Hostname $env:computername
    # Display the IPv4 address of this computer
.EXAMPLE
    Resolve-HostName -Hostname .
    # Display the IPv4 address of this computer using '.' shorthand.
.EXAMPLE
    Resolve-HostName -Hostname "server1"
    # Display the IPv4 address of "server1"
.EXAMPLE
    $DomainController = (($env:logonserver).Substring(2))
    Resolve-HostName -Hostname $DomainController
    # Display the IPv4 address of the Active Directory Domain Controller that
    # you authenticated against when you logged onto Windows.
.EXAMPLE
    "server2" | Resolve-HostName
    # Display the IPv4 address of "server2" using the pipeline.
#>
    [CmdletBinding()]
    Param (
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True,Mandatory=$True)]
        [Alias("host")]
        [string] $Hostname
    )
    Process {
        if ($Hostname -eq '.') {
            $Hostname = $env:computername
        }
        Try {
            $ipv4 = ([System.Net.Dns]::GetHostAddresses($Hostname) | where-object { $_.addressFamily -eq "InterNetwork" } ).IPAddressToString
            # write-output $ipv4
            if (Test-IsValidIPv4 $ipv4) {
                write-output $ipv4
            } else {
                write-output $false
            }
        } Catch {
            Write-Output $False
        }
    }
} #EndFunction Resolve-HostName

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Resolve-HostName'
    $FuncAlias       = ''
    $FuncDescription = 'Results in just the hostname from appearing'
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
