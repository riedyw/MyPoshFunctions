# Source https://mjolinor.wordpress.com/2011/05/01/typecasting-imported-csv-data/

Filter Set-Type {
<#
.SYNOPSIS
    Sets the data type of a property given the property name and the data type.
.DESCRIPTION
    Sets the data type of a property given the property name and the data type. This is needed as cmdlets such as Import-CSV pulls everything in as a string datatype so you can't sort numerically or date wise.
.PARAMETER Type_Hash
    A hashtable of property names and their associated datatype
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    $csv = Import-CSV -Path .\test.csv | Set-Type -Type_Hash @{ 'LastWriteTime' = 'DateTime'}
.LINK
    about_Properties
#>
#    [cmdletbinding()]
    param(
#        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
        [hashtable] $type_hash
    )

#    Begin {
#        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
#    }

#    Process {
        foreach ($key in $($type_hash.keys)) {
            $_.$key = $($_.$key -as $type_hash[$key])
        }
        $_
#    }

#    End {
#        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
#    }

}
