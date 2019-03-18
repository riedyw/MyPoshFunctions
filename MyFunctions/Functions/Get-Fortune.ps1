Function Get-Fortune {
    [System.IO.File]::ReadAllText((Split-Path -path $profile)+'\wisdom.txt') -replace "`r`n", "`n" -split "`n%`n" | Get-Random
    # Sample wisdom.txt file with 3 entries.  Each 'fortune' is delimited by a line consisting of just the pct sign
    # The last fortune in the file should NOT be terminated with a pct sign
    <#
    %
    This too will pass.
       - Attar
    %
    Don't think, just do.
       - Horace
    %
    Time is money.
       - Benjamin Franklin
    #>
} #EndFunction Get-Fortune

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-Fortune'
    $FuncAlias       = 'Fortune'
    $FuncDescription = 'Gets a quote from a text file seperated by line containing a single character "%"'
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
