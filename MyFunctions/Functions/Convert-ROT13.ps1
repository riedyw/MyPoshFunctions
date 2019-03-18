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
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported

    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

    $FuncName        = 'Convert-ROT13'
    $FuncAlias       = ''
    $FuncDescription = "Shifts letters in string by 13 positions. 'A' becomes 'N' and so on."
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
