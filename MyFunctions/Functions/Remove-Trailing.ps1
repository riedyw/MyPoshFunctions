Filter Remove-Trailing {

    #region Parameter
    [cmdletbinding()]
    [OutputType([string[]])]
    Param(
        [Parameter(
            Mandatory = $True,
            HelpMessage = 'Enter a ComputerName or IP address',
            Position = 0,
            ParameterSetName = '',
            ValueFromPipeline = $True)
            ]
            [string[]] $String
        )
    #endregion Parameter
    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        foreach ($s in $String) {
            $s | out-string | foreach-object { ($_).TrimEnd() }
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}
