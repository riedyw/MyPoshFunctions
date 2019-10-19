Function ConvertTo-DottedDecimalIPv4 {
 <#
.SYNOPSIS
     Returns a dotted decimal IP address.
.DESCRIPTION
     ConvertTo-DecimalIP takes 32 bit unsigned integer address into a dotted decimal IP address
.PARAMETER IPAddress
     An IP Address to convert.
#>

    [CmdLetBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Net.IPAddress] $IPAddress
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        $i = [ipaddress] $IPAddress
        write-output $i.IPAddressToString
      }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #EndFunction ConvertTo-DottedDecimalIPv4

Set-Alias -Name 'ConvertTo-DottedDecimalIP' -Value 'ConvertTo-DottedDecimalIPv4'
