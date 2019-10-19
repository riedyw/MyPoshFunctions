Function Convert-ARGBToHex {
    <#
.SYNOPSIS
    Converts an ARGB color string to hex equivalent
.DESCRIPTION
    Converts an ARGB color string to hex equivalent. Input should be in the form 'A,R,G,B'
.PARAMETER ARGB
    An ARGB color string in the form '#,#,#,#' where each number is between 0 and 255.
.PARAMETER IncludeHash
    A switch indicating whether hex string should be preceded by a hash symbol #. Default value = $True.
.NOTES
    Part of the ISEColorThemeCmdlets.ps1 Script by Jeff Pollock
    http://gallery.technet.microsoft.com/ISE-Color-Theme-Cmdlets-24905f9e

    Modified:     Bill Riedy
    a) Changed name of parameter to ARGB
    b) Added -IncludeHash parameter to make # optional.
    c) Minor tweaking so that it passes Invoke-ScriptAnalyzer
    d) Added parameter validation on ARGB.
    e) Added .LINK entries for related items
.EXAMPLE
    Convert-ARGBToHex -ARGB '255,128,64,32'
    Would return
    #FF804020
.EXAMPLE
    Convert-ARGBToHex -ARGB '255,255,0,0' -inc:$false
    Would return
    FFFF0000
.EXAMPLE
    convert-argbtohex '255,64,128,255'
    Would return
    #FF4080FF
.EXAMPLE
    '255,128,128,92' | convert-argbtohex -inc:$false
    Would return
    FF80805C
.LINK
    about_ISE-Color-Theme-Cmdlets
.LINK
    Convert-HexToARGB
.OUTPUTS
[string]
#>

    #region Parameters
    [cmdletbinding()]
    [outputtype([string])]
    Param(
        [parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $true)]
        [string] $ARGB,

        [bool] $IncludeHash = $True
    )
    #endregion Parameters

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {
        write-verbose "`$ARGB = [$ARGB]"
        $ARGB = $ARGB -replace ' ', ''
        if ( $ARGB -match "^\d{1,3}\,\d{1,3}\,\d{1,3}\,\d{1,3}$") {
            #$true
        }
        else {
            if ( $ARGB -match "^\d{1,3}\,\d{1,3}\,\d{1,3}$") {
                $ARGB = "0,$ARGB"
                #$true
            }
            else {
                throw "You must provide an ARGB string value in the form '#,#,#,#' where each number is between 0 and 255"
            }
        }
        write-verbose "`$ARGB = [$ARGB]"
        #-separate the ARGB values
        $var_RGB = $ARGB.split(",")

        #-Convert values to Hex
        $var_A = [Convert]::ToString($var_RGB[0], 16).ToUpper().PadLeft(2, '0')
        $var_R = [Convert]::ToString($var_RGB[1], 16).ToUpper().PadLeft(2, '0')
        $var_G = [Convert]::ToString($var_RGB[2], 16).ToUpper().PadLeft(2, '0')
        $var_B = [Convert]::ToString($var_RGB[3], 16).ToUpper().PadLeft(2, '0')

        #-Output concatenated hex value
        if ($IncludeHash) {
            Write-Output "#$var_A$var_R$var_G$var_B"
        }
        else {
            Write-Output "$var_A$var_R$var_G$var_B"
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

} #EndFunction Convert-ARGBToHex
