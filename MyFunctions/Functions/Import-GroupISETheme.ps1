# Source: https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
# get-help about_ISE-Color-Theme-Cmdlets for more information

Function Import-GroupISETheme {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory=$True)] [ValidateNotNullOrEmpty()]
        [string] $Directory
    )

    get-childitem -Path $Directory -Filter *.ps1xml | select-object -property fullname | Import-ISEThemeFile
}
