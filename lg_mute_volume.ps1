. C:\Users\media\code\lgtv-controls\lg_tv_functions.ps1

& "C:\Program Files\LGTV Companion\LGTV Companion.exe" -button MUTE device1
$volumeObject = (& $LGTVcli -request com.webos.service.audio/master/getVolume)|ConvertFrom-json
$currentlyMuted=$volumeObject.Device1.payload.volumeStatus.muteStatus
if ( $currentlyMuted ) {
    displayVolume
}