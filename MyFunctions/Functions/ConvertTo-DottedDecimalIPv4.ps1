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
        [Net.IPAddress]$IPAddress
    )

    process {
        $i = [ipaddress] $IPAddress
        write-output $i.IPAddressToString
      }
} #EndFunction ConvertTo-DottedDecimalIPv4

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'ConvertTo-DottedDecimalIPv4'
    $FuncAlias       = 'ConvertTo-DottedDecimalIP'
    $FuncDescription = 'Returns a dotted decimal IP address.'
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
