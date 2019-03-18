Function ConvertTo-UTC {
<#
.SYNOPSIS
    Converts a datetime from local time to UTC
.DESCRIPTION
    Converts a datetime from local time to UTC
.EXAMPLE
    ConvertTo-UTC -DateTime "1/25/2018 8:34:31 AM"

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

    Thursday, January 25, 2018 1:34:31 PM
.EXAMPLE
    ConvertTo-UTC '2/1/2018 4:27:59 PM'

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

    Thursday, February 01, 2018 9:27:59 PM
.EXAMPLE
    "3/15/2018 12:00:00 PM" | ConvertTo-UTC

    Assuming that your local time zone is EST, and your region/culture is EN-US this would return the string

    Thursday, March 15, 2018 4:00:00 PM
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([datetime])]
    Param
    (
        [Parameter( Mandatory = $true,
                    ValueFromPipeline = $true,
                    Position=0)]
        [datetime] $DateTime
    )
    write-verbose "You entered a Local Time of:  '$DateTime'"
    $strCurrentTimeZone = (Get-WmiObject win32_timezone).Description
    write-verbose "Your local timezone is '$strCurrentTimeZone'"
    $DateTime = $DateTime.ToUniversalTime()
    write-verbose "The UTC time is: '$DateTime'"
    write-output $DateTime
} #EndFunction ConvertTo-UTC

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'ConvertTo-UTC'
    $FuncAlias       = ''
    $FuncDescription = 'Converts a datetime from local time to UTC'
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
