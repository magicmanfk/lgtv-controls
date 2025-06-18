. C:\Users\media\code\lgtv-controls\lg_tv_functions.ps1

$volumeObject = (& $LGTVcli -request com.webos.service.audio/master/getVolume)|ConvertFrom-json
$currentlyMuted=$volumeObject.Device1.payload.volumeStatus.muteStatus

& "C:\Program Files\LGTV Companion\LGTV Companion.exe" -button MUTE device1

if ( $currentlyMuted ) {
    activateVolume
    displayVolume
}