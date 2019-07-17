#===================================================================================================
#   Import Functions
#===================================================================================================
$PublicFunctions  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )

foreach ($File in @($PublicFunctions)) {
    Try {. $File.FullName}
    Catch {Write-Error -Message "Failed to import function $($File.FullName): $_"}
}

Export-ModuleMember -Function $PublicFunctions.BaseName
