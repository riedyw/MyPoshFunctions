Function Get-WordCount {
    [CmdletBinding()]
    param
        (
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string[]] $Path,
        [string[]] $Exclude
    )

    process {
        write-verbose -message "PATH    = [$($Path)]"
        $textString = $(get-content -path $Path) -join ' '
        $textString = $textString -replace "`n", ' '
        $textString = $textString -replace '[^a-z| ]'
        $textWords = $textString -split '\s+'

        $statistic = $textWords | foreach-object -Begin {$hash=@{}} -Process {$hash.$_ ++} -End {$hash}

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
