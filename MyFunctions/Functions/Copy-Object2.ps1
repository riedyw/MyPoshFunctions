function Copy-Object2 {
<#
.SYNOPSIS
    To copy the contents of one object into the pipeline
.DESCRIPTION
    By default Powershell will copy values by reference and when you change the values of one you change the other
.PARAMETER InputObject
    A string or an array of strings which specify the ComputerName(s) for which you want the names parsed.
.NOTES
    Author:     Bill Riedy
    Version:    2.0
    Date:       2018/09/13
    Comment:    Added logic to properly handle a hashtable.
.EXAMPLE
    What is broken about setting one variable to the value of another:

    $hash1 = @{'key1' = 'value1'}
    $hash2 = $hash1
    $hash1.Add('key2','value2')
    $hash2 

    Would return
    Name Value
    ---- -----
    key2 value2
    key1 value1

    Instead if we enter the following:
    $hash1 = @{'key1' = 'value1'}
    $hash2 = Copy-Object2 $hash1
    $hash1.Add('key2','value2')
    $hash2

    Would return
    Name Value
    ---- -----
    key1 value1

    Which is what we want.
.OUTPUTS
    The same type of object that was passed to it.
#>

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
            $result += $curObject.psobject.copy()
<#             
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
            
 #>
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
    $FuncName        = 'Copy-Object2'
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
