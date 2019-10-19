Function Switch-Mute (){
<#
.SYNOPSIS
    Toggles speaker mute
.DESCRIPTION
    Toggles speaker mute
.NOTES
    Author:     Bill Riedy
#>

    [cmdletbinding()]
    Param ()

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        $wshShell = new-object -com wscript.shell;$wshShell.SendKeys([char]173)
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}
