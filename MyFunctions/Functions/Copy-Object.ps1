function Copy-Object {

#region Parameter
    [cmdletbinding()]
    [OutputType([psobject])]
    Param(
        [Parameter(
            Mandatory = $True,
            Position = 0,
            ValueFromPipeline = $True)]
            [psobject[]] $InputObject
        )
#endregion Parameter
    begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
        $result = @()
    }

    process {
        foreach ($curObject in $InputObject) {
            if ($curObject.gettype().name -eq 'HashTable')
            {
                $result += $curObject.Clone()
            }
            else
            {
                $tempObject = New-Object PsObject
                $curObject.psobject.properties | foreach-object {
                    $tempObject | Add-Member -MemberType $_.MemberType -Name $_.Name -Value $_.Value
                }
                $result += $tempObject
            }
        }
    }

    end {
        write-output $result
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}
