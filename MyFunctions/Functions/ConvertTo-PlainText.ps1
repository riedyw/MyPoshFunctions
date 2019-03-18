Function ConvertTo-PlainText {
<#
.SYNOPSIS
    Converts the System.Security.SecureString to plain text.
.PARAMETER SecureString
    The encrypted string to convert.
.EXAMPLE
    PS C:\> ConvertTo-PlainText -SecureString (Get-Credential).Password
.NOTES
    Author:
    Michael West
#>
    [cmdletbinding()]
    [OutputType([string])]
    param(
        [System.Security.SecureString]$SecureString
    )
    [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString));
} #EndFunction ConvertTo-PlainText

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'ConvertTo-PlainText'
    $FuncAlias       = ''
    $FuncDescription = 'Converts the System.Security.SecureString to plain text.'
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
