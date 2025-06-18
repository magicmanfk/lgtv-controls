. C:\Users\media\code\lgtv-controls\lg_tv_functions.ps1

# Remove everything here down except the last line if you don't want the toast notification when you unmute.
$volumeObject = (& $LGTVcli -request com.webos.service.audio/master/getVolume)|ConvertFrom-json
$currentlyMuted=$volumeObject.Device1.payload.volumeStatus.muteStatus
if ( $currentlyMuted ) { 
    displayVolume
}
& $LGTVcli -button MUTE device1
