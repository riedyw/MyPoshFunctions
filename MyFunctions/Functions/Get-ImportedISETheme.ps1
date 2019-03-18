# Source: https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
# get-help about_ISE-Color-Theme-Cmdlets for more information

Function Get-ImportedISETheme {
    #-Get theme values from registry
    $Themes = Get-Item -path HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes | Select-Object -ExpandProperty Property

    #-Get name and xml content and return it as an object
    $Themes | ForEach-Object {
        $ThemeName = $_
        $Theme = Get-ItemProperty -path HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes -Name $ThemeName
        $Theme | ForEach-Object {
            $xml = $_.$ThemeName
        }

        $hash = @{ ThemeName = $_; XML = $xml }
        $Object = New-Object -typename PSObject -Property $hash
        $Object

    }
    <#
        .SYNOPSIS
            Returns imported themes.

        .DESCRIPTION
            Returns imported themes from the registry

        .EXAMPLE
            PS C:\> $Themes = Get-ImportedISETheme

            Gets the imported ISE themes from the registry and assigns it to Themes

        .NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock
            http://Lifeinpowerhsell.blogspot.com
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
    #>
} #end function Get-ImportedISETheme

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-ImportedISETheme'
    $FuncAlias       = ''
    $FuncDescription = 'Returns imported themes.'
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
