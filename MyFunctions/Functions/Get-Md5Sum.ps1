Function Get-Md5Sum {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
        [Alias("FileName")]
        [string] $File
    )
    Process {
        Try {
            if (Test-Path -path $File) {
                write-verbose -message "File exists: $File"
                $md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
                write-verbose -message "MD5object: $md5"
                $hash = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($(resolve-path -path $File))))
                write-verbose -message "Hash: $hash"
                $hash = $($hash -replace '-', '').ToLower()
                write-verbose -message "Calculating MD5Sum for file: '$file'"
            } else {
                write-verbose -message "The file specified does not exist: '$file'"
                $hash = "ERROR"
            }
            write-output -inputobject $hash
        } Catch {
            write-verbose -message 'Get-Md5Sum encountered an error'
        }
    }
} #EndFunction Get-Md5Sum

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-Md5Sum'
    $FuncAlias       = 'Md5Sum'
    $FuncDescription = 'Calculate MD5 sum of specified file'
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
        set-alias -Name $FuncAlias -Value $FuncName -Description "ALIAS for $FuncName"
        $AliasesToExport += (new-object psobject -property @{ Name = $FuncAlias ; Description = "ALIAS for $FuncName"})
    }
    if ($FuncVarName)
    {
        $VariablesToExport += $FuncVarName
    }
    # Setting the Description property of the function.
    (get-childitem -Path Function:$FuncName).set_Description($FuncDescription)
#endregion Metadata
