Function Set-Capslock {
<#
.SYNOPSIS
    Sets the state of the CapsLock button. If you pass $true to function it will turn on CapsLock.
.DESCRIPTION
    Sets the state of the CapsLock button. If you pass $true to function it will turn on CapsLock. It first determines the state of the CapsLock and then acts accordingly.
.PARAMETER State
    A switch parameter to determine if you want the CapsLock to be $true or $false.
.EXAMPLE
    Set-CapsLock
    Will turn on the CapsLock
.EXAMPLE
    Set-CapsLock -On $false
    Will turn off the CapsLock
.INPUTS
    None
.OUTPUTS
    None
.NOTES
    Author:      Bill Riedy
    Inspiration: # Inspired by https://gallery.technet.microsoft.com/on-off-keyboad-lock-keys-6ba9885c
    Changes:     Created function to set on or off the CapsLock. Requires use of helper function Test-IsCapsLock
.LINK
    New-Object
.LINK
    Wscript.Shell
#>
    [CmdletBinding(ConfirmImpact='Low',SupportsShouldProcess = $true)]
    [OutputType($null)]
    param(
        [bool] $On = $true
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        $CurrentState = Test-IsCapsLock
        $ShouldMessage = "CapsLock currently [$($CurrentState.ToString().ToUpper())] and desired state is [$($On.ToString().ToUpper())]"
        If ($PSCmdlet.ShouldProcess($ShouldMessage))
        {
            if ($CurrentState -eq $true) {
                write-verbose -Message 'Current state is ON'
                if (-not $On) {
                    write-verbose -Message 'Setting state to OFF'
                    $wShell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
                    $wShell.SendKeys("{CapsLock}")
                    remove-variable -name wShell
                }
            } else {
                write-verbose -Message 'Current state is OFF'
                if ($On) {
                    write-verbose -Message 'Setting state to ON'
                    $wShell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
                    $wShell.SendKeys("{CapsLock}")
                    remove-variable -name wShell
                }
            }
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #EndFunction Set-Capslock
