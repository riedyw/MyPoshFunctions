## From PowerShell Cookbook (O'Reilly)
## by Lee Holmes (http://www.leeholmes.com/guide)
##

Function Set-PrivateProfileString {
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

    ## Prepare the parameter types and parameter values for the Invoke-WindowsApi script
    $parameterTypes = [string], [string], [string], [string]
    $parameters = [string] $category, [string] $key, [string] $value, [string] $file

    ## Invoke the API
    [void] (Invoke-WindowsApi "kernel32.dll" ([UInt32]) "WritePrivateProfileString" $parameterTypes $parameters)

} #EndFunction Set-PrivateProfileString

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Set-PrivateProfileString'
    $FuncAlias       = ''
    $FuncDescription = 'Writes to an INI file'
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
