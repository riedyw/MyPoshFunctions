# Inspired by https://gallery.technet.microsoft.com/on-off-keyboad-lock-keys-6ba9885c

Function Test-IsScrollLock {
<#
.SYNOPSIS
Sets the state of the ScrollLock button. If you pass $true to function it will turn on
ScrollLock.
.DESCRIPTION
Sets the state of the ScrollLock button. If you pass $true to function it will turn on
ScrollLock. It first determines the state of the ScrollLock and then acts accordingly.
.PARAMETER State
A switch parameter to determine if you want the ScrollLock to be $true or $false.
.EXAMPLE
Set-ScrollLock -State
Will turn on the ScrollLock
.EXAMPLE
Set-ScrollLock -State:$false
Will turn off the ScrollLock
.INPUTS
None
.OUTPUTS
None
.NOTES
Author:      Bill Riedy
Inspiration: # Inspired by https://gallery.technet.microsoft.com/on-off-keyboad-lock-keys-6ba9885c
Changes:     Created function to set on or off the ScrollLock. Requires use of helper
             function Test-IsScrollLock
#>

    [CmdletBinding()]
    [OutputType([bool])]
    Param()
    write-verbose -Message 'Determining the state of [ScrollLock]'
    [System.Windows.Forms.Control]::IsKeyLocked('Scroll')
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Test-IsScrollLock'
    $FuncAlias       = ''
    $FuncDescription = 'Determines the state of ScrollLock'
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
