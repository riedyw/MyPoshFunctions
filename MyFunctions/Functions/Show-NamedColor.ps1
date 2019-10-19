Function Show-NamedColor {
<#
.SYNOPSIS
    Shows all named colors
.DESCRIPTION
    Shows all named colors
.NOTES
    Author:     Bill Riedy
#>
    #region Parameter
    [cmdletbinding()]
    [OutputType([psobject])]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = $True) ]
            [string[]] $ColorName = '*',
        [Parameter()]
            [switch] $ExcludeEmpty
        )
    #endregion Parameter

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        write-verbose 'Determining names of colors'
        [System.Drawing.Color] | get-member -type *property -static | findstr /i "Property" |
            foreach-object -begin { $result1=@()} -process { $tmp = $_ -split "\s+" ; $result1 += $tmp[0] } -end { }

        write-verbose "There are $($result1.count) named system colors."
        if ($ExcludeEmpty) {
            write-verbose 'Excluding empty'
            $result1 = $result1 | where-object { $_ -ne 'Empty' }
        }

        if (-not $ColorName) {
            $result1 | foreach-object { [system.drawing.color]::$_ } |
            select-object -property Name, IsKnownColor, IsNamedColor, IsSystemColor, IsEmpty, R, G, B, A
        }
        else {
            $result2 = @()
            foreach ($color in $ColorName) {
                $result2 += $result1 | where-object { $_ -like "*$color*" } | foreach-object { [system.drawing.color]::$_ }
            }
            write-verbose "There are $($result2.count) named system colors in the result set."
            $result2 | select-object -property Name, IsKnownColor, IsNamedColor, IsSystemColor, IsEmpty, R, G, B, A
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}