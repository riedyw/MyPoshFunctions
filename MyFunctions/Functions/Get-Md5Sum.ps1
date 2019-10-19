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

Set-Alias -Name 'Md5Sum' -Value 'Get-Md5Sum'
