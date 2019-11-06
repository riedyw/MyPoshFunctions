# Source: https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/turning-objects-into-hash-tables-2

function Convert-ObjectToHashtable
{
    param
    (
        [Parameter(Mandatory,ValueFromPipeline)]
        $object,

        [Switch]
        $ExcludeEmpty
    )

    process
    {
        $object.PSObject.Properties | 
        # sort property names
        Sort-Object -Property Name |
        # exclude empty properties if requested
        Where-Object { $ExcludeEmpty.IsPresent -eq $false -or $_.Value -ne $null } |
        ForEach-Object { 
            $hashtable = [Ordered]@{}} { 
            $hashtable[$_.Name] = $_.Value 
            } { 
            $hashtable 
            } 
    }
}
