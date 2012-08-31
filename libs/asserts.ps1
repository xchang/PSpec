Function Assert($condition, $errorMsg) {
	if (-not $condition) {
		throw "$errorMsg"
	}
}

Function AssertEquals($expected, $actual) {
	Assert ($expected -eq $actual) "$expected does NOT equal to $actual"
}

Function AssertNotEquals($expected, $actual) {
    Assert ($expected -ne $actual) "$expected equals to $actual"
}

Function AssertFileExists([string] $filePath) {
    $specPath = $pspec.Get_Item("specPath")
    $is_file_exists = Test-Path "$specPath\$filePath"
    Assert ($is_file_exists) "File: $filePath does NOT exist"
}

Function AssertFileNotExists([string] $filePath) {
    $specPath = $pspec.Get_Item("specPath")
    $is_file_exists = Test-Path "$specPath\$filePath"
    Assert (-not $is_file_exists) "File: $filePath does exist"
}

Function AssertDirectoryIsEmpty([string] $filePath) {
    $specPath = $pspec.Get_Item("specPath")
    $contents = Get-ChildItem "$specPath\$filePath"
    Assert ($contents -eq $null) "Directory: $specPath\$filePath is not empty!"
}

Function AssertDirectoryNotEmpty([string] $filePath) {
    $specPath = $pspec.Get_Item("specPath")
    $contents = Get-ChildItem "$specPath\$filePath"
    Assert ($contents -ne $null) "Directory: $specPath\$filePath is empty!"
}