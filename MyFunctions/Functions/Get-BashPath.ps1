function Get-BashPath {
    #region Parameter
    [cmdletbinding()]
    [OutputType([psobject])]
    Param(
        [Parameter(Mandatory = $True, HelpMessage = 'Enter a path to resolve. * and ? are acceptable wildcards',
            Position = 0, ParameterSetName = '', ValueFromPipeline = $True)]
            [string] $Path,

        [Parameter()]
            [switch] $IncludeOriginal
        )
    #endregion Parameter

    $resolve = [array] (resolve-path $Path).Path
    if (-not $resolve) {
        # nothing returned
        return $null
    }

# .replace(' ','\ ')
    foreach ($r in $resolve) {
        $bash = ('/' + $r.replace('\','/').replace(':','').replace(' ','\ '))
        if ($IncludeOriginal) {
            new-object psobject -prop @{ Posh = $r; bash = $bash}
        }
        else {
            $bash
        }
    }
}