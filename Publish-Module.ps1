# Publish Module to local repository
$BuildPath      =   $PSScriptRoot
$ModuleName     =   'FakeToast'
$Repository     =   'YourAwesomeRepo'

Publish-Module -Path $BuildPath -Repository $Repository -NuGetApiKey $ModuleName -Force -Confirm:$False
