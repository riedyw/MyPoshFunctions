Function Get-Font {
<#
.SYNOPSIS
    Gets the fonts currently loaded on the system
.DESCRIPTION
    Uses the type System.Windows.Media.Fonts static property SystemFontFamilies,
    to retrieve all of the fonts loaded by the system.  If the Fonts type is not found,
    the PresentationCore assembly will be automatically loaded
.PARAMETER font
    A wildcard to search for font names
.EXAMPLE
    # Get All Fonts
    Get-Font
.EXAMPLE
    # Get All Lucida Fonts
    Get-Font *Lucida*
#>
    [cmdletbinding()]
    param($font = "")
    if (-not ("Windows.Media.Fonts" -as [Type]))
    {
        Add-Type -AssemblyName "PresentationCore"
    }
    #[Windows.Media.Fonts]::SystemFontFamilies |
    #    Where-Object { $_.Source -like "$font" }
    $FontList1 = [Windows.Media.Fonts]::SystemFontFamilies.Source
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    $FontList2 = (New-Object -typename System.Drawing.Text.InstalledFontCollection).Families.Name
#    $FontList = $FontList1 + $FontList2 | sort-object | select-object -unique
# The first method of getting fonts returns values that can NOT be picked from drop down list box of Word.
    $FontList = $FontList2 | sort-object | select-object -unique
    $FontList | where-object { $_ -match "$font" }
} #EndFunction Get-Font

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-Font'
    $FuncAlias       = ''
    $FuncDescription = 'To list all of the fonts'
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
