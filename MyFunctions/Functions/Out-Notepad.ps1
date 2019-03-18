# source http://community.idera.com/powershell/powertips/b/tips/posts/out-notepad-send-information-to-notepad

#requires -Version 2
function Out-Notepad
{
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
        [IntPtr]$child = $type::FindWindowEx($hwnd, [IntPtr]::Zero, "Edit", $null)
        $null = $type::SendMessage($child, 0x000C, 0, $text)
    }
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Out-Notepad'
    $FuncAlias       = ''
    $FuncDescription = 'Takes string from pipeline and will open a new instance of Notepad.exe and paste contents'
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

