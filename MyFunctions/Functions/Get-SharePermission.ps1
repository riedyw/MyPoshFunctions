function Get-SharePermission {
<#
.SYNOPSIS
    To get permission information on specified ShareName
.DESCRIPTION
    To get permission information on specified ShareName
.PARAMETER ShareName
    The name of the share, exact match only
.NOTES
    Author:     Bill Riedy
    Version:    1.0
    Date:       2018/03/13
    Notes:      None at this time
.EXAMPLE
    Get-SharePermission -ShareName "C$"
    Would return:
    A listing of all permissions on the "C$" share
.OUTPUTS
    An array of objects containing the fields ComputerName, ShareName, Domain, ID, AccessMask, AceType
#>
    [cmdletbinding()]
    param([string]$sharename)
    $ShareSec = Get-WmiObject -Class Win32_LogicalShareSecuritySetting
    ForEach ($ShareS in ($ShareSec | Where-object {$_.Name -eq $sharename}))
    {
        $SecurityDescriptor = $ShareS.GetSecurityDescriptor()
        $myCol = @()
        ForEach ($DACL in $SecurityDescriptor.Descriptor.DACL)
        {
            $myObj = "" | Select-Object -property ComputerName, ShareName, Domain, ID, AccessMask, AceType
            $myObj.ComputerName = $ShareS.PsComputerName
            $myObj.ShareName = $ShareS.Name
            $myObj.ID = $DACL.Trustee.Name
            $myObj.Domain = $DACL.Trustee.Domain
            Switch ($DACL.AccessMask)
            {
                2032127 {$AccessMask = "FullControl"}
                1179785 {$AccessMask = "Read"}
                1180063 {$AccessMask = "Read, Write"}
                1179817 {$AccessMask = "ReadAndExecute"}
                -1610612736 {$AccessMask = "ReadAndExecuteExtended"}
                1245631 {$AccessMask = "ReadAndExecute, Modify, Write"}
                1180095 {$AccessMask = "ReadAndExecute, Write"}
                268435456 {$AccessMask = "FullControl (Sub Only)"}
                default {$AccessMask = $DACL.AccessMask}
            }
            $myObj.AccessMask = $AccessMask
            Switch ($DACL.AceType)
            {
                0 {$AceType = "Allow"}
                1 {$AceType = "Deny"}
                2 {$AceType = "Audit"}
            }
            $myObj.AceType = $AceType
            Clear-Variable -name AccessMask -ErrorAction SilentlyContinue
            Clear-Variable -name AceType -ErrorAction SilentlyContinue
            $myCol += $myObj
        }
    }
    Return $myCol
} #EndFunction Get-SharePermission

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-SharePermission'
    $FuncAlias       = ''
    $FuncDescription = 'Gets share permissions'
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
