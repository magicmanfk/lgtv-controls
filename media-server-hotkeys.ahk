; Quick explanation of syntax:
; ^ - ctrl key
; ! - alt key
; :: - autohotkey syntax, marks end of input
;
; So, for example:
;     ^!d::
; means, "press 'd' while holding ctrl and alt".

;### Variables section - Set these to your own paths ###

; More info on run-hidden: https://github.com/stax76/run-hidden
powershell := "C:\Users\media\run-hidden.exe powershell.exe"
scriptsDir := "C:\Users\media\code\lgtv-controls\"
lgtvCompanion := "C:\Program Files\LGTV Companion\LGTV Companion.exe"

;### MAIN SECTION ###

;## Corner Clock Control ##
; Toggle dsclock on or off (clock in corner of screen)
^!d::
{
Run (powershell ' -file ' scriptsDir 'dsclock-toggle.ps1')
}               

;## HDMI Inputs ##

; Set HDMI to PC (HDMI 1)
^1::
{
Run (powershell ' -file ' scriptsDir 'lg_set_HDMI1.ps1')
}

; Set HDMI to Switch (HDMI 3)
^3::
{
Run (powershell ' -file ' scriptsDir 'lg_set_HDMI3.ps1')
}

;## Volume Control ##

; Mute Toggle
Volume_Mute::
{
Run (lgtvCompanion ' -button MUTE device1')
}

; Show current volume
^Volume_Mute::
^Volume_Down::
^Volume_Up::
{
Run (powershell ' -file ' scriptsDir 'lg_show_volume.ps1')
}

; Raise Volume
Volume_Up::
{
Run (lgtvCompanion ' -button VOLUMEUP device1')
}

; Lower Volume
Volume_Down::
{
Run (lgtvCompanion ' -button VOLUMEDOWN device1')
}

;## Power Control ##

; Power Toggle
^Enter::
{
Run (powershell ' -file ' scriptsDir '\lg_power_toggle.ps1')
}

; Simple Power On
~Esc::
~Ctrl::
{
Run (powershell ' -file ' scriptsDir '\lg_power_on.ps1')
}

;## Brightness Percent Control ##

; Set brightness to 0%
^!`::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"0\"} device1')
}

; Set brightness to 10%
^!1::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"10\"} device1')
}

; Set brightness to 20%
^!2::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"20\"} device1')
}

; Set brightness to 30%
^!3::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"30\"} device1')
}

; Set brightness to 40%
^!4::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"40\"} device1')
}

; Set brightness to 50%
^!5::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"50\"} device1')
}

; Set brightness to 60%
^!6::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"60\"} device1')
}

; Set brightness to 70%
^!7::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"70\"} device1')
}

; Set brightness to 80%
^!8::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"80\"} device1')
}

; Set brightness to 90%
^!9::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"90\"} device1')
}

; Set brightness to 100% (recommended default)
^!0::
{
Run (lgtvCompanion ' -settings_picture {\"backlight\":\"100\"} device1')
}

;## HDR Tone Mapping ###

; Enable HDR Dynamic tone mapping (if you REALLY want extra brightness and max
; brightness is already set via ctrl+alt+0)
^!=::
{
Run (lgtvCompanion ' -hdrdynamictonemapping on')
}

; Disable Dynamic tone mapping (typically off already)
^!-::
{
Run (lgtvCompanion ' -hdrdynamictonemapping off')
}

; Set HGIG Dynamic tone mapping (not able to see a difference between this and off)
^!h::
{
Run (lgtvCompanion ' -hdrdynamictonemapping hgig')
}
