# Common Variables Go Here

# Launch Functions
Function Start-Nothing {
    Write-Verbose 'Doing nothing ...' -Verbose
}

Function Start-UpdateTS {
    # Build TS Object
    $TSName = 'Install Software Updates (Self-Service)'
    $CMUI = New-Object -ComObject "UIResource.UIResourceMgr"
    $TS = ($CMUI.GetAvailableApplications() | Where-Object PackageName -eq $TSName)
    $CMUI.ExecuteProgram($($TS.ID),$($TS.PackageID),$true)
    Write-Verbose "Launching Task Sequence: $TSName ..." -Verbose
}

Function Resume-TaskSequence {
    $TSEnv = New-Object -ComObject Microsoft.SMS.TSEnvironment
    $TSEnv.Value("ResumeTS") = 'True'
    Write-Verbose 'Resuming Task Sequence ...' -Verbose
}
