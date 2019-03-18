# Inspired by https://gallery.technet.microsoft.com/on-off-keyboad-lock-keys-6ba9885c

Function Set-Scrolllock {
<#
.SYNOPSIS
    Sets the state of the ScrollLock button. If you pass $true to function it will turn on ScrollLock.
.DESCRIPTION
    Sets the state of the ScrollLock button. If you pass $true to function it will turn on ScrollLock. It first determines the state of the ScrollLock and then acts accordingly.
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
    Changes:     Created function to set on or off the ScrollLock. Requires use of helper function Test-IsScrollLock
.LINK
    New-Object
.LINK
    Wscript.Shell
#>
    [CmdletBinding(ConfirmImpact='Low',SupportsShouldProcess = $true)]
    [OutputType($null)]
    Param(
        [parameter(Mandatory=$false)]
        [bool] $State = $true
    )

    $CurrentState = Test-IsScrollLock
    $ShouldMessage = "ScrollLock currently [$($CurrentState.ToString().ToUpper())] and desired state is [$($State.ToString().ToUpper())]"
    If ($PSCmdlet.ShouldProcess($ShouldMessage))
    {
        if ($CurrentState -eq $true) {
            write-verbose 'ScrollLock is currently ON'
            if (-not $State) {
                write-verbose "Setting ScrollLock to $State"
                $wShell = New-Object -ComObject wscript.shell -ErrorAction Stop
                $wShell.SendKeys("{ScrollLock}")
                remove-variable -name wShell
            }
        } else {
            write-verbose 'ScrollLock is currently OFF'
            if ($State) {
                write-verbose "Setting ScrollLock to $State"
                $wShell = New-Object -ComObject wscript.shell -ErrorAction Stop
                $wShell.SendKeys("{ScrollLock}")
                remove-variable -name wShell
            }
        }
    }
} #EndFunction Set-Scrolllock

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Set-ScrollLock'
    $FuncAlias       = ''
    $FuncDescription = 'Sets the state of ScrollLock'
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
