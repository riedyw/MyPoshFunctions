Function Show-RegistryDataType {
<#
.SYNOPSIS
    Shows registry datatype
.DESCRIPTION
    Shows registry datatype
.NOTES
    Author:     Bill Riedy
#>

    [cmdletbinding()]
    Param ()

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        [Microsoft.Win32.RegistryValueKind] | get-member -static -type *property* |
            where-object { (($_.name -ne "Unknown") -and ($_.name -ne "None"))} |
            select-object -ExpandProperty name

    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}
