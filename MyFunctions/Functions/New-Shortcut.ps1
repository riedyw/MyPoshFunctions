# main source: https://gallery.technet.microsoft.com/scriptcenter/New-Shortcut-4d6fb3d8

# run as admin source: https://www.reddit.com/r/PowerShell/comments/7xa4sk/programmatically_create_shortcuts_w_run_as_admin/

Function New-Shortcut {
<#
.SYNOPSIS
    This script is used to create a  shortcut.
.DESCRIPTION
    This script uses a Com Object to create a shortcut.
.PARAMETER Path
    The path to the shortcut file.  .lnk will be appended if not specified.  If the folder name doesn't exist, it will be created.
.PARAMETER TargetPath
    Full path of the target executable or file.
.PARAMETER Arguments
    Arguments for the executable or file.
.PARAMETER Description
    Description of the shortcut.
.PARAMETER HotKey
    Hotkey combination for the shortcut.  Valid values are SHIFT+F7, ALT+CTRL+9, etc.  An invalid entry will cause the function to fail.
.PARAMETER WorkDir
    Working directory of the application.  An invalid directory can be specified, but invoking the application from the shortcut could fail.
.PARAMETER WindowStyle
    Windows style of the application, Normal (1), Maximized (3), or Minimized (7).  Invalid entries will result in Normal behavior.
.PARAMETER Icon
    Full path of the icon file.  Executables, DLLs, etc with multiple icons need the number of the icon to be specified, otherwise the first icon will be used, i.e.:  c:\windows\system32\shell32.dll,99
.PARAMETER Admin
    Used to create a shortcut that prompts for admin credentials when invoked, equivalent to specifying runas.
.NOTES
    Author        : Rhys Edwards
    Email        : powershell@nolimit.to
.INPUTS
    Strings and Integer
.OUTPUTS
    True or False, and a shortcut
.LINK
    Script posted over:  N/A
.EXAMPLE
    New-Shortcut -Path c:\temp\notepad.lnk -TargetPath c:\windows\notepad.exe
    Creates a simple shortcut to Notepad at c:\temp\notepad.lnk
.EXAMPLE
    New-Shortcut "$($env:Public)\Desktop\Notepad" c:\windows\notepad.exe -WindowStyle 3 -admin

    Creates a shortcut named Notepad.lnk on the Public desktop to notepad.exe that launches maximized after prompting for admin credentials.
.EXAMPLE
    New-Shortcut "$($env:USERPROFILE)\Desktop\Notepad.lnk" c:\windows\notepad.exe -icon "c:\windows\system32\shell32.dll,99"

    Creates a shortcut named Notepad.lnk on the user's desktop to notepad.exe that has a pointy finger icon (on Windows 7).
.EXAMPLE
    New-Shortcut "$($env:USERPROFILE)\Desktop\Notepad.lnk" c:\windows\notepad.exe C:\instructions.txt

    Creates a shortcut named Notepad.lnk on the user's desktop to notepad.exe that opens C:\instructions.txt
.EXAMPLE
    New-Shortcut "$($env:USERPROFILE)\Desktop\ADUC" %SystemRoot%\system32\dsa.msc -Admin

    Creates a shortcut named ADUC.lnk on the user's desktop to Active Directory Users and Computers that launches after prompting for admin credentials
#>

#region Parameters
    [CmdletBinding(SupportsShouldProcess = $true)]
    [OutputType($null)]
    param(
        [Parameter(Mandatory=$True,  ValueFromPipelineByPropertyName=$True,Position=0)]
        [Alias("File","Shortcut")]
        [string] $Path,

        [Parameter(Mandatory=$True,  ValueFromPipelineByPropertyName=$True,Position=1)]
        [Alias("Target")]
        [string] $TargetPath,

        [Parameter(ValueFromPipelineByPropertyName=$True,Position=2)]
        [Alias("Args","Argument")]
        [string] $Arguments,

        [Parameter(ValueFromPipelineByPropertyName=$True,Position=3)]
        [Alias("Desc")]
        [string] $Description,

        [Parameter(ValueFromPipelineByPropertyName=$True,Position=4)]
        [string] $HotKey,

        [Parameter(ValueFromPipelineByPropertyName=$True,Position=5)]
        [Alias("WorkingDirectory","WorkingDir")]
        [string] $WorkDir,

        [Parameter(ValueFromPipelineByPropertyName=$True,Position=6)]
        [ValidateSet(1,3,7)]
        [int] $WindowStyle,

        [Parameter(ValueFromPipelineByPropertyName=$True,Position=7)]
        [string] $Icon,

        [Parameter(ValueFromPipelineByPropertyName=$True)]
        [switch] $Admin
    )
#endregion Parameters

    Process {
        If (!($Path -match "^.*(\.lnk)$")) {
            $Path = "$Path`.lnk"
        }
        [System.IO.FileInfo]$Path = $Path
        $ShouldMessage = "WHATIF: Would create SHORTCUT [$($path.fullname)] ARGUMENTS [$($Arguments)] DESCRIPTION [$($Description)] HOTKEY [$($HotKey)] WORKDIR [$($WorkDir)] WINDOWSTYLE [$($WindowStyle)] ICON [$($Icon)]"
        If ($PSCmdlet.ShouldProcess($ShouldMessage))
        {
            Try {
                If (!(Test-Path -Path $Path.DirectoryName)) {
                    mkdir $Path.DirectoryName -ErrorAction Stop | Out-Null
                }
            } Catch {
                Write-Verbose -Message "Unable to create $($Path.DirectoryName), shortcut cannot be created"
                write-output -InputObject $false
                Break
            }
            # Define Shortcut Properties
            $WshShell = New-Object -ComObject WScript.Shell
            $Shortcut = $WshShell.CreateShortcut($Path.FullName)
            $Shortcut.TargetPath = $TargetPath
            $Shortcut.Arguments = $Arguments
            $Shortcut.Description = $Description
            $Shortcut.HotKey = $HotKey
            $Shortcut.WorkingDirectory = $WorkDir
            $Shortcut.WindowStyle = $WindowStyle
            If ($Icon){
                $Shortcut.IconLocation = $Icon
            }

            Try {
                # Create Shortcut
                $Shortcut.Save()
                # Set Shortcut to Run Elevated
                If ($admin) {
                    $TempFileName = [IO.Path]::GetRandomFileName()
                    $TempFile = [IO.FileInfo][IO.Path]::Combine($Path.Directory, $TempFileName)
                    $Writer = New-Object -TypeName System.IO.FileStream $TempFile, ([System.IO.FileMode]::Create)
                    $Reader = $Path.OpenRead()
                    While ($Reader.Position -lt $Reader.Length) {
                        $Byte = $Reader.ReadByte()
                        If ($Reader.Position -eq 22) {$Byte = 34}
                        $Writer.WriteByte($Byte)
                    }
                    $Reader.Close()
                    $Writer.Close()
                    $Path.Delete()
                    Rename-Item -Path $TempFile -NewName $Path.Name | Out-Null
                }
                write-output -InputObject $True
            } Catch {
                Write-Verbose -Message "Unable to create $($Path.FullName)"
                Write-Verbose -Message ($Error[0].Exception.Message)
                write-output -InputObject $False
            }
        }
    }
} #EndFunction New-Shortcut

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'New-Shortcut'
    $FuncAlias       = ''
    $FuncDescription = 'Creates a Windows .LNK shortcut'
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
