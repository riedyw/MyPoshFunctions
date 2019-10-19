<#
EXAMPLE USAGE

Assume you have a file name "cat.txt" that has a total of 3 characters in it, the 3 letters
that spell the word "cat".  The file should be 3 bytes in size.

$encodedString = ConvertTo-UuEncoding -Path .\cat.txt

# Powershell way to write the contents of the encodedString to a file
set-content -Path catEncoded.txt -Value $encodedString -nonewline

# The PSv1 way
[System.IO.File]::WriteAllText("$pwd\catencoded.txt", $encodedString)

$encodedString should have the value
@"
begin 666 cat.txt
#8V%T
`
end
"@

and if you looked at the file in a hex editor it would appear to be

begin 666 cat.txt^#8V%T^`^end^

where "^" is the newline character Ascii/Ansi decimal 10, hex A

Get-Content -Path .\catencoded.txt |
    ConvertFrom-UuEncoding |
    Set-Content -Path .\catdecoded.txt -Encoding Byte

#>

function ConvertTo-UuEncoding {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    } #close begin block

    process {
        try
        {
            $item = Get-Item -LiteralPath $Path -ErrorAction Stop
            if ($item -isnot [System.IO.FileInfo])
            {
                throw "Path '$Path' does not refer to a valid file."
            }
        }
        catch
        {
            throw
        }

        $fileBuilder = New-Object System.Text.StringBuilder

        $null = $fileBuilder.Append("begin 666 $($item.Name)`n")

        $lineBuilder = New-Object System.Text.StringBuilder
        $lineBytes = 0

        Get-Content -LiteralPath $Path -Encoding Byte -ReadCount 3 |
        ForEach-Object {
            $bytes = $_

            $lineBytes += $bytes.Count

            $int = [int]0

            for ($i = 0; $i -lt $bytes.Count; $i++)
            {
                $int += (([int] $bytes[$i]) -shl (8 * (2 - $i)))
            }

            $null = $lineBuilder.Append([char](32 + (($int -shr 18) -band 0x3F)))
            $null = $lineBuilder.Append([char](32 + (($int -shr 12) -band 0x3F)))
            $null = $lineBuilder.Append([char](32 + (($int -shr 6) -band 0x3F)))
            $null = $lineBuilder.Append([char](32 + ($int -band 0x3F)))

            if ($lineBytes -ge 45)
            {
                $null = $lineBuilder.Append("`n")
                $null = $lineBuilder.Insert(0, [char](32 + $lineBytes))
                $null = $fileBuilder.Append($lineBuilder.ToString())

                $lineBuilder.Length = 0
                $lineBytes = 0
            }
        }

        if ($lineBuilder.Length -gt 0)
        {
            $null = $lineBuilder.Append("`n")
            $null = $lineBuilder.Insert(0, [char](32 + $lineBytes))
            $null = $fileBuilder.Append($lineBuilder.ToString())
        }

        $null = $fileBuilder.Append("```nend`n")

        $fileBuilder.ToString()
    } # end process block

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close end block

}

Set-Alias -Name 'UuEncode' -Value 'ConvertTo-UuEncoding'
