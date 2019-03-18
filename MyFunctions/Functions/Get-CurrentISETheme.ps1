# Source: https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
# get-help about_ISE-Color-Theme-Cmdlets for more information

Function Get-CurrentISETheme {
    #-Create empty ISE Color object array
    $CurrentISEObjects = @()

    #-Get base colors
    $baseClass = @()

    $hash = @{Attribute = "ErrorForegroundColor"; Hex = $psISE.Options.ErrorForegroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ErrorBackgroundColor"; Hex = $psISE.Options.ErrorBackgroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "WarningForegroundColor"; Hex = $psISE.Options.WarningForegroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "WarningBackgroundColor"; Hex = $psISE.Options.WarningBackgroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "VerboseForegroundColor"; Hex = $psISE.Options.VerboseForegroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "VerboseBackgroundColor"; Hex = $psISE.Options.VerboseBackgroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "DebugForegroundColor"; Hex = $psISE.Options.DebugForegroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "DebugBackgroundColor"; Hex = $psISE.Options.DebugBackgroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ConsolePaneBackgroundColor"; Hex = $psISE.Options.ConsolePaneBackgroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ConsolePaneTextBackgroundColor"; Hex = $psISE.Options.ConsolePaneTextBackgroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ConsolePaneForegroundColor"; Hex = $psISE.Options.ConsolePaneForegroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ScriptPaneBackgroundColor"; Hex = $psISE.Options.ScriptPaneBackgroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    $hash = @{Attribute = "ScriptPaneForegroundColor"; Hex = $psISE.Options.ScriptPaneForegroundColor}
    $Object = New-Object -typename PSObject -Property $hash
    $baseClass += $Object

    ForEach ($obj in $baseClass) {
        $ARGBObj = Convert-HexToARGB $obj.Hex

        $tcObj = New-Object -Type PSObject
        $tcObj | Add-Member -MemberType NoteProperty -Name Class -Value "Base"
        $tcObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $obj.Attribute
        $tcObj | Add-Member -MemberType NoteProperty -Name A -Value $ARGBObj.A
        $tcObj | Add-Member -MemberType NoteProperty -Name R -Value $ARGBObj.R
        $tcObj | Add-Member -MemberType NoteProperty -Name G -Value $ARGBObj.G
        $tcObj | Add-Member -MemberType NoteProperty -Name B -Value $ARGBObj.B
        $tcObj | Add-Member -MemberType NoteProperty -Name Hex -Value $obj.Hex
        $CurrentISEObjects += $tcObj
    }

    #-Get TokenColors
    ForEach ($Token in $psISE.Options.TokenColors) {
        [string]$HexValue = $Token.Value

        $ARGBObj = Convert-HexToARGB $HexValue

        $tcObj = New-Object -Type PSObject
        $tcObj | Add-Member -MemberType NoteProperty -Name Class -Value "TokenColors"
        $tcObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $Token.Key
        $tcObj | Add-Member -MemberType NoteProperty -Name A -Value $ARGBObj.A
        $tcObj | Add-Member -MemberType NoteProperty -Name R -Value $ARGBObj.R
        $tcObj | Add-Member -MemberType NoteProperty -Name G -Value $ARGBObj.G
        $tcObj | Add-Member -MemberType NoteProperty -Name B -Value $ARGBObj.B
        $tcObj | Add-Member -MemberType NoteProperty -Name Hex -Value $HexValue
        $CurrentISEObjects += $tcObj
    }

    $ARGBObj = $null

    #-Get ConsoleTokenColors
    ForEach ($Token in $psISE.Options.ConsoleTokenColors) {
        [string]$HexValue = $Token.Value

        $ARGBObj = Convert-HexToARGB $HexValue

        $ctcObj = New-Object -Type PSObject
        $ctcObj | Add-Member -MemberType NoteProperty -Name Class -Value "ConsoleTokenColors"
        $ctcObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $Token.Key
        $ctcObj | Add-Member -MemberType NoteProperty -Name A -Value $ARGBObj.A
        $ctcObj | Add-Member -MemberType NoteProperty -Name R -Value $ARGBObj.R
        $ctcObj | Add-Member -MemberType NoteProperty -Name G -Value $ARGBObj.G
        $ctcObj | Add-Member -MemberType NoteProperty -Name B -Value $ARGBObj.B
        $ctcObj | Add-Member -MemberType NoteProperty -Name Hex -Value $Token.Value
        $CurrentISEObjects += $ctcObj
    }

    $ARGBObj = $null

    #-Get XmlTokenColors
    ForEach ($Token in $psISE.Options.XmlTokenColors) {
        [string]$HexValue = $Token.Value

        $ARGBObj = Convert-HexToARGB $HexValue

        $xtcObj = New-Object -Type PSObject
        $xtcObj | Add-Member -MemberType NoteProperty -Name Class -Value "XmlTokenColors"
        $xtcObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $Token.Key
        $xtcObj | Add-Member -MemberType NoteProperty -Name A -Value $ARGBObj.A
        $xtcObj | Add-Member -MemberType NoteProperty -Name R -Value $ARGBObj.R
        $xtcObj | Add-Member -MemberType NoteProperty -Name G -Value $ARGBObj.G
        $xtcObj | Add-Member -MemberType NoteProperty -Name B -Value $ARGBObj.B
        $xtcObj | Add-Member -MemberType NoteProperty -Name Hex -Value $Token.Value
        $CurrentISEObjects += $xtcObj
    }

    #-Get Font and Name
    $othObj = New-Object -Type PSObject
    $othObj | Add-Member -MemberType NoteProperty -Name Class -Value "Other"
    $othObj | Add-Member -MemberType NoteProperty -Name FontFamily -Value $psISE.Options.FontName
    $othObj | Add-Member -MemberType NoteProperty -Name FontSize -Value $psISE.Options.FontSize
    $CurrentISEObjects += $othObj

    #-Return Output
    $CurrentISEObjects
    <#
        .SYNOPSIS
            Gets current ISE theme

        .DESCRIPTION
            Gets current ISE theme. Hex colors are converted to ARGB
            and added back to the returned objects.

        .EXAMPLE
            PS C:\> $CurrentISETheme = Get-CurrentISETheme

            Assigns Current ISE theme properties to CurrentISETheme

        .NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock
            http://Lifeinpowerhsell.blogspot.com
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
    #>
} #end function Get-CurrentISETheme

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-CurrentISETheme'
    $FuncAlias       = ''
    $FuncDescription = 'Gets current ISE theme.'
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
