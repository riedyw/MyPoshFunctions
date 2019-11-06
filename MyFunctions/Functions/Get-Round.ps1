# Inspired by: https://stackoverflow.com/questions/41700200/how-to-correctly-round-numbers-in-powershell

function Get-Round {
<#
.SYNOPSIS
    Correctly rounds a number. Optionally can specify the number of digits to round to.
.DESCRIPTION
    Correctly rounds a number. Optionally can specify the number of digits to round to. Default behavior for [math]::Round is to round [System.MidpointRounding]::ToEven so 2.5 would round to 2 as opposed to expected behavior of rounding to 3.
.PARAMETER Number
    The number to round.
.PARAMETER Digit
    The number of digits after the decimal point. Defaults to 0.
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    Get-Round 2.5

    Returns a properly rounded value of 3.
.EXAMPLE
    Get-Round 2.45 -Digit 1

    Returns a properly rounded value of 2.5.
.OUTPUTS
    [double]
#>

    [cmdletbinding()]
    [OutputType([double])]
    Param (
        [parameter(Mandatory=$True,Position=0)]
        [double] $Number,

        [parameter()]
        [double] $Digit = 0

    )

    [double] [math]::Round($Number, $Digit, [System.MidpointRounding]::AwayFromZero)

}
