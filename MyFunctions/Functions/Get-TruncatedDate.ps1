# source
# https://www.reddit.com/r/usefulscripts/comments/9ghdzo/powershell_setdatetruncate_is_that_dumb_function/

function Get-TruncatedDate
{
<#
Comment Based Help goes here
#>

    [CmdletBinding ()]
    Param
        (
        [Parameter (
            Position = 0,
            ValueFromPipeline
            )]
            [datetime[]]
            $Date = $(Get-Date),

        [Parameter (
            Position = 1
            )]
            [ValidateSet (
                'Millisecond',
                'Second',
                'Minute',
                'Hour',
                'Day',
                'Month'
                )]
            [string]
            $WhereToTruncate = 'Hour'
        )

    begin {
        # nothing here for now
        }

    process
        {
        switch ($WhereToTruncate)
            {
            'MilliSecond' {
                $GD_Params = @{
                    MilliSecond = 0
                    }
                break
                }
            'Second' {
                $GD_Params = @{
                    MilliSecond = 0
                    Second = 0
                    }
                break
                }
            'Minute' {
                $GD_Params = @{
                    MilliSecond = 0
                    Second = 0
                    Minute = 0
                    }
                break
                }
            'Hour' {
                $GD_Params = @{
                    MilliSecond = 0
                    Second = 0
                    Minute = 0
                    Hour = 0
                    }
                break
                }
            'Day' {
                $GD_Params = @{
                    MilliSecond = 0
                    Second = 0
                    Minute = 0
                    Hour = 0
                    Day = 1
                    }
                break
                }
            'Month' {
                $GD_Params = @{
                    MilliSecond = 0
                    Second = 0
                    Minute = 0
                    Hour = 0
                    Day = 1
                    Month = 1
                    }
                break
                }
            } # end >> switch ($WhereToTruncate)

        foreach ($D_Item in $Date)
            {
            $D_Item |
                Get-Date @GD_Params
            }
        } # end >> process {}

    end {
        # nothing here for now
        }

} # end >> function Get-TruncatedDate

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-TruncatedDate'
    $FuncAlias       = ''
    $FuncDescription = 'Returns a truncated date value'
    $FuncVarName     = ''
    if (-not (test-path -Path Variable:AliasesToExport))
    {
        $AliasesToExport = @()
    }
    if (-not (test-path -Path Variable:VariablesToExport))
    {
        $VariablesToExport = @()
    }
    if ($FuncAlias)
    {
        set-alias -Name $FuncAlias -Value $FuncName
        $AliasesToExport += $FuncAlias
    }
    if ($FuncVarName)
    {
        $VariablesToExport += $FuncVarName
    }
    # Setting the Description property of the function.
    (get-childitem -Path Function:$FuncName).set_Description($FuncDescription)
#endregion Metadata
