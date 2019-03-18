function Get-Enum2 {
    [cmdletbinding()]
    param (
        [type]$Type,

        [switch] $IncludeEnum
    )

    if ($Type.BaseType.FullName -ne 'System.Enum')
    {
        Write-Error -Message "Type '$Type' is not an enum"
        return
    }

    if ($Type.CustomAttributes | Where-Object { $_.AttributeType -eq [System.FlagsAttribute] })
    {
        Write-Host -Message "Type '$Type' is a Flags enum"
        $isFlagsEnum = $true
    }

    $props = @(
        @{ Name = 'Name'; Expression={ [string]$_ } }
        @{ Name = 'Value'; Expression={ [uint32](Invoke-Expression -Command "[$($type.FullName)]'$_'") }}
    )

    if ($IncludeEnum) {
        $props += @{ Name = 'FullName'; Expression={([type] $type | select-object -ExpandProperty fullname)}}
        $props += @{ Name = 'ShortName'; Expression={([type] $type | Select-Object -ExpandProperty name)}}
    }
    if ($isFlagsEnum)
    {
        $props += @{ Name = 'Binary'; Expression={[Convert]::ToString([uint32](Invoke-Expression -Command "[$($type.FullName)]'$_'"), 2)}}
    }

    if ($IncludeEnum) {
        if ($isFlagsEnum) {
            [enum]::GetNames($Type) |
            Select-Object -Property $props | Select-Object -Property FullName, ShortName, Name, Value, Binary
        } else {
            [enum]::GetNames($Type) |
            Select-Object -Property $props | select-object -Property FullName, ShortName, Name, Value
        }
    } else {
        [enum]::GetNames($Type) |
        Select-Object -Property $props
    }
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-Enum2'
    $FuncAlias       = ''
    $FuncDescription = 'Second attempt to list enumerations'
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
