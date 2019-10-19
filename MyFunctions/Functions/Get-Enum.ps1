function Get-Enum {
    [cmdletbinding()]
    [OutputType([psobject])]
    param (
        [type] $Type
    )
    if ($Type.BaseType.FullName -ne 'System.Enum')
    {
        Write-Error -message "Type '$Type' is not an enum"
        return
    }
    if ($Type.CustomAttributes | Where-Object { $_.AttributeType -eq [System.FlagsAttribute] })
    {
        Write-Verbose "Type '$Type' is a Flags enum"
        $isFlagsEnum = $true
    }
    $props = @(
        @{ Name = 'Name'; Expression={ [string] $_ } }
        @{ Name = 'Value'; Expression={ [uint32](Invoke-Expression "[$($type.FullName)]'$_'") }}
    )
    if ($isFlagsEnum)
    {
        $props += @{ Name = 'Binary'; Expression={[Convert]::ToString([uint32](Invoke-Expression "[$($type.FullName)]'$_'"), 2)}}
    }
    [enum]::GetNames($Type) |
    Select-Object -Property $props
} #EndFunction: Get-Enum
