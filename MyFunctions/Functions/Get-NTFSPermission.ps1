function Get-NTFSPermission {
<#
.SYNOPSIS
    To get permission information on a specified Path or folder name
.DESCRIPTION
    To get permission information on a specified Path or folder name
.PARAMETER Path
    The name of the path
.EXAMPLE
    Get-NTFSPermission -Path "C:\Temp"

    Would return:

    A listing of all of the shares
.EXAMPLE
    Get-Share -ShareName "My"

    Would return:

    A listing of all of the shares that contain the string "My"
.EXAMPLE
    Get-Share -ShareName -IgnoreAdmin

    Would return:

    A listing of all of the shares minus the automatic Admin shares
.OUTPUTS
    An array of objects containing the fields ComputerName, ShareName, Type, Status
#>
    [CmdletBinding()]
    param([string] $Path)

    write-verbose -message "Path specified was [$($Path)]"
    if (-not(Test-Path -Path $Path)) {
        Write-Error -message "Path [$($Path)] does not exist"
        return
    } else {
        Write-Verbose -message "The path [$($Path)] exists"
    }
    $acl = get-acl -path $Path
    $aclPermissions = $acl | select-object -expandproperty access
    $ComputerName = $env:COMPUTERNAME
    $returnVariable = @()


    $aclPermissions | foreach-object {
        $tmpObject = "" | Select-object -property ComputerName, Path, AccessType, IdentityReference, Rights, IsInherited, InheritanceFlags, PropogationFlags
        $tmpObject.ComputerName         = $ComputerName
        $tmpObject.Path                 = $Path
        $tmpObject.AccessType           = $_.AccessControlType
        $tmpObject.IdentityReference    = $_.IdentityReference
        $tmpObject.InheritanceFlags     = $_.InheritanceFlags
#        $tmpObject.Rights               = ConvertFrom-AccessMask -AccessMask $_.FileSystemRights.value__
        $tmpObject.Rights               = ConvertFrom-FsRights -Rights $_.FileSystemRights.value__
        $tmpObject.PropogationFlags     = $_.PropogationFlags
        $returnVariable                += $tmpObject
    }

    write-output -inputobject $returnVariable
} # EndFunction Get-NTFSPermission

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-NTFSPermission'
    $FuncAlias       = ''
    $FuncDescription = 'Gets permission on NTFS folder/drive'
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
