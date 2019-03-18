# from: http://community.idera.com/powershell/powertips/b/tips/posts/listing-properties-with-values-part-3

function Remove-EmptyProperty  {
    param (
        [Parameter(Mandatory,ValueFromPipeline)]
            $InputObject,

            [Switch]
            $AsHashTable
    )

    begin
    {
      $props = @()

    }

    process {
        if ($props.Count -eq 0)
        {
            $props = $InputObject |
                Get-Member -MemberType *Property |
                Select-Object -ExpandProperty Name |
                Sort-Object
        }

        $notEmpty = $props | Where-Object {
            -not (($null -eq $InputObject.$_ ) -or
            ($InputObject.$_ -eq '') -or
            ($InputObject.$_.Count -eq 0)) |
                Sort-Object

        }

        if ($AsHashTable)
        {
          $notEmpty |
            ForEach-Object {
                $h = [Ordered]@{}} {
                    $h.$_ = $InputObject.$_
                    } {
                    $h
                    }
        }
        else
        {
          $InputObject |
            Select-Object -Property $notEmpty
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
    $FuncName        = 'Remove-EmptyProperty'
    $FuncAlias       = ''
    $FuncDescription = 'Gets rid of empty properties'
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
