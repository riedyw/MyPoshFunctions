<#
EXAMPLE USAGE

$encodedString = ConvertTo-UuEncoding -Path .\cat.txt

[System.IO.File]::WriteAllText("$pwd\catencoded.txt", $encodedString)

Get-Content -Path .\catencoded.txt |
ConvertFrom-UuEncoding |
Set-Content -Path .\catdecoded.txt -Encoding Byte

#>

function ConvertFrom-UuEncoding
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [AllowEmptyString()]
        [string[]]
        $EncodedText,

        [ref]
        $FileName
    )

    begin
    {
        write-verbose 'Setting state'
        $state = 'ExpectingHeader'
    }

    process
    {
        foreach ($line in $EncodedText -split '\r?\n')
        {
            write-verbose "working on $line"
            switch ($state)
            {
                'ExpectingHeader'
                {
                    if ($line -notmatch '^begin \d+ (.+)')
                    {
                        throw "Invalid header in UUEncoded text."
                    }

                    if ($null -ne $FileName)
                    {
                        $FileName.Value = $matches[1]
                    }

                    $state = 'Data'

                    break
                }

                'Data'
                {
                    if ($line -eq '`')
                    {
                        $state = 'ExpectingFooter'
                    }
                    else
                    {
                        $chars = $line.ToCharArray()

                        if ($chars.Count -eq 0 -or ($chars.Count - 1) % 4 -ne 0 -or
                            ($chars | Where-Object { [int]$_ -lt 32 -or [int]$_ -gt 96 }).Count -gt 0)
                        {
                            throw "Invalid content in UUEncoded text."
                        }

                        $bytes = [int]$chars[0] - 32

                        if ($bytes -gt 45 -or $bytes -lt 0)
                        {
                            throw "Invalid content in UUEncoded text."
                        }

                        $byteCounter = 0

                        for ($i = 1; $i -lt $chars.Count; $i += 4)
                        {
                            $int = ((([int]$chars[$i] - 32) -band 0x3F) -shl 18) -bor
                                      ((([int]$chars[$i+1] - 32) -band 0x3F) -shl 12) -bor
                                      ((([int]$chars[$i+2] - 32) -band 0x3F) -shl 6) -bor
                                      (([int]$chars[$i+3] - 32) -band 0x3F)

                            for ($j = 0; $j -lt 3 -and $byteCounter -lt $bytes; $j++, $byteCounter++)
                            {
                                Write-Output ([byte](($int -shr (8 * (2 - $j))) -band 0xFF))
                            }
                        }
                    }

                    break
                }

                'ExpectingFooter'
                {
                    if ($line -ne 'end')
                    {
                        Write-Warning 'Invalid footer line detected.'
                    }
                    else
                    {
                        $state = 'Done'
                    }

                    break
                }

                'Done'
                {
                    Write-Warning 'Detected content after footer line.'
                }
            }
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

$FuncName        = 'ConvertFrom-UuEncoding'
$FuncAlias       = ''
$FuncDescription = 'Converts from a UUEncoded text string'
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
