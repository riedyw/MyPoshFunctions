Function Add-Help {
<#
.SYNOPSIS
    Adds a template comment based block into the editor in the Powershell ISE.
.DESCRIPTION
    Adds a template comment based block into the editor in the Powershell ISE.
.NOTES
    Author:     Bill Riedy
    Version:    1.0
    Date:       2018/03/13
    To Do:      Nothing at this time.
.EXAMPLE
    Add-Help
.OUTPUTS
    [string]
#>

    [cmdletbinding()]
    [OutputType([string])]
    Param(
    )

$helpText = @"
<#
.SYNOPSIS
    One liner description
.DESCRIPTION
    A longer description of the function
.PARAMETER parameterNoLeading$
    Explanation of parameter
.EXAMPLE
    PS C:\> FunctionName -Argument

    Returns the string

    blah
.EXAMPLE
    PS C:\> FunctionName -Argument -verbose

    Returns the following:

    VERBOSE: Text that was created with Write-Verbose
    blah
.EXAMPLE
    Another example
.NOTES
    NAME: FunctionName
    AUTHOR: $env:username
    LASTEDIT: $(Get-Date)
    VERSION: VersionNumber
    KEYWORDS: key1,key2
.INPUTS
    blah
.OUTPUTS
    [pscustomboject]
    [string]
.LINK
    http://www.ibm.com
.LINK
    http://www.google.com
#>
"@

#Requires -Version 2.0

$psise.CurrentFile.Editor.InsertText($helpText)
} #EndFunction add-help

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Add-Help'
$FuncAlias       = ''
$FuncDescription = 'Adds a template comment based block into the editor in the Powershell ISE.'
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
