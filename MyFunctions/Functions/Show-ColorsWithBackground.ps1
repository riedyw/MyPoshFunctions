Function Show-ColorsWithBackground {
    $colors = [Enum]::GetValues( [ConsoleColor] )
    $bgcolors = $colors
    $max = ($colors | foreach-object { "$_ ".Length } | Measure-Object -Maximum).Maximum
    foreach ( $bgcolor in $bgcolors ) {
        write-host ("{0,2}{1,$max}" -f [int] $bgcolor, $bgcolor) -nonewline
        foreach ($color in $colors) {
            Write-Host ("{0,$max}" -f ,$color) -NoNewline -background $bgcolor -foreground $color
            if ($color -eq "Gray") { write-host " " ; write-host "  " -NoNewLine}
        }
    write-host " "
    }
} #EndFunction Show-ColorsWithBackground

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Show-ColorsWithBackground'
    $FuncAlias       = ''
    $FuncDescription = 'Shows colors with a background'
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
