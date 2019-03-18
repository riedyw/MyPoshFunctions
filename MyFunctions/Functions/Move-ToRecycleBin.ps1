Function Move-ToRecycleBin ($Path) {
    $item = Get-Item -Path $Path -ErrorAction SilentlyContinue
    if ($null -eq $item)
    {
        Write-Error -Message ("'{0}' not found" -f $Path)
    }
    else
    {
        $fullpath=$item.FullName
        Write-Verbose -Message ("Moving '{0}' to the Recycle Bin" -f $fullpath)
        if (Test-Path -Path $fullpath -PathType Container)
        {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($fullpath,'OnlyErrorDialogs','SendToRecycleBin')
        }
        else
        {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($fullpath,'OnlyErrorDialogs','SendToRecycleBin')
        }
    }
} #Endfunction Move-ToRecycleBin

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Move-ToRecycleBin'
$FuncAlias       = 'Recycle'
$FuncDescription = 'Moves a file to recycle bin'
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
