Function Compare-ObjectProperty {
<#
.SYNOPSIS
    Compares two objects property by property.
.DESCRIPTION
    Compares two objects property by property. when a simple Compare-Object does not find equivalence, for instance when the order of properties is different between the 2 objects.
.PARAMETER ReferenceObject
    The first object to compare
.PARAMETER DifferenceObject
    The second object to compare
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    Compare-ObjectProperty -ReferenceObject $object1 -DifferenceObject $object2
.OUTPUTS
    [psobject]
.LINK
    Compare-Object
#>
#region Parameters
    [cmdletbinding()]
    [outputtype([psobject])]
    Param(
        [Parameter(Mandatory=$True,HelpMessage='First object to compare',Position=0)]
        [PSObject] $ReferenceObject,

        [Parameter(Mandatory=$True,HelpMessage='Second object to compare',Position=1)]
        [PSObject]$DifferenceObject
    )
#endregion Parameters

    $objprops = $ReferenceObject | Get-Member -MemberType Property,NoteProperty | foreach-object Name
    $objprops += $DifferenceObject | Get-Member -MemberType Property,NoteProperty | foreach-object Name
    $objprops = $objprops | Sort-Object | Select-Object -Unique
    $diffs = @()
    foreach ($objprop in $objprops) {
        $diff = Compare-Object $ReferenceObject $DifferenceObject -Property $objprop
        if ($diff) {
            $diffprops = @{
                PropertyName=$objprop
                RefValue=($diff | where-object {$_.SideIndicator -eq '<='} | foreach-object $($objprop))
                DiffValue=($diff | where-object {$_.SideIndicator -eq '=>'} | foreach-object $($objprop))
            }
            $diffs += New-Object PSObject -Property $diffprops
        }
    }
    if ($diffs) {return ($diffs | Select-Object -Property PropertyName,RefValue,DiffValue)}
}

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Compare-ObjectProperty'
$FuncAlias       = ''
$FuncDescription = 'Function to compare the properties of one object versus another'
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
