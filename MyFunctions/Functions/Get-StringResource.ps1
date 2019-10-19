# inspired by: https://stackoverflow.com/questions/45953778/how-to-use-powershell-to-extract-data-from-dll-or-exe-files
#
# in desktop.ini in 'My Documents' folder
#
#[.ShellClassInfo]
#LocalizedResourceName=@%SystemRoot%\system32\windows.storage.dll,-21770
#@%SystemRoot%\system32\windows.storage.dll,-21770
#resolves to
#Documents

function Get-StringResource {
    #region Parameter
    [cmdletbinding(
        DefaultParameterSetName = '',
        ConfirmImpact = 'low'
    )]
    [OutputType([System.Object[]])]
    Param(
        [Parameter(
            Mandatory = $True,
            HelpMessage = 'Enter a resource string in the form "^@[\x20-\x7f]+,-\d+$"',
            Position = 0,
            ParameterSetName = '',
            ValueFromPipeline = $True)
            ]
            [ValidatePattern('^@[\x20-\x7f]+,-\d+$')]
            [string[]] $ResourceName,
        [Parameter(
            Position = 1,
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
