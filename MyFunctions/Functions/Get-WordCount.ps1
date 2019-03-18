Function Get-WordCount {
    [CmdletBinding()]
    param
        (
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string[]]$Path,
        [string[]]$Exclude
    )

    process {
        write-verbose -message "PATH    = [$($Path)]"
        $textString = $(get-content -path $Path) -join ' '
        $textString = $textString -replace "`n", ' '
        $textString = $textString -replace '[^a-z| ]'
        $textWords = $textString -split '\s+'

        $statistic = $textWords | foreach-object -Begin {$hash=@{}} -Process {$hash.$_++} -End {$hash}

        if ( $exclude ) {
            write-verbose -message "EXCLUDE = $Exclude"
            $excludeString = $(get-content -path $exclude) -join ' '
            $excludeString = $excludeString -replace "`n", ' '
            $excludeString = $excludeString -replace '[^a-z| ]'
            $excludeWords = $excludeString -split '\s+'
            $excludeWords | foreach-object {
                if ($statistic.ContainsKey($_)) {
                    $statistic.Remove($_)
                }
            }
        }
        write-verbose -message 'Word frequency in descending order'
        $statistic.GetEnumerator() | sort-object -Property value -Descending
    }
} #EndFunction Get-WordCount

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-WordCount'
    $FuncAlias       = ''
    $FuncDescription = 'Tokenizes a string and counts the words'
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

