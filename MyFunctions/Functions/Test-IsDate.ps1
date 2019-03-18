Function Test-IsDate {
<#
.SYNOPSIS
    blah
.DESCRIPTION
    blah blah
.EXAMPLE
    Test-IsCapsLock
.EXAMPLE
    Test-IsCapsLock -Verbose
#>
    [CmdletBinding()]
    [OutputType([bool])]
    Param (
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
        [Alias("date")]
        [string]$DateString
    )
    Process {
        Try {
            [DateTime]$DateString | Out-Null
            Write-Output -inputobject $True
        } Catch {
            Write-Output -inputobject $False
        }
    }
} #EndFunction Test-IsDate

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Test-IsDate'
    $FuncAlias       = ''
    $FuncDescription = 'Tests if passed parameter can resolve to a datetime datatype'
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


