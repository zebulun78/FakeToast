# Refresh Module
$ModuleName     = 'FakeToast'

Uninstall-Module -Name $ModuleName -AllVersions -Force
Install-Module -Name $ModuleName -Scope AllUsers -Force
Import-Module -Name $ModuleName -Scope Global -Force
