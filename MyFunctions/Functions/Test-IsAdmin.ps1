#source https://blogs.technet.microsoft.com/heyscriptingguy/2015/07/29/use-function-to-determine-elevation-of-powershell-console/
# inspired by above, made some minor modifications like proving more output, making it an advanced function.

Function Test-IsAdmin {
<#
.SYNOPSIS
    blah
.DESCRIPTION
    blah blah
.EXAMPLE
    Test-IsAdmin
    
    Would return the following if the prompt was elevated.
    $True
.EXAMPLE
    Test-IsAdmin -Verbose
    
    Would return the following if the prompt was elevated.
    VERBOSE: You have Administrator rights.
    True
#>

    [cmdletbinding()]
    [outputtype([bool])]
    Param()

    If ( -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Write-Verbose -message "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
        Write-output -inputobject $False
    } Else {
        Write-Verbose -message "You have Administrator rights."
        Write-output -inputobject $True
    }
} #EndFunction Test-IsAdmin

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Test-IsAdmin'
    $FuncAlias       = ''
    $FuncDescription = 'Determines if running an elevated prompt'
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
