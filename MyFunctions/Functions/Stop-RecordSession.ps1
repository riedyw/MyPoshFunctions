Function Stop-RecordSession {
    Stop-Transcript
    $logFile = $global:PSLOG
    $logFile_Ascii = $logFile + "-Ascii"
    "Stop-RecordSession : Running custom Stop-RecordSession function to Stop-Transcript and convert it to Ascii" | Out-File -FilePath $logFile -Append -Encoding Ascii
    "Stop-RecordSession : Any further commands not recorded" | Out-File -FilePath $logFile -Append -Encoding Ascii
    $(Get-Content -path $logFile) -replace "`0", "" | Out-File -FilePath $logFile_Ascii -Encoding Ascii
    Remove-Item -path $logFile
    Rename-Item -path $logFile_Ascii -newname $logFile
} #EndFunction Stop-RecordSession

#region Metadata
# These variables are used to set the Description property of the function.

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue

$FuncName        = 'Stop-RecordSession'
$FuncAlias       = ''
$FuncDescription = 'Stops a transcript'

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

# Setting the Description property of the function.
(get-childitem -Path Function:$FuncName).set_Description($FuncDescription)

#endregion Metadata

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Stop-RecordSession'
    $FuncAlias       = ''
    $FuncDescription = 'Stops a transcript'
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
