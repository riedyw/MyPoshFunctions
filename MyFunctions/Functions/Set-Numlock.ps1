Function Set-Numlock {
<#
.SYNOPSIS
    Sets the state of the NumLock button. If you pass $true to function it will turn on NumLock.
.DESCRIPTION
    Sets the state of the NumLock button. If you pass $true to function it will turn on NumLock. It first determines the state of the NumLock and then acts accordingly.
.PARAMETER State
    A switch parameter to determine if you want the NumLock to be $true or $false.
.EXAMPLE
    Set-NumLock -State
    Will turn on the NumLock
.EXAMPLE
    Set-NumLock -State:$false
    Will turn off the NumLock
.INPUTS
    None
.OUTPUTS
    None
.NOTES
    Author:      Bill Riedy
    Inspiration: # Inspired by https://gallery.technet.microsoft.com/on-off-keyboad-lock-keys-6ba9885c
    Changes:     Created function to set on or off the NumLock. Requires use of helper function Test-IsNumLock
.LINK
    New-Object
.LINK
    Wscript.Shell
#>
    [CmdletBinding(ConfirmImpact='Low',SupportsShouldProcess = $true)]
    [OutputType($null)]
    param(
        [bool] $State = $true
    )

    $CurrentState = Test-IsNumLock
    $ShouldMessage = "NumLock currently [$($CurrentState.ToString().ToUpper())] and desired state is [$($State.ToString().ToUpper())]"
    If ($PSCmdlet.ShouldProcess($ShouldMessage))
    {
        if ($CurrentState -eq $true) {
            write-verbose -Message 'Current state is TRUE'
            if ($State -eq $false) {
                write-verbose -Message 'Setting state to FALSE'
                $wShell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
                $wShell.SendKeys("{NUMLOCK}")
                remove-variable -name wShell
            }
        } else {
            write-verbose -Message 'Current state is FALSE'
            if ($State -eq $true) {
                write-verbose -Message 'Setting state to TRUE'
                $wShell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
                $wShell.SendKeys("{NUMLOCK}")
                remove-variable -name wShell
            }
        }
    }
} #EndFunction Set-Numlock

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Set-Numlock'
    $FuncAlias       = ''
    $FuncDescription = 'Sets the state of the [NumLock].'
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