Function Get-EnumValue {
# Get-EnumValue -enum "System.Diagnostics.Eventing.Reader.StandardEventLevel"
    [CmdletBinding()]
    Param(
        [string[]] $Enum,

        [switch] $IncludeEnum
    )
    $oldEA = $ErrorActionPreference
    $ErrorActionPreference = "Stop"
    foreach ($curEnum in $Enum) {
        if ( -not $IncludeEnum ) {
            $enumValues = @{}
            try {
                [enum]::getnames([type] $curEnum) |
                    ForEach-Object {
                    $enumValues.add($_, $_.value__)
                }
                write-output -InputObject $enumValues
            } catch {
                write-warning -Message "The enum specified [$($curEnum)] could not be found or is not an [enum] data type"
            }
        } else {
            $returnArray = @()
            try {
                [enum]::getvalues([type]$curEnum) |
                    ForEach-Object {
                        $Prop = @{
                            Class = $curEnum
                            Name  = ("{0}" -f $_)
                            Value = ($_.value__)
                        }
                        $obj = new-object -typename psobject -property $Prop
                        $returnArray += $obj
                    }
                write-output -inputobject ($returnArray | Select-object -property Class, Name, Value)
            } catch {
                write-warning -message "The enum specified [$($curEnum)] could not be found or is not an [enum] data type"
            }
        }
    }
    $ErrorActionPreference = $oldEA
}

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Get-EnumValue'
$FuncAlias       = ''
$FuncDescription = 'Enumerate the values'
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

