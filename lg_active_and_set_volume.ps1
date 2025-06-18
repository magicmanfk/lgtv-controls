. C:\Users\media\code\lgtv-controls\lg_tv_functions.ps1

$currentInput = GetInput
If($currentInput -match "hdmi1") {
    activateVolume
    Start-Sleep 2
    setDefaultVolume
}
exit