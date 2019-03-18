## From PowerShell Cookbook (O'Reilly)
## by Lee Holmes (http://www.leeholmes.com/guide)
##

Function Get-PrivateProfileSectionNames {

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
    [cmdletbinding()]
    param(
        $file)

    ## Prepare the parameter types and parameter values for the Invoke-WindowsApi script
#    $returnValue = New-Object -typename System.Text.StringBuilder -Argumentlist 1000
#    $parameterTypes = [string[]], [int], [string]
#    $parameters = [string[]] $returnValue, [int] $returnValue.Capacity, [string] $file

    $returnValue = New-Object -typename System.Text.StringBuilder -Argumentlist 500
    $parameterTypes = [System.Text.StringBuilder], [int], [string]
    $parameters = [System.Text.StringBuilder] $returnValue, [int] $returnValue.Capacity, [string] $file
    
    ## Invoke the API
    [void] (Invoke-WindowsApi "kernel32.dll" ([UInt32]) "GetPrivateProfileSectionNames"   $parameterTypes $parameters)

    write-verbose ($returnValue.gettype())
    $returnValue = $returnValue -replace "`0", "`n"
    ## And return the results
    write-output -inputobject $returnValue.ToString()
} #EndFunction Get-PrivateProfileString

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-PrivateProfileSectionNames'
    $FuncAlias       = ''
    $FuncDescription = 'Gets a setting from an INI file'
    $FuncVarName     = ''
    if (-not (test-path -Path Variable:AliasesToExport))
    {
        $AliasesToExport = @()
    }
    if (-not (test-path -Path Variable:VariablesToExport))
    {
        $VariablesToExport = @()
    }
    if ($FuncAlias)
    {
        set-alias -Name $FuncAlias -Value $FuncName
        $AliasesToExport += $FuncAlias
    }
    if ($FuncVarName)
    {
        $VariablesToExport += $FuncVarName
    }
    # Setting the Description property of the function.
    (get-childitem -Path Function:$FuncName).set_Description($FuncDescription)
#endregion Metadata
