function Expand-String {
    [cmdletbinding()]
    [outputtype([string])]
    param(
       [Parameter(Mandatory=$true,Position=0,ValueFromPipeline=$true)]
       [System.String] $Value,

       [switch] $EnvironmentVariable
   )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    } #close begin block

    process {
       if($EnvironmentVariable) {
          [System.Environment]::ExpandEnvironmentVariables($Value)
       }
       else
       {
          $ExecutionContext.InvokeCommand.ExpandString($Value)
       }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close end block

} #End function Expand-String
