# If you don't want to receive toast notifications showing current volume set to false
$toastNotifications = $true

# Used to change Windows OS volume.
# https://www.nirsoft.net/utils/sound_volume_command_line.html
$svcl = "C:\Users\media\svcl.exe"

# https://github.com/JPersson77/LGTVCompanion
$LGTVcli = 'C:\Program Files\LGTV Companion\LGTVcli.exe'

# Windows audio output device name
$deviceName = "LG TV SSCR2"

### Volume functions ###

# My Sonos soundbar goes inactive and when it does is unable to send volume info or update its volume until it needs to play something.
# This wakes it up by softly playing something, even if it wakes up at a high volume.
function activateVolume()
{
    & $svcl "/SetVolume" "$deviceName" 10
    Sleep 1
    [System.Media.SystemSounds]::Hand.Play()
    Sleep 2
    & $svcl "/SetVolume" "$deviceName" 100
}

function getVolume()
{
    $volumeObject = (& $LGTVcli -request com.webos.service.audio/master/getVolume)|ConvertFrom-json
    $currentVolume=$volumeObject.Device1.payload.volumeStatus.volume
    Return [int]$currentVolume
}

function displayVolume()
{
    if ($toastNotifications) { 
        $currentVolume = getVolume
        New-BurntToastNotification -Silent -AppLogo None -Text "Volume: $currentVolume"
        Start-Sleep 3
        Remove-BTNotification
    }
}

function volumeUp()
{
    & $LGTVcli -request com.webos.service.audio/master/volumeUp | Out-Null
}

function volumeDown()
{
    & $LGTVcli -request com.webos.service.audio/master/volumeDown | Out-Null
}

#########################

## Input Control ##
function getInput()
{
    $inputObject = (& $LGTVcli -request com.webos.applicationManager/getForegroundAppInfo)|ConvertFrom-json
    $currentInput=$inputObject.Device1.payload.appId
    Return $currentInput
}

function setHDMI1()
{
    $currentInput = getInput
    If( $currentInput -notmatch "hdmi1") {
        & $LGTVcli -sethdmi1
    }

}

function setHDMI3()
{
    $currentInput = getInput
    If( $currentInput -notmatch "hdmi3") {
        & $LGTVcli -sethdmi3
    }

}

###########################

## Power functions ###
function getPowerState()
{
    $powerObject = (& $LGTVcli -request com.webos.service.tvpower/power/getPowerState)|ConvertFrom-json
    $powerState=$powerObject.Device1.payload.state
    return $powerState
}
function powerOn()
{
    $powerState=getPowerState
    if ($powerState -notmatch "Active") {
        (& $LGTVcli -poweron Device1)
    }
}

function powerOff()
{
    if ($powerState -match "Active") {
        (& $LGTVcli -poweroff Device1)
    }

}

####################