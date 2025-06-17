. C:\Users\media\lg_tv_functions.ps1

$currentInput = GetInput
If($currentInput -match "hdmi1") {
    activateVolume
    $currentVolume = getVolume
    Sleep 2
    setDefaultVolume
}
exit