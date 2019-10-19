function Out-ClipboardText
{
    [cmdletbinding()]
    param(
        [Parameter(
            Position=0,
            Mandatory=$true,
            ValueFromPipeline=$true)
        ]
        [String] $text
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    process
    {
        powershell -sta -noprofile -command "add-type -an system.windows.forms; [System.Windows.Forms.Clipboard]::SetText('$text')"
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}