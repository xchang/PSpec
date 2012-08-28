$current_dir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
#$tools_dir = "$current_dir\..\..\tools"
#$scripts_dir = "$current_dir\..\..\scripts"

#Import-Module "$tools_dir\psake.psm1" -Force
#Import-Module "$tools_dir\ps-utils\ps-utils.psm1" -Force
Import-Module "$current_dir\libs\PSpec\Pspec.psm1" -Force

