Function Spec {
    [CmdletBinding()]  
    param(
        [Parameter(Position=0,Mandatory=1)][string]$name,
        [Parameter(Position=1,Mandatory=0)][scriptblock]$action
    )

    $error.clear()
    $pspec.totalTestsNumber = $pspec.totalTestsNumber + 1

    try {
        if ($pspec.results.ContainsKey($name)) {
            throw "Spec with a same name already exists."
        }
        & $action
    } catch [Exception] {
        $errorMsg = $_.Exception.Message 
    }

    if ($errorMsg -ne $null) {
        $pspec.results[$name] = $FALSE
        $pspec.failedTestsNumber = $pspec.failedTestsNumber + 1 
        Write-Fail "$name ... FAILED!"
        Write-Fail "Error: $errorMsg"
    } else {
        $pspec.results[$name] = $TRUE
        $pspec.succeedTestsNumber = $pspec.succeedTestsNumber + 1
        Write-Success "$name ... SUCCEED!"
    }
}

Function Invoke-Specs([string]$specPath){
    dir $specPath | ? {$_.name -match "\.ps1$"} | foreach {& $_.FullName }

    $total = $pspec.totalTestsNumber
    $succeed = $pspec.succeedTestsNumber
    $failed = $pspec.failedTestsNumber

    Write-Host
    Write-Host "$total specs run, $succeed succeeded, $failed failed."
}

Function Write-Fail ([string] $msg) {
    Write-Host $msg -f RED
}

Function Write-Success ([string] $msg) {
    Write-Host $msg -f GREEN
}

Function Write-Logo {
    $version = $pspec.version
    Write-Host "PSpec - A test framework for Windows PowerShell"
    Write-Host "Verison $version"
    Write-Host
}


$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Script:pspec = @{}
$pspec.version = "0.0.1"
$pspec.context = new-object system.collections.stack
$pspec.results = @{}
$pspec.Set_Item("specPath", "$currentDir\..\specs")
$pspec.totalTestsNumber = 0
$pspec.succeedTestsNumber = 0
$pspec.failedTestsNumber = 0

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

dir $scriptDir | ? {$_.name -match "\.ps1$"} | foreach {. $_.FullName }

Write-Logo