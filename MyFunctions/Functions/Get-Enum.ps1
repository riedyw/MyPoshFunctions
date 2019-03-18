function Get-Enum {
    [cmdletbinding()]
    [OutputType([psobject])]
    param (
        [type]$Type
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
        @{ Name = 'Name'; Expression={ [string]$_ } }
        @{ Name = 'Value'; Expression={ [uint32](Invoke-Expression "[$($type.FullName)]'$_'") }}
    )
    if ($isFlagsEnum)
    {
        $props += @{ Name = 'Binary'; Expression={[Convert]::ToString([uint32](Invoke-Expression "[$($type.FullName)]'$_'"), 2)}}
    }
    [enum]::GetNames($Type) |
    Select-Object -Property $props
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-Enum'
    $FuncAlias       = ''
    $FuncDescription = 'To list enumerated datatypes'
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
