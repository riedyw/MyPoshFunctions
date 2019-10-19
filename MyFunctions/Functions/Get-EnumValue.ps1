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
                [enum]::getvalues([type] $curEnum) |
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
