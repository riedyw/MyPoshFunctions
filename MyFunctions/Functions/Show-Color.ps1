Function Show-Color {
<#
.SYNOPSIS
    Show-Color displays the names and values of the console colors
.DESCRIPTION
    Show-Color displays the names and values of the console colors
.NOTES
    Author:     Bill Riedy
#>

    [cmdletbinding()]
    Param ()

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        [Enum]::GetValues([System.ConsoleColor]) |
            select-object @{"Name" = "Name"; "Expression" = {$_}},
                @{"Name" = "Dec"; "Expression" = {[Int] $_}},
                @{"Name" = "Hex"; "Expression" = {"0x{0:X1}" -f [Int] $_}}
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }


}
