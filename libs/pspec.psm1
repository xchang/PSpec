$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

dir $scriptDir | ? {$_.name -match "\.ps1$"} | foreach {. $_.FullName }