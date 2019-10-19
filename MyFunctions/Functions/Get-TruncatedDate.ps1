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
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
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
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
        }

} # end >> function Get-TruncatedDate
