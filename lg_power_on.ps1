. C:\Users\media\lg_tv_functions.ps1

$powerState = getPowerState
Write-Host $powerState
if ($powerState -notmatch "Active") {
    powerOn
    sleep .5
    $currentInput = GetInput
    If($currentInput -notmatch "hdmi1") {
        setHDMI1
    }
    Sleep .5
    activateVolume
    Sleep 2
    setDefaultVolume
}
exit