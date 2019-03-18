# Source: https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
# get-help about_ISE-Color-Theme-Cmdlets for more information

Function Set-ISETheme {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$True,ParameterSetName='FromFile',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$File,

        [Parameter(Mandatory=$True,ParameterSetName='FromReg',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$ThemeName,

        [Parameter(Mandatory=$True,ParameterSetName='FromObj',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [object]$ThemeObject
    )

    Begin{}

    Process {
        #-Determine if a file, object or theme name was passed and retrieve the theme accordingly
        If ($ThemeObject) {
           $xmlObjects = $ThemeObject
        } Else {
            If ($File) {
                $xmlObjects = Get-ISETheme -File $File
            } Else {
                $xmlObjects = Get-ISETheme -ThemeName $ThemeName
            }
        }

        #-Set Base colors
        $xmlObjects | ForEach-Object {
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ErrorForegroundColor")) {$psISE.Options.ErrorForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ErrorBackgroundColor")) {$psISE.Options.ErrorBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("WarningForegroundColor")) {$psISE.Options.WarningForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("WarningBackgroundColor")) {$psISE.Options.WarningBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("VerboseForegroundColor")) {$psISE.Options.VerboseForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("VerboseBackgroundColor")) {$psISE.Options.VerboseBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("DebugForegroundColor")) {$psISE.Options.DebugForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("DebugBackgroundColor")) {$psISE.Options.DebugBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ConsolePaneBackgroundColor")) {$psISE.Options.ConsolePaneBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ConsolePaneTextBackgroundColor")) {$psISE.Options.ConsolePaneTextBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ConsolePaneForegroundColor")) {$psISE.Options.ConsolePaneForegroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ScriptPaneBackgroundColor")) {$psISE.Options.ScriptPaneBackgroundColor = $_.Hex}
            If ($_.Class.Contains("Base") -and $_.Attribute.Contains("ScriptPaneForegroundColor")) {$psISE.Options.ScriptPaneForegroundColor = $_.Hex}
        }

        $xmlObjects | ForEach-Object {
            #-Set TokenColors
            If ($_.Class -eq "TokenColors") {
                $psISE.Options.TokenColors.item($_.Attribute) = $_.Hex
            }

            #-Set ConsoleTokenColors
            If ($_.Class -eq "ConsoleTokenColors") {
                $psISE.Options.ConsoleTokenColors.item($_.Attribute) = $_.Hex
            }

            #-Set XmlTokenColors
            If ($_.Class.Contains("XmlTokenColors")) {
                If ($_.Attribute.Length -gt 2) {
                    $psISE.Options.XmlTokenColors.item($_.Attribute) = $_.Hex #[$_.Attribute] = $_.Hex
                }
            }

            #-Set Font
            If ($_.Class.Contains("Other") -and !$ThemeObject) {
                $psISE.Options.FontName = $_.FontFamily
                $psISE.Options.FontSize = $_.FontSize
            }
        }
    }
    End{}
    <#
        .SYNOPSIS
            Applies ISE theme to current session.

        .DESCRIPTION
            Applies ISE theme to current session.

        .PARAMETER File
            An ISE theme xml filename

        .PARAMETER ThemeName
            The name of an ISE theme stored in the registry

        .EXAMPLE
            PS C:\> Get-FileName | Set-ISETheme

            Gets the ISE theme information from the supplied xml file and assigns it to Theme

        .NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock
            http://Lifeinpowerhsell.blogspot.com
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
    #>
} #end function Set-ISETheme

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Set-ISETheme'
    $FuncAlias       = ''
    $FuncDescription = 'Applies ISE theme to current session.'
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
