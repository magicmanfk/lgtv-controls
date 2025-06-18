. C:\Users\media\code\lgtv-controls\lg_tv_functions.ps1

$powerState = getPowerState
if ($powerState -notmatch "Active") {
    & C:\Users\media\code\lgtv-controls\lg_power_on.ps1
} else { 
    powerOff 
}
exit