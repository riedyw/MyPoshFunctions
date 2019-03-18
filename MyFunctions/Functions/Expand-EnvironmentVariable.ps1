# inspired by: https://stackoverflow.com/questions/45953778/how-to-use-powershell-to-extract-data-from-dll-or-exe-files

function Expand-EnvironmentVariable {
    #region Parameter
    [cmdletbinding(
        DefaultParameterSetName = '',
        ConfirmImpact = 'low'
    )]
    [OutputType([string[]])]
    Param(
        [Parameter(
            Mandatory = $True,
            HelpMessage = 'Enter a ComputerName or IP address',
            Position = 0,
            ParameterSetName = '',
            ValueFromPipeline = $True)
            ]
            [string[]] $String,
        [Parameter(
            Position = 1,
            HelpMessage = 'Enter an integer port number (1-65535)',
            ParameterSetName = '')]
            [switch] $IncludeOriginal
        )
    #endregion Parameter

    begin {
        Write-Verbose "Starting $($myinvocation.mycommand)"
        [System.Collections.ArrayList] $returnVal = @()
    }
    process {
        foreach ($s in $String) {
            write-verbose $s
            $ExpandedString = [Environment]::ExpandEnvironmentVariables($s)
            if ($IncludeOriginal) {
                $obj = new-object psobject -Property ([ordered] @{ Original = $s; ExpandedString = $ExpandedString})
                write-verbose $obj
            } else {
                $obj = $ExpandedString
            }
            [void] $returnVal.add($obj)
        }
    }
    end {
        write-verbose $returnVal.count
        if ($IncludeOriginal) {
            $returnVal #| select-object Original, StringValue
        } else {
            $returnVal
        }
    }
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Expand-EnvironmentVariable'
    $FuncAlias       = ''
    $FuncDescription = 'Writes variable out to INI file'
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
