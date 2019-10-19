# source http://community.idera.com/powershell/powertips/b/tips/posts/out-notepad-send-information-to-notepad

#requires -Version 2
function Out-Notepad {
<#
.SYNOPSIS
    Sends text to Notepad.exe
.DESCRIPTION
    Sends text to Notepad.exe
.PARAMETER Text
    A string to pass into Notepad.exe
.NOTES
    Author:     Bill Riedy
.EXAMPLE
    "This is a test" | Out-Notepad
#>
    [cmdletbinding()]
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        [AllowEmptyString()]
        $Text
    )
    begin
    {
        $sb = New-Object -Typename System.Text.StringBuilder
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }
    process
    {
        $null = $sb.AppendLine($Text)
    }
    end
    {
        $text = $sb.ToString()
        $process = Start-Process notepad -PassThru
        $null = $process.WaitForInputIdle()
        $sig = '
        [DllImport("user32.dll", EntryPoint = "FindWindowEx")]public static extern IntPtr FindWindowEx(IntPtr hwndParent, IntPtr hwndChildAfter, string lpszClass, string lpszWindow);
        [DllImport("User32.dll")]public static extern int SendMessage(IntPtr hWnd, int uMsg, int wParam, string lParam);
    '
        $type = Add-Type -MemberDefinition $sig -Name APISendMessage -PassThru
        $hwnd = $process.MainWindowHandle
        [IntPtr] $child = $type::FindWindowEx($hwnd, [IntPtr]::Zero, "Edit", $null)
        $null = $type::SendMessage($child, 0x000C, 0, $text)
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }
}
