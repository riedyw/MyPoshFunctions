# Source: https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
# get-help about_ISE-Color-Theme-Cmdlets for more information

Function Remove-ISETheme {
    [cmdletbinding()]
    Param(
        [Parameter(ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$ThemeName
    )

    Begin{}

    Process {
        Remove-ItemProperty HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes -Name $ThemeName
    }

    End{}
    <#
        .SYNOPSIS
            Deletes an ISE theme from the ISE.

        .DESCRIPTION
            Deletes an ISE theme from the ISE.

        .PARAMETER ThemeName
            An ISE theme name

        .EXAMPLE
            PS C:\> Remove-ISETheme "Monokai"

            Deletes an ISE theme from the ISE

        .NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock
            http://Lifeinpowerhsell.blogspot.com
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
    #>
} #end function Remove-ISETheme

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Remove-ISETheme'
    $FuncAlias       = ''
    $FuncDescription = 'Deletes an ISE theme from the ISE.'
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

