Function Show-AllColor {
    $colors = [Enum]::GetValues( [ConsoleColor] )
    $maxName = ($colors | foreach-object { "$_ ".Length } | Measure-Object -Maximum).Maximum
    $colors | foreach-object -begin {
            Write-Host ("{0,3} {1,$maxName} {2,-$maxName}" -f "Dec", "ColorName", "Color"   )
            Write-Host ("{0,3} {1,$maxName} {2,-$maxName}" -f "===", ("="*$maxName), ("="*$maxName) )
        } -process {
            Write-Host (" {0,2} {1,$maxName} " -f [int] $_,$_) -NoNewline
            Write-Host "$_" -Foreground $_
        }
} #EndFunction Show-AllColor

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Show-AllColor'
$FuncAlias       = ''
$FuncDescription = 'Display all console color combinations'
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
