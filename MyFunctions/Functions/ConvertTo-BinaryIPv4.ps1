#region Function
Function ConvertTo-BinaryIPv4 {
<#
.SYNOPSIS
    Converts a Decimal IP address into a binary format.
.DESCRIPTION
    ConvertTo-BinaryIP uses System.Convert to switch between decimal and binary format. The output from this function is dotted binary string.
.PARAMETER IPAddress
    An IPv4 Address to convert.
.PARAMETER IncludeOriginal
    A switch indicating if you want to display original IPv4 address. If true then it will output a PsObject with the property fields of IPv4 and Binary
.EXAMPLE
    (PS)> ConvertTo-BinaryIPv4 -IPAddress 24.3.1.1

    Would return
    00011000.00000011.00000001.00000001
.EXAMPLE
    (PS)> ConvertTo-BinaryIPv4 -IPAddress 10.1.1.1,192.168.1.1  -verbose -IncludeOriginal

    Would return
    VERBOSE: IPv4Address entered [10.1.1.1,192.168.1.1]
    VERBOSE: You selected to include original value in output
    VERBOSE: Processing [10.1.1.1]
    VERBOSE: Binary representation [00001010.00000001.00000001.00000001]

    VERBOSE: Processing [192.168.1.1]
    VERBOSE: Binary representation [11000000.10101000.00000001.00000001]
    IPv4        Binary
    ----        ------
    10.1.1.1    00001010.00000001.00000001.00000001
    192.168.1.1 11000000.10101000.00000001.00000001
.EXAMPLE
    (PS)> "10.1.1.1","192.168.1.1" | ConvertTo-BinaryIPv4

    Would return
    00001010.00000001.00000001.00000001
    11000000.10101000.00000001.00000001
.NOTES
    NAME: ConvertTo-BinaryIPv4
    AUTHOR: Bill Riedy
    LASTEDIT: 06/13/2018
.INPUTS
    An IPv4Address or array of IPV4Address'es
.OUTPUTS
    [pscustomboject]
    [string]
.LINK
    [System.Net.IPAddress]
#>

#region Parameter
    [CmdLetBinding()]
    [OutputType([PsObject])]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [System.Net.IPAddress[]] $IPAddress,

        [Parameter(Position = 1)]
        [switch] $IncludeOriginal
    )
#endregion Parameter

    begin
    {

    }

#region Process
    process {
        write-verbose -Message "IPv4Address entered [$($ipaddress.ipAddressToString -join ',')]"
        if ($IncludeOriginal)
        {
            write-verbose -Message 'You selected to include original value in output'
        }
        foreach ($curIpAddress in $IPAddress) {
            write-verbose -Message "Processing [$($curIpAddress)]"
            $curBinary = ($curIpAddress.GetAddressBytes() | ForEach-Object { [Convert]::ToString($_, 2).PadLeft(8, '0') } ) -join '.'
            write-verbose -Message "Binary representation [$($curBinary)]"
            if ($IncludeOriginal)
            {
                $prop = @{
                    IPv4   = $curIpAddress
                    Binary = $curBinary
                }
                new-object -TypeName psobject -Property $prop | select-object -property IPv4, Binary
            }
            else
            {
                write-output -inputobject ($curBinary)
            }
        }
    }
#endregion Process

    end {}

} #EndFunction ConvertTo-BinaryIPv4
#endregion Function

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'ConvertTo-BinaryIPv4'
$FuncAlias       = 'ConvertTo-BinaryIP'
$FuncDescription = 'Converts a Decimal IP address into a binary format'
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
    set-alias -Name $FuncAlias -Value $FuncName -Description "ALIAS for $FuncName"
    $AliasesToExport += (new-object psobject -property @{ Name = $FuncAlias ; Description = "ALIAS for $FuncName"})
}

if ($FuncVarName)
{
    $VariablesToExport += $FuncVarName
}

# Setting the Description property of the function.
(get-childitem -Path Function:$FuncName).set_Description($FuncDescription)

#endregion Metadata
