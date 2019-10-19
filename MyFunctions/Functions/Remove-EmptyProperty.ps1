# from: http://community.idera.com/powershell/powertips/b/tips/posts/listing-properties-with-values-part-3

function Remove-EmptyProperty  {

    param (
        [Parameter(Mandatory,ValueFromPipeline)]
            $InputObject,

            [Switch]
            $AsHashTable
    )

    begin
    {
      $props = @()

    }

    process {
        if ($props.Count -eq 0)
        {
            $props = $InputObject |
                Get-Member -MemberType *Property |
                Select-Object -ExpandProperty Name |
                Sort-Object
        }

        $notEmpty = $props | Where-Object {
            -not (($null -eq $InputObject.$_ ) -or
            ($InputObject.$_ -eq '') -or
            ($InputObject.$_.Count -eq 0)) |
                Sort-Object

        }

        if ($AsHashTable)
        {
          $notEmpty |
            ForEach-Object {
                $h = [Ordered]@{}} {
                    $h.$_ = $InputObject.$_
                    } {
                    $h
                    }
        }
        else
        {
          $InputObject |
            Select-Object -Property $notEmpty
        }
    }
}
