Function Test-IsNumLock {
<#
.SYNOPSIS
    Determines the state of the [NumLock]
.DESCRIPTION
    Determines the state of the [NumLock]. Optional -Verbose argument
.EXAMPLE
    Test-IsNumLock
.EXAMPLE
    Test-IsNumLock -Verbose
.OUTPUT
    bool
#>

    [CmdletBinding()]
    [OutputType([bool])]
    Param()

    write-verbose -Message 'Determining the state of [NumLock]'
    [console]::NumberLock
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Test-IsNumLock'
    $FuncAlias       = ''
    $FuncDescription = 'Determine the state of [NumLock]'
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
