Function ConvertTo-UnixEpoch {
<#
.SYNOPSIS
    Converts a datetime to a UnixEpoch which is the number of seconds since '1/1/1970 12:00:00 AM'
.DESCRIPTION
    Converts a datetime to a UnixEpoch which is the number of seconds since '1/1/1970 12:00:00 AM'
.EXAMPLE
    ConvertTo-UnixEpoch -DateTime "1/25/2018 8:34:31 AM"

    Would return the value

    1516869271
.EXAMPLE
    ConvertTo-UnixEpoch '2/1/2018 4:27:59 PM'

    Would return the value

    1517502479
.EXAMPLE
    "3/15/2018 12:00:00.545 PM" | ConvertTo-UnixEpoch

    Would return the value

    1521115200.545
.EXAMPLE
    ConvertTo-UnixEpoch '2/1/2018 4:27:59 PM' -Verbose

    Would return the following output

    VERBOSE: You entered a Local Time of:  '02/01/2018 16:27:59'
    VERBOSE: The beginning of a Unix Epoch is: '01/01/1970 00:00:00'
    VERBOSE: The date '02/01/2018 16:27:59' is 1517502479 seconds in the future of '01/01/1970 00:00:00'
    1517502479
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([double])]
    Param
    (
        [Parameter( Mandatory = $true,
                    ValueFromPipeline = $true,
                    Position=0)]
        [datetime] $DateTime
    )
    write-verbose "You entered a Local Time of:  '$DateTime'"
    $BeginUnixEpoch = get-date "1/1/1970"
    write-verbose "The beginning of a Unix Epoch is: '$BeginUnixEpoch'"
    $UnixEpoch = [timespan] ($DateTime - $BeginUnixEpoch)
    write-verbose "The date '$DateTime' is $($UnixEpoch.TotalSeconds) seconds in the future of '$BeginUnixEpoch'"
    write-output $UnixEpoch.TotalSeconds
} #EndFunction ConvertTo-UnixEpoch

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'ConvertTo-UnixEpoch'
    $FuncAlias       = ''
    $FuncDescription = "Converts a datetime to a UnixEpoch which is the number of seconds since '1/1/1970 12:00:00 AM'"
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
