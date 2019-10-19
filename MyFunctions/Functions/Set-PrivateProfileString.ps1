## From PowerShell Cookbook (O'Reilly)
## by Lee Holmes (http://www.leeholmes.com/guide)
##

Function Set-PrivateProfileString {
<#
.SYNOPSIS
    Sets a value for single INI setting
.DESCRIPTION
    Sets a value for single INI setting
.PARAMETER File
    The explicit full path to the file
.PARAMETER Category
    The section of the INI file
.PARAMETER Key
    The key in the particular section
.PARAMETER Value
    The value you wish to set it to
.NOTES
    Author:     Bill Riedy
#>

    ##############################################################################
    ##
    ## Set-PrivateProfileString.ps1
    ##
    ## Set an entry from an INI file.
    ##
    ## ie:
    ##
    ##  PS >copy C:\winnt\system32\ntfrsrep.ini c:\temp\
    ##  PS >Set-PrivateProfileString.ps1 C:\temp\ntfrsrep.ini text `
    ##  >> DEV_CTR_24_009_HELP "New Value"
    ##  >>
    ##  PS >Get-PrivateProfileString.ps1 C:\temp\ntfrsrep.ini text DEV_CTR_24_009_HELP
    ##  New Value
    ##  PS >Set-PrivateProfileString.ps1 C:\temp\ntfrsrep.ini NEW_SECTION `
    ##  >> NewItem "Entirely New Value"
    ##  >>
    ##  PS >Get-PrivateProfileString.ps1 C:\temp\ntfrsrep.ini NEW_SECTION NewItem
    ##  Entirely New Value
    ##
    ##############################################################################
    [cmdletbinding()]
    param(
        $file,
        $category,
        $key,
        $value)

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        ## Prepare the parameter types and parameter values for the Invoke-WindowsApi script
        $parameterTypes = [string], [string], [string], [string]
        $parameters = [string] $category, [string] $key, [string] $value, [string] $file

        ## Invoke the API
        [void] (Invoke-WindowsApi "kernel32.dll" ([UInt32]) "WritePrivateProfileString" $parameterTypes $parameters)
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }


} #EndFunction Set-PrivateProfileString
