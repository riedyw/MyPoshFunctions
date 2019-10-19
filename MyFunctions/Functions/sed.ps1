Filter sed {
<#
.SYNOPSIS
    A simple text filter to replace strings
.DESCRIPTION
    A simple text filter to replace strings
.PARAMETER Before
    The string searching for
.PARAMETER After
    The string to replace it with
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    'Hello There' | sed 'Hello' 'Goodbye'
    Would return
    Goodbye There
.OUTPUTS
    [string]
.LINK
    about_Functions
#>

#region Parameter
    [cmdletbinding()]
    [OutputType([string])]
    Param(
        [Parameter(Mandatory = $True, HelpMessage = 'Enter a string to search for', Position = 0, ValueFromPipeline = $False)]
        [string] $Before,

        [Parameter(Mandatory = $True, HelpMessage = 'Enter a string to replace it with', Position = 1, ValueFromPipeline = $False)]
        [string] $After

    )
#endregion Parameter

    foreach-object {
        $_ -replace $before,$after
    }
}
