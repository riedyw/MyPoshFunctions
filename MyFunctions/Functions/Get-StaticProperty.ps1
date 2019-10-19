Function Get-StaticProperty {

# Get-EnumValue -enum "System.Diagnostics.Eventing.Reader.StandardEventLevel"
    [CmdletBinding()]
    [OutputType([System.Collections.ArrayList])]
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
            if ($null -eq $tmpValue) {
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
