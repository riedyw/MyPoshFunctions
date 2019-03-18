# Source: https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
# get-help about_ISE-Color-Theme-Cmdlets for more information

Function Get-ISETheme {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$True,ParameterSetName='fromfile',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$File,

        [Parameter(Mandatory=$True,ParameterSetName='fromreg',ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        [string]$ThemeName
    )

    Begin{}

    Process {
        #-Determine proper xml assignment according to whether an xml file was passed or a registry Theme
        If ($File) {
            [xml] $xml = get-content -path $File
        } Else {
            $Theme = Get-ItemProperty -path HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes -Name $ThemeName
            $Theme | ForEach-Object {
                $xml = $_.$ThemeName
            }
        }

        #-Create xml object array to store xml values from the Theme
        $xmlObjects = @()

        $x = 0
        $xml.StorableColorTheme.Keys.String | ForEach-Object {
            #-Set class according to presence of a "\" in the attribute name
            If ($_.Contains("\")) {
                $Class = $_.Substring(0,$_.IndexOf('\'))
                $Attribute = $_.Substring($_.IndexOf('\') + 1)
            } Else {
                $Class = "Base"
                $Attribute = $_
            }

            #-Get the ARGB values from the xml
            $var_A = $xml.StorableColorTheme.Values.Color[$x].A
            $var_R = $xml.StorableColorTheme.Values.Color[$x].R
            $var_G = $xml.StorableColorTheme.Values.Color[$x].G
            $var_B = $xml.StorableColorTheme.Values.Color[$x].B

            #-Convert ARGB values to Hex
            $Hex = Convert-ARGBToHex "$var_A,$var_R,$var_G,$var_B"

            #-Create new xml object and add it the the xml object array
            $xmlObj = New-Object -Type PSObject
            $xmlObj | Add-Member -MemberType NoteProperty -Name 'Class'     -Value $Class
            $xmlObj | Add-Member -MemberType NoteProperty -Name 'Attribute' -Value $Attribute
            $xmlObj | Add-Member -MemberType NoteProperty -Name 'A'         -Value $var_A
            $xmlObj | Add-Member -MemberType NoteProperty -Name 'R'         -Value $var_R
            $xmlObj | Add-Member -MemberType NoteProperty -Name 'G'         -Value $var_G
            $xmlObj | Add-Member -MemberType NoteProperty -Name 'B'         -Value $var_B
            $xmlObj | Add-Member -MemberType NoteProperty -Name 'Hex'       -Value $Hex
            $xmlObjects += $xmlObj
            $x = $x + 1
        }

        #-Get Font
        $xmlObj = New-Object -Type PSObject
        $xmlObj | Add-Member -MemberType NoteProperty -Name 'Class'      -Value 'Other'
        $xmlObj | Add-Member -MemberType NoteProperty -Name 'Name'       -Value $xml.StorableColorTheme.Name
        $xmlObj | Add-Member -MemberType NoteProperty -Name 'FontFamily' -Value $xml.StorableColorTheme.FontFamily
        $xmlObj | Add-Member -MemberType NoteProperty -Name 'FontSize'   -Value $xml.StorableColorTheme.FontSize
        $xmlObjects += $xmlObj

        #-Return xml object array
        $xmlObjects
    }

    End{}
    <#
        .SYNOPSIS
            Gets an ISE theme

        .DESCRIPTION
            Gets an ISE them from either the registry or xml file

        .PARAMETER File
            An ISE theme xml filename

        .PARAMETER ThemeName
            The name of an ISE theme stored in the registry

        .EXAMPLE
            PS C:\> $Theme = Get-FileName | Get-ISETheme

            Gets the ISE theme information from the supplied xml file and assigns it to Theme

        .NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock
            http://Lifeinpowerhsell.blogspot.com
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
    #>
} #end function Get-ISETheme

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-ISETheme'
    $FuncAlias       = ''
    $FuncDescription = 'Gets an ISE them from either the registry or xml file.'
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
