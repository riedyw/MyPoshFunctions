Function Convert-ROT13 {
<#
.SYNOPSIS
    Shifts letters in string by 13 positions.
.DESCRIPTION
    Shifts letters in string by 13 positions. 'A' becomes 'N' and so on.
.PARAMETER String
    A simple string or array of strings that you want Convert-ROT13 run against.
.NOTES
    Author:     Bill Riedy
    Version:    1.0
    Link:       https://en.wikipedia.org/wiki/ROT13
.EXAMPLE
    Convert-ROT13 -String 'Password'

    Would return
    Cnffjbeq
.EXAMPLE
    Convert-ROT13 -String 'Cnffjbeq'

    Would return
    Password
.EXAMPLE
    Convert-ROT13 -String 'This is a secret'

    Would return
    Guvf vf n frperg
.EXAMPLE
    Convert-ROT13 -string 'one', 'two' -verbose

    Would return
    VERBOSE: String is [one|two]
    VERBOSE: Current line is [one]
    bar
    VERBOSE: Current line is [two]
    gjb
.INPUTS
    [string[]]
.OUTPUTS
    [string[]]
.LINK
    https://en.wikipedia.org/wiki/ROT13

#>

#region Parameter
    [cmdletbinding()]
    Param(
        [Parameter(Position=0,Mandatory=$True,ValueFromPipeLine=$True)]
        [String[]] $String
    )
#endregion Parameter

    begin {
        $Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        $Cipher   = "NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm"
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
        Write-Verbose -message "Using parameter set $($PSCmdlet.ParameterSetName)"

    }

    process {
        write-verbose "String is [$((($String | findstr /r ".") -split "`n") -join '|')]"
        Foreach ($line in $String) {
            write-verbose "Current line is [$($line)]"
            [string] $NewString = ""
            Foreach($Char in $line.ToCharArray())
            {
                If ( $Char -match "[A-Za-z]" )
                { $NewString += $Cipher.Chars($Alphabet.IndexOf($Char)) }
                else
                { $NewString += $Char }
            }
            write-output $NewString
        }
    }

    end {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} # endfunction convert-rot13
