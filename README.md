# lgtv-controls

These are the various scripts I've written to manage my Windows HTPC hardware. More specifically:

- Windows 11 HTPC (HDMI 1)
- LG C2
- Logitech K830 wireless keyboard
- Sonos Beam soundbar (ARC to TV, HDMI 2)
- Gaming console (HDMI 3)

Some of these configurations are particular to my setup and will probably (dare I say hopefully) not apply to you. I try to note such situations when relevant in this README.

### Overview

At a high level, we are utilizing an AutoHotKey configuration file, *media-server-hotkeys.ahk*, to manage our HTPC. The keyboard shortcuts utilize LG TV Companion commands and Powershell scripts (often containing LG TV Companion commands) to accomplish what is desired. These scripts are necessary to incorporate proper wait times between commands, conditionals based on TV state, and work around various quirks.

There is one primary Powershell file, *lg_tv_functions.ps1*, that provides all the functions the other scripts use which do the actual actions. As long as you have the proper applications installed (and close enough hardware), you should simply be able to update the variables at the top of this powershell file and *media-server-hotkeys.ahk* and everything should "work" from there.

### Keyboard Shortcut Overview

These are all configured in media-server-hotkeys.ahk, and can be changed however you'd like.

* **Power TV on/off via keyboard**: Instead of worrying about the monitor going to sleep we can make it super simple to power off and on while leaving the PC power always on or on scheduled power. These scripts also set the volume to a default value when powered on so things aren't unexpectedly loud from previous watching.
   * ctrl or esc: Power on TV. Won't do anything if already powered on. Kind of like waking up from sleep.
   * ctrl+Enter: Power toggle. Only way to turn OFF TV via keyboard. Also powers on.

* **Brightness slider:** ctrl+alt+ the number row on the keyboard for percentage:
    * ` : 0%
    * 1 : 10%
    * 2 : 20%
    * 3 : 30%
    * 4 : 40%
    * 5 : 50%
    * 6 : 60%
    * 7 : 70%
    * 8 : 80%
    * 9 : 90%
    * 0 : 100%

    i.e. ctrl+alt+3 will set the brightness to 30%.

* **HDR Tone mapping:** Depending on your picture settings and things like time of day, you may want to toggle Dynamic Tone Mapping. These also utilize the ctrl+alt keys and use the last two buttons on the top row with the numbers:
    * \- : Turn Dynamic Tone Mapping off
    * = : Turn Dynamic Tone Mapping on
    * h : Turn on HGIG (gaming mode only, no noticeable difference from off) 
    
* **Direct volume control:**
   * VOLUP, VOLDOWN, and MUTE : These keyboard keys are remapped to control LG TV volume directly. If using LG speakers or audio is setup through ARC this allows you to keep Windows volume at 100% and change sound levels of speakers directly via keyboard without needing a remote control.
   * ctrl+alt+a : Set default volume. Valuable if you have a TV setup that makes it difficult to see what the audio is currently set to and want to ensure it is set to a comfortable volume (like a Sonos soundbar hooked up via ARC). This one is a bit complex due to some buggy behavior I experienced. Here is exactly what it does, and why:
      1. When there is no audio activity for a while my Sonos soundbar becomes inactive. While inactive it does not have a volume, so we are not able to read what it is and know what to set it to. To work around this, we first "wake up" the soundbar by setting the Windows volume low (to ensure no loud noises if the speaker volume is currently set to something high), playing a default notification noise to "wake up" the speakers, then bring the Windows volume back up to 100.
      1. After that, we get the current volume. 
      1. I had issues setting volume to a specific number - it often messed up the readings I received. So instead, I compare the current volume to the target volume, then raise or lower the volume by however many steps are needed to get it there.

* **Direct HDMI input control:** These can be easily configured to your liking, and can even be LG TV channels.
  * ctrl+1: HDMI1 (PC)
  * ctrl+3: HDMI3 (console)

* **DSClock Toggle:** Mapped to ctrl+alt+d. Only relevant if you use or want to use dsclock. VERY optional.

### Dependencies
 
 These scripts utilize the following applications:

* [AutoHotKey](http://autohotkey.com/): Used to configure keyboard shortcuts to send commands.
* [LG TV Companion](https://github.com/JPersson77/LGTVCompanion): Used for sending commands to the LG TV. Note the install directory as you will need to ensure it matches our default variables.
* [run-hidden](https://github.com/stax76/run-hidden): This allows AHK to silently call Powershell scripts. Note the location of the exe as you will need to ensure it matches our default variables.
* [Sound Volume Command Line](https://www.nirsoft.net/utils/sound_volume_command_line.html) (svcl): Used specifically in the activateVolume Powershell function to manage the Windows volume for situations like mine where your audio device deactivates and you need to wake it up before it is able to send or receive volume levels by playing a noise. If you don't have that issue, you can probably ignore this and delete any references to the activateVolume function in your scripts. Note the location of the exe as you will need to ensure it matches our default variables. Keeping it won't hurt anything.
* [dsclock](https://ds-clock.en.softonic.com/?ex=RAMP-3252.2): I wish I could find a first party link, but I think the company is no longer around. This is a nice little clock widget that can be set to always show, even over content being played. This was something I wanted for my configuration, but if you don't want this it is by no means necessary.

### Installation

1. Ensure you have installed all the relevant dependencies. AHK and LG TV Companion, and I think run-hidden are essential for a good user experience. Sound Volume Command Line may not be required for you - see "Dependencies" section. dsclock is totally optional.
1. Clone down this git repo to the folder you'd like to run your LG TV control scripts from. Probably somewhere in your home folder?
1. Open up *lg_tv_functions.ps1*. Ensure all the variables are correctly set. If you have a different device than an LG C2 it is the name of the "Output Device" in Windows for it. The current default volume of 18 is quiet but noticeable when Windows is at 100% volume. 
1. Open up *media-server-hotkeys.ahk* and update the variables in the variables section. You'll need to update the "powershell" variable to point to your "run-hidden" exe file, the "scriptsDir" to where you cloned down this git repo, and "lgtvCompanion" to where your LGTV Companion binary files are.
1. Read through each of the keyboard shortcuts, what scripts they call, and what functions they reference, and ensure everything they are doing make sense. I tried to make everything as human-readable as possible. Make any modifications to the shortcuts you'd like, and delete any you don't want.
2. Once you feel good, double click on your media-server-hotkeys.ahk file and you should be good to go. 