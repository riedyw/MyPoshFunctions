Function ConvertFrom-FileTime () {
<#
.SYNOPSIS
   Converts a large integer filetime into a [datetime] if the value is valid or a [string] if invalid.
.DESCRIPTION
    Converts a large integer filetime [int64] into a datetime string. There is a special value that returns a value of "Never". Returns a [datetime] in Universal Time (UTC)

    Filetimes are expressed in Ticks. Ticks can range from 0 - 2650467743999999999. Translating these into dates you get
                      0 = Monday, January 01, 1601 12:00:00.00000 AM
    2650467743999999999 = Friday, December 31, 9999 11:59:59.99999 PM
.EXAMPLE
    ConvertFrom-FileTime -FileTime 131613608711918252

    Would return the [datetime]
    Thursday, January 25, 2018 1:34:31 PM
.EXAMPLE
    ConvertFrom-FileTime 131619940792563529

    Would return the [datetime]
    Thursday, February 01, 2018 9:27:59 PM
.EXAMPLE
    ConvertFrom-FileTime 9223372036854775807

    Would return the [string]
    Never
.EXAMPLE
    ConvertFrom-FileTime 9223372036854775806

    Would return the [string]
    Invalid
.EXAMPLE
    ConvertFrom-FileTime 0

    Would return the [datetime]
    Monday, January 01, 1601 12:00:00 AM
.EXAMPLE
    # Assuming that the value of the LastLogon property for a particular user in Active Directory is 131702624106036606
    $LastLogon = 131702624106036606
    ConvertFrom-FileTime $LastLogon

    Would return the [datetime]
    Tuesday, May 08, 2018 2:13:30 PM
.OUTPUTS
    [datetime] if the FileTime specified is in valid range 0 - 2650467743999999999

    [string]   if the FileTime greater than the max value above
      Invalid  if FileTime > $MaxTicks and < $Never
      Never    if FileTime = $Never
#>
    #region parameter
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        # [int64] filetime property, used in AD in fields, badPasswordTime, LastLogon, accountExpires, LastLogonTimeStamp
        [Parameter( Mandatory = $true,
                    ValueFromPipeline = $true,
                    Position=0,
                    HelpMessage='Please enter an [int64] filetime'
                )]
        [int64] $FileTime
    )
    #endregion Parameter

    Begin {
        $MaxTicks = 2650467743999999999
        $Never    = 9223372036854775807
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        if ( $FileTime -gt $MaxTicks ) {
            write-verbose "The number of ticks passed $FileTime is greater than $MaxTicks"
            if ( $FileTime -eq $Never ) {
                write-verbose "The number of ticks passed $FileTime equals the value for Never $Never"
                write-output "Never"
            } else {
                    write-verbose "The number of ticks passed $FileTime is greater than $MaxTicks but is less than Never $Never"
                write-output "Invalid"
            }
        } else {
            write-verbose "The number of ticks passed $FileTime is within the valid range of 0 - $MaxTicks"
            $output = [datetime]::FromFileTime($FileTime)
            write-output $output.touniversaltime()
        }
    }

    end {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }


} #EndFunction ConvertFrom-FileTime

Set-Alias -Name 'ConvertFrom-Ticks' -Value 'ConvertFrom-FileTime' -Description 'Alias for ConvertFrom-FileTime'
