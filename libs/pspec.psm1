Function Spec {
    [CmdletBinding()]  
    param(
        [Parameter(Position=0,Mandatory=1)][string]$name = $null,
        [Parameter(Position=1,Mandatory=0)][scriptblock]$action = $null
    )

    $error.clear()
    $pspec.totalTestsNumber = $pspec.totalTestsNumber + 1
    $pspec.currentTestName = $name
    try {
        & $action
    }catch {
        $errorMsg = $_
    }

    if ($pspec.results[$name] -eq $TRUE) {

        $pspec.succeedTestsNumber = $pspec.succeedTestsNumber + 1
    	Write-Host "$name ... SUCCEED!" -f $correctColor
    } else {
        $pspec.failedTestsNumber = $pspec.failedTestsNumber + 1 
    	Write-Host "$name ... FAILED!" -f $errorColor
    	Write-Host "Error: $errorMsg" -f $errorColor
    }
}

Function Invoke-Specs([string]$specPath){
    dir $specPath | ? {$_.name -match "\.ps1$"} | foreach {& $_.FullName }

    $total = $pspec.totalTestsNumber
    $succeed = $pspec.succeedTestsNumber
    $failed = $pspec.failedTestsNumber

    Write-Host "$total tests run, $succeed succeeded, $failed failed."
}

$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Script:pspec = @{}
#$pspec.version = "0.0.1"
$pspec.context = new-object system.collections.stack
$pspec.results = @{}
$pspec.Set_Item("specPath", "$currentDir\..\specs")
$pspec.totalTestsNumber = 0
$pspec.succeedTestsNumber = 0
$pspec.failedTestsNumber = 0
$errorColor = "RED"
$correctColor = "GREEN"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

dir $scriptDir | ? {$_.name -match "\.ps1$"} | foreach {. $_.FullName }