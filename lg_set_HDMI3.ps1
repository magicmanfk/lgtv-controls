. C:\Users\media\lg_tv_functions.ps1

$currentInput = GetInput
If($currentInput -notmatch "hdmi3") {
    setHDMI3
}
exit