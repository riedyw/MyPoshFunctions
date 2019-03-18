function Copy-Object {
#region Parameter
    [cmdletbinding()]
    [OutputType([psobject])]
    Param(
        [Parameter(
            Mandatory = $True,
            Position = 0,
            ValueFromPipeline = $True)]
            [psobject[]] $InputObject
        )
#endregion Parameter
    begin {
        $result = @()
    }

    process {
        foreach ($curObject in $InputObject) {
            if ($curObject.gettype().name -eq 'HashTable') 
            {
                $result += $curObject.Clone()
            }
            else
            {
                $tempObject = New-Object PsObject
                $curObject.psobject.properties | foreach-object {
                    $tempObject | Add-Member -MemberType $_.MemberType -Name $_.Name -Value $_.Value
                }
                $result += $tempObject
            }
        }
    }

    end {
        write-output $result
    }

}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Copy-Object'
    $FuncAlias       = ''
    $FuncDescription = 'Function to copy an object by value to another variable.'
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
