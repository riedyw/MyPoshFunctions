Function Get-FileWithLeadingSpace {

    [cmdletbinding()]
    Param([string] $path = "c:\a")

    Get-ChildItem -Path $path -Recurse |
        foreach-object {
            if($_.name.length -ne $_.name.trim().length)
            {
                "$($_.basename) contains a leading space"
            }
        }
} #end function Get-FileWithLeadingSpace
