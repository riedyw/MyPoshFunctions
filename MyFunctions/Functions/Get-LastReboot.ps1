Function Get-LastReboot {
    get-eventlog -logname system |
        Where-Object { $_.EventId -eq 6009 } |
        select-object -first 1 |
        select-object -ExpandProperty TimeGenerated
}
