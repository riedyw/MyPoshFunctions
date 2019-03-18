Function Show-FsRight {
<#
.SYNOPSIS
    To list all potential file system rights
.DESCRIPTION
    To list all potential file system rights and to return a psobject with the properties Name, Type, Hex, Dec
.NOTES
    Author:     Bill Riedy
    Version:    1.1
    Date:       2018/09/19
    Notes:      Cleaned up quoting, updated comment based help.
    Version:    1.0
    Date:       2018/03/13
    Notes:      Some rights are 'Combo', a predefined mix of several different 'Single' rights. 'Combo' rights can be checked with -eq. 'Single' rights would need to be checked with -band $($_.dec)
.EXAMPLE
    Show-FsRight
    Would return:
    A listing of all of the explicit filesystemrights

    Name                         Type   Hex                    Dec
    ----                         ----   ---                    ---
    ReadData                     Single 0x00000001               1
    CreateFiles                  Single 0x00000002               2
    AppendData                   Single 0x00000004               4
    ReadExtendedAttributes       Single 0x00000008               8
    WriteExtendedAttributes      Single 0x00000010              16
    ExecuteFile                  Single 0x00000020              32
    DeleteSubdirectoriesAndFiles Single 0x00000040              64
    ReadAttributes               Single 0x00000080             128
    WriteAttributes              Single 0x00000100             256
    Write                        Single 0x00000116             278
    Delete                       Single 0x00010000           65536
    ReadPermissions              Single 0x00020000          131072
    Read                         Single 0x00020089          131209
    ReadAndExecute               Single 0x000200A9          131241
    Modify                       Single 0x000301BF          197055
    ChangePermissions            Single 0x00040000          262144
    TakeOwnership                Single 0x00080000          524288
    Synchronize                  Single 0x00100000         1048576
    Read                         Combo  0x00120089         1179785
    ReadAndExecute               Combo  0x001200A9         1179817
    Read,Write                   Combo  0x0012019F         1180063
    ReadAndExecute,Write         Combo  0x001201BF         1180095
    ReadAndExecute,Modify,Write  Combo  0x001301BF         1245631
    FullControl                  Single 0x001F01FF         2032127
    AccessSystemSecurity         Combo  0x01000000        16777216
    MaximumAllowed               Combo  0x02000000        33554432
    GenericAll                   Combo  0x10000000       268435456
    GenericExecute               Combo  0x20000000       536870912
    GenericWrite                 Combo  0x40000000      1073741824
    GenericRead                  Combo  0x80000000      2147483648
    ReadAndExecuteExtended       Combo  0xFFA0000000 1097901015040
.OUTPUTS
    An array of objects containing the fields Name, Type, Dec, Hex
.LINK
   [System.Security.AccessControl.FileSystemRights]
#>

#region Parameter
    [cmdletbinding()]
    [OutputType([psobject])]
    Param()
#endregion Parameter

    [System.Collections.ArrayList] $returnVar = @()
    $prop       = @{ Name = 'GenericRead' ; Dec = [uint64] '0x80000000'; Hex = '0x80000000'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    write-verbose $object
    $returnVar.Add($object) | out-null

    $prop       = @{ Name = 'GenericWrite' ;  Dec = [uint64] '0x40000000'; Hex = '0x40000000'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name = 'GenericExecute' ;  Dec = [uint64] '0x20000000'; Hex = '0x20000000'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name = 'GenericAll' ;  Dec = [uint64] '0x10000000'; Hex = '0x10000000'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name = 'MaximumAllowed' ;  Dec = [uint64] '0x02000000'; Hex = '0x02000000'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name = 'AccessSystemSecurity' ;  Dec = [uint64] '0x01000000'; Hex = '0x01000000'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name ='Read' ; Dec = [uint64] 1179785 ; Hex = '0x00120089'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name ='Read,Write' ; Dec = [uint64] 1180063 ; Hex = '0x0012019F'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name ='ReadAndExecute' ; Dec = [uint64] 1179817 ; Hex = '0x001200A9'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name ='ReadAndExecuteExtended' ; Dec = [uint64] '0xFFA0000000'; Hex = '0xFFA0000000'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name ='ReadAndExecute,Modify,Write' ; Dec = [uint64] 1245631 ; Hex = '0x001301BF'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    $prop       = @{ Name ='ReadAndExecute,Write' ; Dec = [uint64] 1180095 ; Hex = '0x001201BF'; Type = 'Combo' }
    $object     = New-Object -TypeName PSObject -Prop $prop
    $returnVar.Add($object) | out-null

    [System.Enum]::Getvalues([System.Security.AccessControl.FileSystemRights]) |
        foreach-object { 
            $prop       = @{ Name = $($_.tostring()) ; Dec = ([uint64] $_) ; Hex = ("0x{0:X8}" -f [uint64] $_); Type = 'Single' }
            $object     = New-Object -TypeName PSObject -Prop $prop
            $returnVar.Add($object) | out-null
        }
    
        # select-object @{Name = 'Name'; Expression = {$_}},
            # @{Name = 'Dec';     Expression = {[Int32] $_}},
            # @{Name = 'Hex';     Expression = {"0x{0:X8}" -f [uint64] $_}},
            # @{Name = 'Type';    Expression = {'Single'}} |
            # select-object name, dec, hex, type -unique
    # $returnVar = $returnVar | sort-object -Property Dec
    #write-output ($returnVar | select-object Name, Type, Hex, Dec)
    write-output ($returnVar | sort-object -Property Dec | select-object Name, Type, Hex, Dec -Unique)
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Show-FsRight'
    $FuncAlias       = ''
    $FuncDescription = 'To list all potential file system rights'
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
