Function New-FakeToast {
<#  
.SYNOPSIS  
    Generates a fake toast message.
.DESCRIPTION  
     Generates a fake toast message.
.EXAMPLE
	New-FakeToast -Profile FT-Default -Title 'Fake Toast!' -Message 'Message' -Icon 'FakeToast.png' -ActionName 'Install' -DismissName 'Dismiss' -ActionFunction 'Launch-Action'
.LINK
	https://github.com/zebulun78/FakeToast
#>
[CmdletBinding()]
Param(
	[Parameter(Mandatory=$False,HelpMessage='Supply a profile name, i.e. "FT-Default"')]
    [string]$Profile = 'FT-Default',
    [Parameter(Mandatory=$False,HelpMessage='Supply a Title')]
    [string]$Title = 'Fake Toast!',
    [Parameter(Mandatory=$False,HelpMessage='Supply a Message')]
    [string]$Message = 'This is the body of your fake toast message.  Space is limited.  Make it count.',
    [Parameter(Mandatory=$False,HelpMessage='Supply an icon file ("FakeToast.png")')]
    [string]$Icon = 'FakeToast.png',
    [Parameter(Mandatory=$False,HelpMessage='Supply an action name, i.e. "Install"')]
    [string]$ActionName = 'Install',
    [Parameter(Mandatory=$False,HelpMessage='Supply the dismiss name, i.e. "Dismiss"')]
    [string]$DismissName = 'Dismiss',
    [Parameter(Mandatory=$False,HelpMessage='Supply an action function name, i.e. "Start-Nothing"')]
    [string]$ActionFunction = 'Start-Nothing',
    [Parameter(Mandatory=$False,HelpMessage='Run in development mode?')]
    [switch]$DevMode = $False
)

$PrivateFolder = $PSScriptRoot.Replace('Public','Private')

# Add the required assemblies 
Add-Type -AssemblyName PresentationFramework,System.Windows.Forms

# Bild XAML
$xaml = (Get-Content "$PrivateFolder\Profiles\$Profile.xaml" -Raw)
$xaml = $xaml.Replace("##PSScriptRoot##","$PSScriptRoot")
$xaml = $xaml.Replace("##PrivateFolder##","$PrivateFolder")
$xaml = $xaml.Replace("##Name##","Information")
$xaml = $xaml.Replace("##Title##",$Title)
$xaml = $xaml.Replace("##Message##",$Message)
$xaml = $xaml.Replace("##Icon##",$Icon)
$xaml = $xaml.Replace("##ActionName##",$ActionName)
$xaml = $xaml.Replace("##DismissName##",$DismissName)
If($DevMode -eq $true){$xaml = $xaml.Replace("##Gridlines##",'ShowGridLines="True"')}else{$xaml = $xaml.Replace("##Gridlines##","")}
[xml]$xaml = $xaml

# XAML Forms
$script:window = [Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xaml))
$xaml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name ($_.Name) -Value $window.FindName($_.Name) -Scope Script }

# Common Functions
. "$PrivateFolder\Functions\FakeToast.Functions.ps1"

# Click Dismiss
$window.FindName("Dismiss").add_click({
    $window.Close()
})

# Click Action
$window.FindName("Action").add_click({
    $window.Close()
    & $ActionFunction
})

$window.Left = $([System.Windows.SystemParameters]::WorkArea.Width-$window.Width)
$window.Top = $([System.Windows.SystemParameters]::WorkArea.Height-$window.Height)
# [void]$window.ShowDialog()
# $window.ShowDialog() | Out-Null
$async = $window.Dispatcher.InvokeAsync({[void]$window.ShowDialog()})
[void]$async.Wait()
}
