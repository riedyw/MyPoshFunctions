Function Start-RecordSession {
    # Inspired by post https://groups.google.com/forum/#!topic/microsoft.public.exchange.admin/0z7249mOuzA
    # create a uniqely named transcript file for this session. It will have format of:
    # PS-date-pid.LOG
    # where
    # date is in YYYYMMDD format
    # pid is the process id of the currently running powershell console.
    # creates it in the LOGS directory under persons userprofile directory.
    # sets global and environment variables so Stop-RecordSession can know the name of the transcript file
    $logDate = Get-Date -f "yyyyMMdd"
    $logPath = $env:userprofile + "\logs"
    if (-Not (Test-Path -path $logPath)) {
        mkdir $logPath
    }
    $logFile = $logPath + "\PS-" + $logDate + "-" + $PID + ".log"
    $global:PSLOG = "$logFile"
    $env:PSLOG = "$logfile"
    # $global:Transcript = "$logfile"
    if (-Not (Test-Path -path $logFile)) {
        New-Item -path $logFile -Type File | Out-Null
    }
    Start-Transcript -Path "$logFile" -append -force | Out-Null
} #EndFunction Start-RecordSession

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Start-RecordSession'
    $FuncAlias       = ''
    $FuncDescription = 'Starts a transcript'
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
