Function ConvertTo-DecimalIPv4 {
<#
.SYNOPSIS
    Converts a Dotted Decimal IP address into a 32-bit unsigned integer.
.DESCRIPTION
    ConvertTo-DecimalIP takes a dotted decimal IP and uses the [ipaddress] accelerator to determine 32 bit decimal value
.PARAMETER IPAddress
    An IP Address to convert.
#>

    [CmdLetBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Net.IPAddress] $IPAddress
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        $i = [ipaddress] $IPAddress
        write-output $i.Address
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #EndFunction ConvertTo-DecimalIPv4

Set-Alias -Name 'ConvertTo-DecimalIP' -Value 'ConvertTo-DecimalIPv4'

