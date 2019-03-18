Function Test-IsNumeric {
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
        [Alias("Number")]
        [string] $NumString
    )
    Process {
        $NumString = $NumString.Trim()
        if (($NumString -eq '') -or ($NumString -eq $null)) {
            $false
        } else {
            Try {
                0 + $NumString | Out-Null
                #[Helpers]::IsNumeric($NumString)
                #[DateTime]$DateString | Out-Null
                Write-Output -inputobject $True
            } Catch {
                Write-Output -inputobject $False
            }
        }
    }
} #EndFunction Test-IsNumeric

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Test-IsNumeric'
    $FuncAlias       = ''
    $FuncDescription = 'Determines if what was passed is numeric'
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

