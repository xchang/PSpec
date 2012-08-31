Spec "should pass for an existing file" {
	AssertFileExists ".\file_spec.ps1"
}

Spec "should pass for not existing files" {
	AssertFileNotExists ".\nonexistfile.ps1"
}

Spec "should pass for verifying directory is empty" {
	AssertDirectoryIsEmpty "..\env\emptyDirectory"
}

Spec "should pass for verifying directory is NOT empty" {
	AssertDirectoryNotEmpty "..\env\"
}