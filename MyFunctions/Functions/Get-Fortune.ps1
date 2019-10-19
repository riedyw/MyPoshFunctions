Function Get-Fortune {
<#
.SYNOPSIS
    Display a short quote
.DESCRIPTION
    Display a short quote from a file which defaults to: ((Split-Path -path $profile)+'\wisdom.txt') but can be changed with parameter -Path.
.NOTES
    Author:     Bill Riedy
    Version:    1.0
    Date:       2018/03/13
    To Do:      Nothing

    # Sample wisdom.txt file with 3 entries.  Each 'fortune' is delimited by a line consisting of just the pct sign
    # The last fortune in the file should NOT be terminated with a pct sign
    %
    This too will pass.
       - Attar
    %
    Don't think, just do.
       - Horace
    %
    Time is money.
       - Benjamin Franklin
.OUTPUTS
    [string]
.PARAMETER Path
    A path to a filename containing the fortunes. Defaults to: ((Split-Path -path $profile)+'\wisdom.txt')
    Aliased to 'FileName' and 'Fortune'
.Parameter Delimiter
    Indicates delimiter between the individual fortunes. Defaults to "`n%`n" (newline percent newline)
.LINK
    Get-Content
    Get-Random
    Split-Path
#>

    #region Parameter
    [cmdletbinding()]
    [OutputType([string])]
    Param(
        [Parameter()]
        [Alias('FileName','Fortune')]
            [string] $Path = ((Split-Path -path $profile)+'\wisdom.txt'),
        [Parameter()]
            [string] $Delimiter = "`n%`n"
    )
    #endregion Parameter
    write-verbose "Using [$path] for fortune file"
    write-verbose "Delimiter [$Delimiter]"
    (get-content -raw -Path $path) -replace "`r`n", "`n" -split "`n%`n" | Get-Random
    #[System.IO.File]::ReadAllText((Split-Path -path $profile)+'\wisdom.txt') -replace "`r`n", "`n" -split "`n%`n" | Get-Random
} #EndFunction Get-Fortune

Set-Alias -Name 'Fortune' -Value 'Get-Fortune'
