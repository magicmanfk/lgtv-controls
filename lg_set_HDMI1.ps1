﻿. C:\Users\media\code\lgtv-controls\lg_tv_functions.ps1

$currentInput = GetInput
If($currentInput -notmatch "hdmi1") {
    setHDMI1
    activateVolume
    displayVolume
}
exit