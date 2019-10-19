Function Start-StopwatchCommand {
    [CmdletBinding()]
    param ( [ScriptBlock] $ScriptBlock )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        & $ScriptBlock
        $stopwatch.Stop()
        Set-Variable -name Elapsed -value $stopwatch.Elapsed -scope 1
        Write-Verbose -message ('Setting value of $Elapsed to ' + $Elapsed.TotalSeconds.ToString() + ' seconds')
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }
}
