Function Show-SpecialFolder {
<#
.SYNOPSIS
    Shows special folder names
.DESCRIPTION
    Shows special folder names
.NOTES
    Author:     Bill Riedy
#>

    [cmdletbinding()]
    Param (

        [switch] $IncludeLocations
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        $SpecialFolders = [System.Enum]::GetNames([System.Environment+SpecialFolder]) | sort-object
        if (-not $IncludeLocations) {
            write-output $SpecialFolders
        }
        else {
            $SpecialFolders | foreach-object {
                [PSCustomObject] @{
                    SpecialFolder = $_.tostring()
                    Location      = [Environment]::GetFolderPath($_)
                }
            }
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #endfunction Enum-SpecialFolders
