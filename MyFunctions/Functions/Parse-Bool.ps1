Function Parse-Bool {
    [CmdletBinding()]
    param(
        [Parameter(Position=0)]
        [System.String]$inputVal
    )
    $inputVal = $inputVal.Trim()
    if (($inputVal -eq '') -or ($inputVal -eq $null)) {
        $false
    } else {
        if (test-isNumeric $inputVal) {
            if ($inputVal -eq 0) {
                $false
            } else {
                $true
            }
        } else {
            switch -regex ($inputVal)
            {
                "^(true|yes|on|enabled|t|y)$" { $true }
                default { $false }
            }
        }
    }
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Parse-Bool'
    $FuncAlias       = ''
    $FuncDescription = 'Converts a string value to Boolean'
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
