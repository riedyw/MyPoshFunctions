Function ConvertFrom-DmtfDateTime () {
<#
.SYNOPSIS
    Converts a DMTF datetime into a normal datetime value.
.DESCRIPTION
    Converts a DMTF datetime into a normal datetime value.

    DmtfDateTime is of the form "yyyymmddHHMMSS.mmmmmmsUUU"

    Where
        yyyy    is the 4 digit year
        mm      is the 2 digit month
        dd      is the 2 digit day of the month
        HH      is the 2 digit in 24 hour format (00-23, 1 pm = 13)
        MM      is the 2 digit minute (00-59)
        SS      is the 2 digit second (00-59)
        mmmmmm  is the 6 digit microsecond
        s       is the plus or minus to indicate offset from UTC
        UUU     is the 3 digit number of minutes offset from UTC (000-720)
.EXAMPLE
    ConvertFrom-DmtfDateTime "20161124225058.082190+060"

    Would return the datetime

    Thursday, November 24, 2016 4:50:58 PM
.EXAMPLE
    ConvertFrom-DmtfDateTime "20180205154504.962817-300"

    Would return the datetime

    Monday, February 05, 2018 3:45:04 PM
.EXAMPLE
    ConvertFrom-DmtfDateTime "20180205154504" -verbose

    Would return the following

    VERBOSE: The DMTF date time should be 25 characters long
    False
.EXAMPLE
    ConvertFrom-DmtfDateTime "2018020515450A.962817-300" -verbose

    Would return the following (note A in the final position of seconds)

    VERBOSE: The DMTF date time should be of the form 'YYYYMMDDHHmmss.ffffff+###'
    False
.EXAMPLE
    "20180205154503.962817-300" | ConvertFrom-DmtfDateTime

    Would return the datetime

    Monday, February 05, 2018 3:45:03 PM
.NOTES
    Author:     Bill Riedy
    Info:       For further information on DMTF time formats see https://docs.microsoft.com/en-us/windows/desktop/wmisdk/cim-datetime
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   Position=0)]
        [string] $DmtfDateTime
    )
    if ($DmtfDateTime.length -ne 25) {
        write-verbose -message "The DMTF date time should be 25 characters long and of the form 'YYYYMMDDHHmmss.ffffff+###'"
        write-output -inputobject $false
        break
    }
    $regexp = "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9][-+][0-9][0-9][0-9]"
    if ( -not ($DmtfDateTime -match $regexp)) {
        write-verbose -message "The DMTF date time should be of the form 'YYYYMMDDHHmmss.ffffff+###'"
        write-output -inputobject $false
        break
    }

    write-output -inputobject ([Management.ManagementDateTimeConverter]::ToDateTime("$DmtfDateTime"))
} #EndFunction ConvertFrom-DmtfDateTime

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'ConvertFrom-DmtfDateTime'
$FuncAlias       = ''
$FuncDescription = 'Convert from Dmtf formatted datetime to normal Powershell datetime'
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
