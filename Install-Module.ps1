$ModuleName             =   'FakeToast'
$ModuleVersion          =   '1.0.0'

Copy-Item -Path "$PSScriptRoot" -Destination "$env:ProgramFiles\WindowsPowerShell\Modules\${ModuleName}\${ModuleVersion}" -Recurse -Force
Install-Module -Name $ModuleName -RequiredVersion $ModuleVersion -Scope AllUsers -Force -Confirm:$False
Import-Module -Name $ModuleName -RequiredVersion $ModuleVersion -Scope Global -Force
