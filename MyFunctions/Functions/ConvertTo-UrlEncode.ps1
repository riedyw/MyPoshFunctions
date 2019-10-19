Function ConvertTo-UrlEncode ([string] $URL) {
    $Encode = [System.Web.HttpUtility]::UrlEncode($URL)
    Write-Output $Encode
}

Set-Alias -Name 'UrlEncode' -Value 'ConvertTo-UrlEncode'
