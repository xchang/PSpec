

Function AssertFileNotExists([string] $filePath) {
    $is_file_exists = Test-Path $filePath
    Assert($is_file_exists -eq $FALSE) "File: $filePath does exist!"  
}

Function AssertDirectoryEmpty([string] $filePath) {
    $contents = Get-ChildItem $filePath
    Assert($contents -eq $null) "Directory: $filePath is not empty!"  
}