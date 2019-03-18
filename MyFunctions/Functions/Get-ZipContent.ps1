Function Get-ZipContent {
    [Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem') | out-null
    foreach($sourceFile in (Get-ChildItem -filter '*.zip')) {
        [IO.Compression.ZipFile]::OpenRead($sourceFile.FullName).Entries.FullName |
            foreach-object { write-output -inputobject "$sourcefile`:$_" }
    }
}

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Get-ZipContent'
$FuncAlias       = ''
$FuncDescription = 'Reads a ZIP file'
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

