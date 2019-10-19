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

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

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

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #EndFunction Resolve-HostName
