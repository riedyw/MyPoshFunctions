# Source: https://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
# get-help about_ISE-Color-Theme-Cmdlets for more information

Function Convert-HexToARGB {
    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$True)]
        [string]$Hex_Val
    )

    Begin{}

    Process {
        #-Convert values
        $A = [Convert]::ToInt32($Hex_Val.substring(1, 2), 16)
        $R = [Convert]::ToInt32($Hex_Val.substring(3, 2), 16)
        $G = [Convert]::ToInt32($Hex_Val.substring(5, 2), 16)
        $B = [Convert]::ToInt32($Hex_Val.substring(7, 2), 16)

        #-Output value object
        $Obj = New-Object -Type PSObject
        $Obj | Add-Member -MemberType NoteProperty -Name A -Value $A
        $Obj | Add-Member -MemberType NoteProperty -Name R -Value $R
        $Obj | Add-Member -MemberType NoteProperty -Name G -Value $G
        $Obj | Add-Member -MemberType NoteProperty -Name B -Value $B
        $Obj
    }

    End{}
    <#
        .SYNOPSIS
            Converts Hex to ARGB values

        .DESCRIPTION
            Converts Hex to ARGB values. Hex values are needed to apply ISE colors in script

        .PARAMETER Hex_Val
            An 8 character Hex value

        .EXAMPLE
            PS C:\> $ARGB = Convert-HexToARGB $HexValue

            Assigns converted hex value to ARGB variable

        .NOTES
            Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock
            http://Lifeinpowerhsell.blogspot.com
            http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e
    #>
} #end function Convert-HexToARGB

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Convert-HexToARGB'
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

