param ([string] $specName)
$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

Import-Module "$root\libs\PSpec.psm1" -Force

$specs_dir = "$root\specs"

Invoke-SingleSpec $specName $specs_dir