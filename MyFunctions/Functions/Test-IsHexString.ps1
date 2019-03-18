Function Test-IsHexString {
<#
.SYNOPSIS
    blah
.DESCRIPTION
    blah blah
.EXAMPLE
    Test-IsCapsLock
.EXAMPLE
    Test-IsCapsLock -Verbose
#>

    [CmdletBinding()]
    [OutputType([bool])]
    Param()

    $x = $args[0] ; $y=$x.length ; $x -match "[0123456789abcdef]{$y}"
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Test-IsHexString'
    $FuncAlias       = ''
    $FuncDescription = 'Determines if a string is a Hex'
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
