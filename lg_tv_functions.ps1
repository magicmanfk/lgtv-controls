# Volume you want to default to on power on
$defaultVolume = 18

# https://www.nirsoft.net/utils/sound_volume_command_line.html
# Used to change Windows OS volume.
$svcl = "C:\Users\media\svcl.exe"

# https://github.com/JPersson77/LGTVCompanion
$LGTVcli = 'C:\Program Files\LGTV Companion\LGTVcli.exe'

$scriptsDir = "C:\Users\media\code\lgtv-controls"

$deviceName = "LG TV SSCR2"

### Volume functions ###
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

function volumeUp()
{
    & $LGTVcli -request com.webos.service.audio/master/volumeUp | Out-Null
}

function volumeDown()
{
    & $LGTVcli -request com.webos.service.audio/master/volumeDown | Out-Null
}

# For whatever reason attempts to set to a specific volume via "-volume"
# did not consistently work, so this is my workaround. 
function setDefaultVolume()
{
    $currentVolume = getVolume
    $volumeAdjustment = $currentVolume - $defaultVolume
    Write-host "Volume is currently $currentvolume"
    Write-host "We need to adjust by $volumeAdjustment to set volume to $defaultVolume"

    if ($VolumeAdjustment -lt 0) {
        1..-$VolumeAdjustment | % { sleep .1 ; volumeUp }
    } elseif ($VolumeAdjustment -gt 0) {
        1..$VolumeAdjustment | % { sleep .1 ; volumeDown }
    }
    $currentVolume = getVolume
    Write-host "After adjustment volume is now $currentvolume"
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