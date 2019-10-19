Function Get-ZipContent {
    [Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem') | out-null
    foreach($sourceFile in (Get-ChildItem -filter '*.zip')) {
        [IO.Compression.ZipFile]::OpenRead($sourceFile.FullName).Entries.FullName |
            foreach-object { write-output -inputobject "$sourcefile`:$_" }
    }
}
