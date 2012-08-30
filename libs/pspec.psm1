Function Spec {
    [CmdletBinding()]  
    param(
        [Parameter(Position=0,Mandatory=1)][string]$name = $null,
        [Parameter(Position=1,Mandatory=0)][scriptblock]$action = $null
    )

    $error.clear()
    $pspec.totalTestsNumber ++
    $pspec.currentTestName = $name
    try {
        & $action
    }catch {
        $errorMsg = $_
    }

    if ($pspec.results[$name] -eq $TRUE) {
        $pspec.succeedTestNumber ++
    	Write-Host "$name ... SUCCEED!" -f $correctColor
    } else {
        $pspec.failedTestNumber ++
    	Write-Host "$name ... FAILED!" -f $errorColor
    	Write-Host "Error: $errorMsg" -f $errorColor
    }
}

Function AssertEquals($expected, $actual) {
	if ($expected -ne $actual) {
        $pspec.results.Add($pspec.currentTestName, $FALSE)
		throw "$expected does NOT equal to $actual"
	}

    $pspec.results.Add($pspec.currentTestName, $TRUE)
}

Function AssertNotEquals($expected, $actual) {
    if ($expected -eq $actual) {
        $pspec.results.Add($pspec.currentTestName, $FALSE)
        throw "$expected equals to $actual"
    }

    $pspec.results.Add($pspec.currentTestName, $TRUE)
}

Function AssertFileExists([string] $filePath) {
    $is_file_exists = Test-Path $filePath
    if (-not $is_file_exists) {
        $pspec.results.Add($pspec.currentTestName, $FALSE)
        throw "File: $filePath does NOT exist"
    } 

    $pspec.results.Add($pspec.currentTestName, $TRUE)
}

$Script:pspec = @{}
$pspec.version = "0.0.1"
$pspec.context = new-object system.collections.stack
$pspec.results = @{}
$pspec.totalTestsNumber = 0;
$pspec.succeedTestsNumber = 0;
$pspec.failedTestsNumber = 0;

$errorColor = "RED"
$correctColor = "GREEN"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

dir $scriptDir | ? {$_.name -match "\.ps1$"} | foreach {. $_.FullName }