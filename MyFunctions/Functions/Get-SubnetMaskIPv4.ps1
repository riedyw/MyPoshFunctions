Function Get-SubnetMaskIPv4 {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [Alias("Length","CIDR")]
        [int[]] $NetworkLength,

        [Parameter()]
        [Alias('inc','include')]
        [switch] $IncludeCIDR
    )
    process {
        foreach ($curLength in $NetworkLength) {
            $MaskBinary = ('1' * $curLength).PadRight(32, '0')
            $DottedMaskBinary = $MaskBinary -replace '(.{8}(?!\z))', '${1}.'
            $SubnetMask = ($DottedMaskBinary.Split('.') | foreach-object { [Convert]::ToInt32($_, 2) }) -join '.'
            if ($IncludeCIDR) {
                $prop = @{ SubnetMask = $SubnetMask ; CIDR = $curLength }
                $obj = New-Object -typename PsObject -Property $prop
                $obj
            } else {
                $SubnetMask
            }
        }
    }
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-SubnetMaskIPv4'
    $FuncAlias       = 'Get-SubnetMaskIP'
    $FuncDescription = 'Get a particular subnet mask'
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
        set-alias -Name $FuncAlias -Value $FuncName -Description "ALIAS for $FuncName"
        $AliasesToExport += (new-object psobject -property @{ Name = $FuncAlias ; Description = "ALIAS for $FuncName"})
    }
    if ($FuncVarName)
    {
        $VariablesToExport += $FuncVarName
    }
    # Setting the Description property of the function.
    (get-childitem -Path Function:$FuncName).set_Description($FuncDescription)
#endregion Metadata
