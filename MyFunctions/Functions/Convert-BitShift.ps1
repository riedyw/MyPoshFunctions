# Inspiration: https://stackoverflow.com/questions/35116636/bit-shifting-in-powershell-2-0

function Convert-BitShift {
<#
.SYNOPSIS
    Bit shifts an integer either LEFT or RIGHT.
.DESCRIPTION
    Bit shifts an integer either LEFT or RIGHT. Optionally can include original information.
.PARAMETER Integer
    An [int[]] integer, or array of integers to be manipulated. Aliased to 'X'
.PARAMETER Left
    Shifts the bits to the left by [int] positions. Will make Integer larger.
.PARAMETER Right
    Shifts the bits to the right by [int] positions. Will make Integer smaller.
.PARAMETER IncludeOriginal
    If this is specified the function returns an array of custom objects with the following properties
    Input    - The original value
    Shift    - Either 'Left' or 'Right'
    Pos      - The number of positions to shift
    Output   - The result
.NOTES
    Author:     Bill Riedy
    Version:    1.0
    Date:       2018/03/13
    Note:       If -Left or -Right are not specified, the default is a left shift of 1.
    To Do:      None
.EXAMPLE
    Convert-BitShift -Integer 36 -Left 2
    144
.EXAMPLE
    Convert-BitShift -x 36 -Right 2
    9
.EXAMPLE
    1..10| Convert-bitshift -IncludeOriginal

    Input Shift Pos Output
    ----- ----- --- ------
        1 Left    1      2
        2 Left    1      4
        3 Left    1      6
        4 Left    1      8
        5 Left    1     10
        6 Left    1     12
        7 Left    1     14
        8 Left    1     16
        9 Left    1     18
       10 Left    1     20
.OUTPUTS
[int[]]
#>
    [CmdletBinding(DefaultParameterSetName = 'Left')]
    [OutputType([int[]])]
    param(
        [Parameter(Mandatory=$true,Position=0, ValueFromPipeline=$true)]
        [Alias('X')]
        [int[]] $Integer,

        [Parameter(ParameterSetName = 'Left')]
        [int] $Left = 1,

        [Parameter(ParameterSetName = 'Right')]
        [int] $Right,

        [Parameter()]
        [Alias('inc','original')]
        [switch] $IncludeOriginal
    )
    begin {
        write-verbose -Message "`$PSCmdlet.ParameterSetName is [$($PSCmdlet.ParameterSetName)]"
        $shift = if($PSCmdlet.ParameterSetName -eq 'Left')
        {
            $Left
        }
        else
        {
            (-1) * $Right
        }
        $report = @()
    }
    process {
        foreach ($int in $Integer)
        {
            $returnVal = [math]::Floor($int * [math]::Pow(2,$shift))
            if ($IncludeOriginal)
            {
                if ($Left)
                {
                    $prop = @{ Input = $int ; Shift = 'Left'; Pos = $Left; Output = $returnVal }
                }
                else
                {
                    $prop = @{ Input = $int ; Shift = 'Right'; Pos = $Right; Output = $returnVal }
                }
                $obj = new-object -typename psobject -property $prop
                $report += $obj
#                write-output -InputObject (, ($obj | select-object -property Input, Shift, Pos, Output))
            }
            else
            {
                $report += $returnVal
#                write-output -InputObject (,[int] $returnVal)
            }
        }
    }
    end
    {
        write-output -InputObject $report
    }
} # EndFunction Convert-BitShift

#region Metadata
# These variables are used to set the Description property of the function.

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue

$FuncName        = 'Convert-BitShift'
$FuncAlias       = 'BitShift'
$FuncDescription = 'Bit shifts an integer either LEFT or RIGHT.'

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
    set-alias -Name $FuncAlias -Value $FuncName -Description "ALIAS for $FuncName"
    $AliasesToExport += (new-object psobject -property @{ Name = $FuncAlias ; Description = "ALIAS for $FuncName"})
}

# Setting the Description property of the function.
(get-childitem -Path Function:$FuncName).set_Description($FuncDescription)

#endregion Metadata

