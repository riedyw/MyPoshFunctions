# Source https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/converting-securestring-to-clear-text

function Read-HostSecret([Parameter(Mandatory)] $Prompt) {

    $password = Read-Host -Prompt $Prompt -AsSecureString
    [PSCredential]::new("X", $Password).GetNetworkCredential().Password
}
