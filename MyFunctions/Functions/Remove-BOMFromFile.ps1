
# Source: http://community.idera.com/powershell/powertips/b/tips/posts/dealing-with-file-encoding-and-bom

function Remove-BomFromFile($OldPath, $NewPath) {

    $Content = Get-Content $OldPath -Raw
    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($NewPath, $Content, $Utf8NoBomEncoding)
}
