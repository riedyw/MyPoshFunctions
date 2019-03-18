# inspired by: https://stackoverflow.com/questions/45953778/how-to-use-powershell-to-extract-data-from-dll-or-exe-files

function Get-StringResource {
    #region Parameter
    [cmdletbinding(
        DefaultParameterSetName = '',
        ConfirmImpact = 'low'
    )]
    [OutputType([string[]])]
    Param(
        [Parameter(
            Mandatory = $True,
            HelpMessage = 'Enter a ComputerName or IP address',
            Position = 0,
            ParameterSetName = '',
            ValueFromPipeline = $True)
            ]
            [string[]] $ResourceName,
        [Parameter(
            Position = 1,
            HelpMessage = 'Enter an integer port number (1-65535)',
            ParameterSetName = '')]
            [switch] $IncludeOriginal
        )
    #endregion Parameter

begin {
$source = @"
using System;
using System.Runtime.InteropServices;
using System.Text;

public class ExtractData
{
[DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Ansi)]
private static extern IntPtr LoadLibrary([MarshalAs(UnmanagedType.LPStr)]string lpFileName);

[DllImport("user32.dll", CharSet = CharSet.Auto)]
private static extern int LoadString(IntPtr hInstance, int ID, StringBuilder lpBuffer, int nBufferMax);

[DllImport("kernel32.dll", SetLastError = true)]
[return: MarshalAs(UnmanagedType.Bool)]
private static extern bool FreeLibrary(IntPtr hModule);

public string ExtractStringFromDLL(string file, int number) {
    IntPtr lib = LoadLibrary(file);
    StringBuilder result = new StringBuilder(2048);
    LoadString(lib, number, result, result.Capacity);
    FreeLibrary(lib);
    return result.ToString();
}
}
"@

Add-Type -TypeDefinition $source

$ed = New-Object ExtractData
[System.Collections.ArrayList] $returnVal = @()
}

Process {
    foreach ($rn in $ResourceName) {
        write-verbose $rn
        $rn1 = $rn -split ','
        $string = $ed.ExtractStringFromDLL([Environment]::ExpandEnvironmentVariables($rn1[0]).substring(1), $rn1[1].substring(1))
        if ($IncludeOriginal) {
            $obj = new-object psobject -Property ([ordered] @{ Original = $rn; ResourceString = $string})
            write-verbose $obj
        } else {
            $obj = $string
        }
        [void] $returnVal.add($obj)
    }
}

end {
    write-verbose $returnVal.count
    if ($IncludeOriginal) {
        $returnVal #| select-object Original, StringValue
    } else {
        $returnVal
    }

}

}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-StringResource'
    $FuncAlias       = ''
    $FuncDescription = 'Gets a string resource that is referenced in registry or INI file.'
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
