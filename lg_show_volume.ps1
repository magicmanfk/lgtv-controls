. C:\Users\media\code\lgtv-controls\lg_tv_functions.ps1

$currentVolume = Get-Volume
if($currentVolume -eq 0 ) {
    activateVolume
}
displayVolume
