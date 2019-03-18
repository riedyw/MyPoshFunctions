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
        [Net.IPAddress]$IPAddress
    )

    process {
        $i = [ipaddress] $IPAddress
        write-output $i.Address
    }
} #EndFunction ConvertTo-DecimalIPv4

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'ConvertTo-DecimalIPv4'
    $FuncAlias       = 'ConvertTo-DecimalIP'
    $FuncDescription = 'Converts a Dotted Decimal IP address into a 32-bit unsigned integer.'
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
