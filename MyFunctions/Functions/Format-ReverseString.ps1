Function Format-ReverseString {
    [cmdletbinding()]
    [outputtype([string])]
    param([string] $s)

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    } #close begin block

    Process {
        [string]::Join('', $s[($s.Length-1)..0])
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close begin block

}

Set-Alias -Name 'ReverseString' -Value 'Format-ReverseString'
