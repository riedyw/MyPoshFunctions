function ConvertFrom-UuEncoding {
<#
.SYNOPSIS
    Convert from UU encoding back to normal data
.DESCRIPTION
    Convert from UU encoding back to normal data, UU encoding was an old way for binary data to be transferred via plain text links.
.PARAMETER EncodedText
    The UU encoded string
.PARAMETER FileName
    A file where the contents will be stored
.PARAMETER TCP
    Use TCP as the transport protocol
.NOTES
    Author:     Bill Riedy

#>
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
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
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
                    if ($line -eq '``')
                    {
                        $state = 'ExpectingFooter'
                    }
                    else
                    {
                        $chars = $line.ToCharArray()

                        if ($chars.Count -eq 0 -or ($chars.Count - 1) % 4 -ne 0 -or
                            ($chars | Where-Object { [int] $_ -lt 32 -or [int] $_ -gt 96 }).Count -gt 0)
                        {
                            throw "Invalid content in UUEncoded text."
                        }

                        $bytes = [int] $chars[0] - 32

                        if ($bytes -gt 45 -or $bytes -lt 0)
                        {
                            throw "Invalid content in UUEncoded text."
                        }

                        $byteCounter = 0

                        for ($i = 1; $i -lt $chars.Count; $i += 4)
                        {
                            $int = ((([int] $chars[$i] - 32) -band 0x3F) -shl 18) -bor
                                      ((([int] $chars[$i+1] - 32) -band 0x3F) -shl 12) -bor
                                      ((([int] $chars[$i+2] - 32) -band 0x3F) -shl 6) -bor
                                      (([int] $chars[$i+3] - 32) -band 0x3F)

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

    end {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }
}
