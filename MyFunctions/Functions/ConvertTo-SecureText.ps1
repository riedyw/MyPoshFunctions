Function ConvertTo-SecureText {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [parameter(ValueFromPipeLine=$True,ValueFromPipeLineByPropertyName=$True)]
        [Alias("ask")]
        [string] $Prompt = "Please enter text"
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    } #close begin block

    process {
        $secure = Read-Host -AsSecureString  "$Prompt"
        $encrypted = ConvertFrom-SecureString -SecureString $secure
        $encrypted
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    } #close end block

} #EndFunction ConvertTo-SecureText
