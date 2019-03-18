# Source https://mjolinor.wordpress.com/2011/05/01/typecasting-imported-csv-data/

Filter Set-Type {
<#
.SYNOPSIS
    Sets the data type of a property given the property name and the data type.
.DESCRIPTION
    Sets the data type of a property given the property name and the data type. This is needed as cmdlets such as Import-CSV pulls everything in as a string datatype so you can't sort numerically or date wise.
.PARAMETER Type_Hash
    A hashtable of property names and their associated datatype
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    $csv = Import-CSV -Path .\test.csv | Set-Type -Type_Hash @{ 'LastWriteTime' = 'DateTime'}
.LINK
    about_Properties
#>
    param([hashtable]$type_hash)
    foreach ($key in $($type_hash.keys)) {
        $_.$key = $($_.$key -as $type_hash[$key])
    }
    $_
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Set-Type'
    $FuncAlias       = ''
    $FuncDescription = 'Sets the data type for the specified property, useful in Import-CSV'
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
