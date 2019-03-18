Function Show-SpecialFolder {
    $SpecialFolders = [System.Enum]::GetNames([System.Environment+SpecialFolder]) | sort-object
    # $SpecialFolders = @(
    # "AdminTools"
    # "ApplicationData"
    # "CDBurning"
    # "CommonAdminTools"
    # "CommonApplicationData"
    # "CommonDesktopDirectory"
    # "CommonDocuments"
    # "CommonMusic"
    # "CommonOemLinks"
    # "CommonPictures"
    # "CommonProgramFiles"
    # "CommonProgramFilesX86"
    # "CommonPrograms"
    # "CommonStartMenu"
    # "CommonStartup"
    # "CommonTemplates"
    # "CommonVideos"
    # "Cookies"
    # "Desktop"
    # "DesktopDirectory"
    # "Favorites"
    # "Fonts"
    # "History"
    # "InternetCache"
    # "LocalApplicationData"
    # "LocalizedResources"
    # "MyComputer"
    # "MyDocuments"
    # "MyMusic"
    # "MyPictures"
    # "MyVideos"
    # "NetworkShortcuts"
    # "Personal"
    # "PrinterShortcuts"
    # "ProgramFiles"
    # "ProgramFilesX86"
    # "Programs"
    # "Recent"
    # "Resources"
    # "SendTo"
    # "StartMenu"
    # "Startup"
    # "System"
    # "SystemX86"
    # "Templates"
    # "UserProfile"
    # "Windows"
    # )
    write-output $SpecialFolders
} #endfunction Enum-SpecialFolders

#region Metadata
# These variables are used to set the Description property of the function.
# and whether they are meant to be exported

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue

$FuncName        = 'Show-SpecialFolder'
$FuncAlias       = ''
$FuncDescription = 'To list the special folder names'
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
