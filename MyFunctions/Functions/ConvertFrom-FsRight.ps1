Function ConvertFrom-FsRight {
<#
.SYNOPSIS
    To convert a [uint32] FileSystemRight value into a human readable form
.DESCRIPTION
    To convert a [uint32] FileSystemRight value into a human readable form using normal text
.PARAMETER Rights
    The filesystemrights value determined by: get-acl -Path $Path | select-object -expand access | select-object FileSystemRights
    Alternatively a [uint32] value could be passed from the command line. Hex values need to be enclosed in quotes.
.EXAMPLE
    ConvertFrom-FsRight -Rights "0x1F01FF"
    Would return
    FullControl
.EXAMPLE
    ConvertFrom-FsRight -Rights "0x1301BF"
    Would return
    ReadAndExecute,Modify,Write
.EXAMPLE
    ConvertFrom-FsRight -Rights 268435456
    Would return
    GenericAll
.LINK
    Get-ACL
.OUTPUTS
    A [string] of all the applicable rights in readable form
#>

#region Parameters
    [CmdletBinding()]
    [OutputType([string])]
    param([uint64] $Rights)
#endregion Parameters

    $temp = @()
    $fsPermission = Show-FsRight -Verbose:$false
    $MatchFound = $false
    $fsPermission | foreach-object {
        #write-verbose "Name = [$($_.name)], Value = [$($_.Dec)]"
        if ($Rights -eq $_.Dec) {
            $temp += $_.Name
            $MatchFound = $true
            write-verbose "Temp now equal to [$($temp -join ',')]"
            write-output -inputobject ( $_.Name )
            break
        }
    }
    if ( $MatchFound ) {
        return
    }

    # Simple permissions hit a match, output the variable and return
#    if ($temp) {
#        write-output -inputobject ( $temp -join ',' )
#    }
    $fsPermission | foreach-object {
        #write-verbose "Name = [$($_.name)], Value = [$($_.Dec)]"
        if ($Rights -band $_.Dec) {
            $temp += $_.Name
            $MatchFound = $true
            write-verbose "Temp now equal to [$($temp -join ',')]"
        }
    }
    $MatchFound | out-null
    # Simple permissions hit a match, output the variable and return
    if ( $MatchFound ) {
        write-output -inputobject ( $temp -join ',' )
    } else {
        write-output -inputobject $null
    }
} #EndFunction ConvertFrom-FsRight

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'ConvertFrom-FsRight'
    $FuncAlias       = ''
    $FuncDescription = 'To convert a [uint32] FileSystemRight value into a human readable form'
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
