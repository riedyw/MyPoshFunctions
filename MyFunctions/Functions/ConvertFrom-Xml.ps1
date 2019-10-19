function ConvertFrom-Xml($XML) {
<#
.SYNOPSIS
    Convert XML to an object
.DESCRIPTION
    Convert XML to an object
.PARAMETER XML
    The XML that you want converted
.NOTES
    Author:     Bill Riedy

#>

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process {
        foreach ($Object in @($XML.Objects.Object)) {
            $PSObject = New-Object PSObject
            foreach ($Property in @($Object.Property)) {
                $PSObject | Add-Member -membertype NoteProperty -name $Property.Name -value $Property.InnerText
            }
            $PSObject
        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}
