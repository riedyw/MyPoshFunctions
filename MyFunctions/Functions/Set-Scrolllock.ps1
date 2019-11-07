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
    Set-ScrollLock
    Will turn on the ScrollLock
.EXAMPLE
    Set-ScrollLock -On $false
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
        [bool] $On = $true
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        $CurrentState = Test-IsScrollLock
        $ShouldMessage = "ScrollLock currently [$($CurrentState.ToString().ToUpper())] and desired state is [$($On.ToString().ToUpper())]"
        If ($PSCmdlet.ShouldProcess($ShouldMessage))
        {
            if ($CurrentState -eq $true) {
                write-verbose 'ScrollLock is currently ON'
                if (-not $On) {
                    write-verbose "Setting ScrollLock to OFF"
                    $wShell = New-Object -ComObject wscript.shell -ErrorAction Stop
                    $wShell.SendKeys("{ScrollLock}")
                    remove-variable -name wShell
                }
            } else {
                write-verbose 'ScrollLock is currently OFF'
                if ($On) {
                    write-verbose "Setting ScrollLock to ON"
                    $wShell = New-Object -ComObject wscript.shell -ErrorAction Stop
                    $wShell.SendKeys("{ScrollLock}")
                    remove-variable -name wShell
                }
            }
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #EndFunction Set-Scrolllock
