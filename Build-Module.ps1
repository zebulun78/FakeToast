# Build Module
$Author                 =   'Curtis Ling'
$CompanyName            =   'DeploymentGeek'
$ModuleName             =   'FakeToast'
$Description            =   'Toast messages, but not really.'
$Version                =   '1.0.0'
$GUID                   =   '34101815-6b6b-41f3-b2d3-26b17677cbb4'
$HelpInfoURI            =   "https://github.com/zebulun78/FakeToast"
$CurrentYear            =   ((Get-Date).year)
$Copyright              =   "(c) $CurrentYear $CompanyName. All rights reserved."

New-ModuleManifest -Path "$ModuleName.psd1" -Author $Author -CompanyName $CompanyName -Description $Description -HelpInfoUri $HelpInfoURI -Copyright $Copyright -ModuleVersion $Version -GUID $GUID -RootModule "$ModuleName.psm1" -FunctionsToExport '*' -FileList "Public\*","Private\*","Private\Functions\*","Private\Images\*","Private\Profiles\*"
