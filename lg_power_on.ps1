. C:\Users\media\code\lgtv-controls\lg_tv_functions.ps1

$powerState = getPowerState
Write-Host $powerState
if ($powerState -notmatch "Active") {
    powerOn
    Start-Sleep .5
    $currentInput = GetInput
    If($currentInput -notmatch "hdmi1") {
        setHDMI1
    }
    Start-Sleep .5
    activateVolume
    displayVolume
}
exit
