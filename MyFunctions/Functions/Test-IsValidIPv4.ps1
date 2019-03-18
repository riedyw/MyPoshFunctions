Function Test-IsValidIPv4 {
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
    [Outputtype([bool])]
    Param (
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
        [Alias("IP")]
        [string] $IPAddress
    )
    Process {
        Try {
            $check = [ipaddress] $IPAddress
            # added check below to cover issue if enter only 3 octets
            # [ipaddress] "10.1.4" resolves to "10.1.0.4"
            if ($IPAddress -eq $check) {
                Write-Output -inputobject $True
            } else {
                Write-Output -inputobject $False
            }
        } Catch {
            Write-Output -inputobject $False
        }
    }
} #EndFunction Test-IsValidIP

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Test-IsValidIPv4'
    $FuncAlias       = ''
    $FuncDescription = 'Verifies if passed parameter is a valid IP v4 address'
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

