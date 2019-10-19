Function Test-IsHexString {
<#
.SYNOPSIS
    Tests to determine if a string is a valid hexadecimal number. Can optionally include a prefix of '0x' or '#'
.DESCRIPTION
    Tests to determine if a string is a valid hexadecimal number. Can optionally include a prefix of '0x' or '#'. Can accept a string, an array of strings, or pipeline input.
.EXAMPLE
    Test-IsHexString '123abc'

    True
.EXAMPLE
    Test-IsHexString 'lmnop'

    False
.EXAMPLE
    test-ishexstring @('0x1','#1abcdef','3c') -IncludeInput  -AllowPrefix

    Input    AllowPrefix Result
    -----    ----------- ------
    0x1             True   True
    #1abcdef        True   True
    3c              True   True
.EXAMPLE
    Test-IsHexString '123abc' -Verbose

    VERBOSE: $h is [123abc]
    True
#>

    [CmdletBinding()]
    [OutputType([bool])]
    Param (
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
        [Alias("Hex")]
        [string[]] $HexString,
        [switch] $IncludeInput,
        [switch] $AllowPrefix
    )

    begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
        $regexPrefix = '^(#|0x)?[0-9,a-f]*$'
        $regexNoPrefix = '^[0-9,a-f]*$'
        write-verbose "`$regexPrefix is [$regexPrefix]"
        write-verbose "`$regexNoPrefix is [$regexNoPrefix]"
        write-verbose "`$AllowPrefix is $AllowPrefix"
        write-verbose "`$IncludeInput is $IncludeInput"
    }

    Process {
        foreach ($h in $HexString) {
            $h = $h.Trim()
            write-verbose "`$h is [$h]"
            if ($AllowPrefix) {
                if ($h -match $regexPrefix) {
                    write-verbose 'match'
                    $n = [convert]::ToInt32(($h -replace '^(0x|#)', ''),16)
                    write-verbose "`$n is [$n]"
                    if ($IncludeInput) {
                        new-object psobject -Property @{Input="$h"; AllowPrefix=$true; Result=$true; Decimal=$n} | select-object Input, AllowPrefix, Result, Decimal
                    } else {
                        Write-Output -inputobject $true
                    }
                } else {
                    write-verbose 'no match'
                    if ($IncludeInput) {
                        new-object psobject -Property @{Input="$h"; AllowPrefix=$true; Result=$false; Decimal=$null} | select-object Input, AllowPrefix, Result, Decimal
                    } else {
                        Write-Output -inputobject $false
                    }
                }
            } else {
                if ($h -match $regexNoPrefix) {
                    write-verbose 'match'
                    $n = [convert]::ToInt32(($h -replace '^(0x|#)', ''),16)
                    write-verbose "`$n is [$n]"
                    if ($IncludeInput) {
                        new-object psobject -Property @{Input="$h"; AllowPrefix=$false; Result=$true; Decimal=$n} | select-object Input, AllowPrefix, Result, Decimal
                    } else {
                        Write-Output -inputobject $true
                    }
                } else {
                    write-verbose 'no match'
                    if ($IncludeInput) {
                        new-object psobject -Property @{Input="$h"; AllowPrefix=$false; Result=$false; Decimal = $null} | select-object Input, AllowPrefix, Result, Decimal
                    } else {
                        Write-Output -inputobject $false
                    }
                }
            }
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }
}
