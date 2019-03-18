Function ConvertFrom-UnixEpoch {
<#
.SYNOPSIS
    Converts a Unix Epoch value to a datetime
.DESCRIPTION
    Converts a Unix Epoch value to a datetime
.EXAMPLE
    ConvertFrom-UnixEpoch -UnixEpoch 1521115200

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the datetime

    Thursday, March 15, 2018 12:00:00 PM
.EXAMPLE
    ConvertFrom-UnixEpoch 1517502479

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the datetime

    Thursday, February 01, 2018 4:27:59 PM
.EXAMPLE
    "3/15/2018 12:00:00 PM" | ConvertFrom-UTC

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the datetime

    Thursday, March 15, 2018 8:00:00 AM
.EXAMPLE
    ConvertFrom-UnixEpoch 1517502479 -Verbose

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the following output:

    VERBOSE: You entered a Unix Epoch of:  '1517502479'
    VERBOSE: The beginning of a Unix Epoch is: '01/01/1970 00:00:00'
    VERBOSE: The date '02/01/2018 16:27:59' is 1517502479 seconds in the future of '01/01/1970 00:00:00'
    Thursday, February 01, 2018 4:27:59 PM
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([datetime])]
    param(
        [parameter(Mandatory=$true,
                   ValueFromPipeline = $true,
                   Position=0 )]
        [int64] $UnixEpoch
    )
    $BeginUnixEpoch = get-date "1/1/1970"
    write-verbose "You entered a Unix Epoch of:  '$UnixEpoch'"
    write-verbose "The beginning of a Unix Epoch is: '$BeginUnixEpoch'"
    $TempTime = $BeginUnixEpoch.AddSeconds($UnixEpoch)
    write-verbose "The date '$TempTime' is $UnixEpoch seconds in the future of '$BeginUnixEpoch'"
    write-output $TempTime
} #EndFunction ConvertFrom-UnixEpoch

if (-not (test-path Variable:AliasesToExport)) {
    $AliasesToExport = @()
}
if (-not (test-path Variable:VariablesToExport)) {
    $VariablesToExport = @()
}
#$AliasesToExport += 'AliasName'
#$VariablesToExport += 'VariableName'


# These variables are used to set the Description property of the function.
$funcName = 'ConvertFrom-UnixEpoch'
$funcDescription = 'Converts a Unix Epoch value to a datetime'

# Setting the Description property of the function.
(get-childitem function:$funcName).set_Description($funcDescription)

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'ConvertFrom-UnixEpoch'
$FuncAlias       = ''
$FuncDescription = 'Converts a Unix Epoch value to a datetime'
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
