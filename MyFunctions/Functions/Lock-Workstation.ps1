function Lock-Workstation {
<#
.SYNOPSIS
    Locks the workstation
.DESCRIPTION
    Locks the workstation and requires authentication afterwards
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    Lock-Workstation

    Would lock the workstation
.LINK
    about_Properties
#>
    rundll32.exe user32.dll,LockWorkStation
}
