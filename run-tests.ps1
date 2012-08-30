$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$lib_dir = "$root\libs"

Import-Module "$root\libs\PSpec.psm1" -Force

$specs_dir = "$root\specs"
dir $specs_dir | ? {$_.name -match "\.ps1$"} | foreach {& $_.FullName }

#Write-Host "$pspec.totalTestsNumber tests run, $pspec.succeedTestsNumber succeed, $pspec.failedTestsNumber failed."