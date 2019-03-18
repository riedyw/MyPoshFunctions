Function Get-StaticProperty {
# Get-EnumValue -enum "System.Diagnostics.Eventing.Reader.StandardEventLevel"
    [CmdletBinding()]
    Param(
        [string[]] $TypeName,

        [switch] $IncludeTypeName
    )
    $oldEA = $ErrorActionPreference
    $ErrorActionPreference = "Stop"
    $return = [System.Collections.ArrayList] @()
    foreach ($curTypeName in $TypeName) {
        $curExpandTypeName = ([type] $curTypeName) | get-member -static | select-object typename | sort-object -Unique | select-object -expand TypeName
        $StaticProp = get-member -type *property -static -inputobject ([type] $curTypeName) | select-object -expand name
        $staticProp | foreach-object -process {
            $tmpValue = (([type] $curTypeName)::$_.value__)
            if ($tmpValue -eq $null) {
                $tmpValue = (([type] $curTypeName)::$_)
            }
            if ($IncludeTypeName) {
                $prop = [ordered] @{ 
                    SpecifiedType = $curTypeName
                    ExpandedType = $curExpandTypeName
                    Name = $_
                    Value = $tmpValue
                }
            } else {
                $prop = [ordered] @{ 
                    Name = $_
                    Value = $tmpValue
                }
            }
            $return.add((new-object psobject -property $prop)) | out-null
        }
    }
    $return 

    $ErrorActionPreference = $oldEA
}

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Get-StaticProperty'
$FuncAlias       = ''
$FuncDescription = 'List the static properties of a specified TypeName'
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

