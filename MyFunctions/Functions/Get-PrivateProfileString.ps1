## From PowerShell Cookbook (O'Reilly)
## by Lee Holmes (http://www.leeholmes.com/guide)
##

Function Get-PrivateProfileString {

    ##############################################################################
    ##
    ## Get-PrivateProfileString.ps1
    ##
    ## Get an entry from an INI file.
    ##
    ## ie:
    ##
    ##  PS >Get-PrivateProfileString.ps1 C:\winnt\system32\ntfrsrep.ini text DEV_CTR_24_009_HELP
    ##
    ##############################################################################

    param(
        $file,
        $category,
        $key)

    ## Prepare the parameter types and parameter values for the Invoke-WindowsApi script
    $returnValue = New-Object -typename System.Text.StringBuilder -Argumentlist 500
    $parameterTypes = [string], [string], [string], [System.Text.StringBuilder], [int], [string]
    $parameters = [string] $category, [string] $key, [string] "",

       [System.Text.StringBuilder] $returnValue, [int] $returnValue.Capacity, [string] $file

    ## Invoke the API
    [void] (Invoke-WindowsApi "kernel32.dll" ([UInt32]) "GetPrivateProfileString"   $parameterTypes $parameters)

    ## And return the results
    write-output -inputobject $returnValue.ToString()
} #EndFunction Get-PrivateProfileString
