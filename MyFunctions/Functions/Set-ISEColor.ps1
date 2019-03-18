# Source: https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
# get-help about_ISE-Color-Theme-Cmdlets for more information

Function Set-ISEColor {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$True,ParameterSetName='Cooler',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Cooler,

        [Parameter(Mandatory=$True,ParameterSetName='Warmer',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Warmer,

        [Parameter(Mandatory=$True,ParameterSetName='Greener',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Greener,

        [Parameter(Mandatory=$True,ParameterSetName='Darker',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Darker,

        [Parameter(Mandatory=$True,ParameterSetName='Lighter',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [switch]$Lighter,

        [Parameter(ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [int]$Degree = 20
    )

    Begin{$XmlTheme = Get-CurrentISETheme; $Subtract = $Degree / 2}

    Process {
        $NewColors = @()
        If ($Cooler) {
            ForEach ($Attribute in $XmlTheme) {
                # Rewrite new color values to NewColors
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R - $Subtract) -ge 0) {$var_R = $Attribute.R - $Subtract} Else {$var_R = $Attribute.R}
                    $var_G = $Attribute.G
                    If (($Attribute.B + $Degree) -lt 255) {$var_B = $Attribute.B + $Degree} Else {$var_B = $Attribute.B}

                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"

                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class -Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A -Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R -Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G -Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B -Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex -Value $Hex
                    $NewColors += $xmlObj

                }
            }
        }
        If ($Warmer) {
            ForEach ($Attribute in $XmlTheme) {
                # Write Base Colors Values
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R + $Degree) -lt 255) {$var_R = $Attribute.R + $Degree} Else {$var_R = $Attribute.R}
                    $var_G = $Attribute.G
                    If (($Attribute.B - $Subtract) -ge 0) {$var_B = $Attribute.B - $Subtract} Else {$var_B = $Attribute.B}

                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"

                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class -Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A -Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R -Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G -Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B -Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex -Value $Hex
                    $NewColors += $xmlObj
                }
            }
        }
        If ($Greener) {
            ForEach ($Attribute in $XmlTheme) {
                # Write Base Colors Values
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R - $Subtract) -ge 0) {$var_R = $Attribute.R - ($Subtract / 2)} Else {$var_R = $Attribute.R}
                    If (($Attribute.G + $Degree) -lt 255) {$var_G = $Attribute.G + $Degree} Else {$var_G = $Attribute.G}
                    If (($Attribute.B - $Subtract) -ge 0) {$var_B = $Attribute.B - ($Subtract / 2)} Else {$var_B = $Attribute.B}

                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"

                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class -Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A -Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R -Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G -Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B -Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex -Value $Hex
                    $NewColors += $xmlObj
                }
            }
        }
        If ($Darker) {
            ForEach ($Attribute in $XmlTheme) {
                # Write Base Colors Values
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R - $Degree) -ige 0) {$var_R = $Attribute.R - $Degree} Else {$var_R = $Attribute.R}
                    If (($Attribute.G - $Degree) -ige 0) {$var_G = $Attribute.G - $Degree} Else {$var_G = $Attribute.G}
                    If (($Attribute.B - $Degree) -ige 0) {$var_B = $Attribute.B - $Degree} Else {$var_B = $Attribute.B}

                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"

                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class -Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A -Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R -Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G -Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B -Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex -Value $Hex
                    $NewColors += $xmlObj
                }
            }
        }
        If ($Lighter) {
            ForEach ($Attribute in $XmlTheme) {
                # Write Base Colors Values
                If ($Attribute.Class -ne "Other") {
                    $var_A = $Attribute.A
                    If (($Attribute.R + $Degree) -lt 255) {$var_R = $Attribute.R + $Degree} Else {$var_R = $Attribute.R}
                    If (($Attribute.G + $Degree) -lt 255) {$var_G = $Attribute.G + $Degree} Else {$var_G = $Attribute.G}
                    If (($Attribute.B + $Degree) -lt 255) {$var_B = $Attribute.B + $Degree} Else {$var_B = $Attribute.B}

                    #-Convert ARGB values to Hex
                    $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"

                    #-Create new xml object and add it the the xml object array
                    $xmlObj = New-Object -Type PSObject
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Class -Value $Attribute.Class
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Attribute -Value $Attribute.Attribute
                    $xmlObj | Add-Member -MemberType NoteProperty -Name A -Value $var_A
                    $xmlObj | Add-Member -MemberType NoteProperty -Name R -Value $var_R
                    $xmlObj | Add-Member -MemberType NoteProperty -Name G -Value $var_G
                    $xmlObj | Add-Member -MemberType NoteProperty -Name B -Value $var_B
                    $xmlObj | Add-Member -MemberType NoteProperty -Name Hex -Value $Hex
                    $NewColors += $xmlObj
                }
            }
        }
    }

    End {Set-ISETheme -ThemeObject $NewColors}
    <#
        .SYNOPSIS
            Changes ISE Theme colors according to switch

        .DESCRIPTION
            Changes ISE Theme colors according to switch. It does this
            by adding or subtracting values in the ARGB table

        .PARAMETER Cooler
            Increases blue color values and decreases red by half

        .PARAMETER Warmer
            Increases red color values and decreases blue by half

        .PARAMETER Greener
            Increases green color values and decreases blue and red by a quarter

        .PARAMETER Darker
            Decreases all color values

        .PARAMETER Lighter
            Increases all color values

        .PARAMETER Degree
            Amount to add or subtract. Default value: 20

        .EXAMPLE
            PS C:\> Set-ISEColor -Cooler

            Deletes an ISE theme from the registry

        .NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock
            http://Lifeinpowerhsell.blogspot.com
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
    #>
}#end function Set-ISEColor

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Set-ISEColor'
    $FuncAlias       = ''
    $FuncDescription = 'Changes ISE Theme colors according to switch.'
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
