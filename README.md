# lgtv-controls

These are the various scripts I've written to manage my Windows HTPC experience. More specifically:

- Windows 11
- LG C2
- Logitech K830 wireless keyboard
- Sonos Beam soundbar

Some of these configurations are particular to my setup and will probably (dare I say hoepfully) not apply to you. I try to note such situations when relevant in this README.

### Overview

At a high level, we are utilizing an AutoHotKey configuration file to manage our HTPC. The keyboard shortcuts utilize LG TV Companion commands and powershell scripts (often containing LG TV Companion commands) to accomplish what is desired.

### Keyboard Shortcut Overview

These are all configured in media-server-hotkeys.ahk, and can be changed however you'd like.

* Brightness slider: ctrl+alt+ the number row on the keyboard for percentage:
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

* HDR Tone mapping: Depending on your picture settings and things like time of day, you may want to toggle Dynamic Tone Mapping. These also utilize the ctrl+alt keys and use the last two buttons on the top row with the numbers:
    * \- : Turn Dynamic Tone Mapping off
    * = : Turn Dynamic Tone Mapping on
    * h : Turn on HGIG (gaming mode only, no noticeable difference from off) 
    
* Direct volume control:
  * Volume up, down, and mute keyboard keys remapped to control LG volume directly. If using LG speakers or audio is setup through ARC this allows you to keep Windows volume at 100% and change sound levels of speakers directly without needing a remote control.

### Dependencies
 
 These scripts utilize the following applications:

* [AutoHotKey](http://autohotkey.com/): Used to configure keyboard shortcuts to send commands.
* [LG TV Companion](https://github.com/JPersson77/LGTVCompanion): Used for sending commands to the LG TV. Note the install directory as you will need to ensure it matches our default variables.
* [run-hidden](https://github.com/stax76/run-hidden): This allows AHK to silently call Powershell scripts. Note the location of the exe as you will need to ensure it matches our default variables.
* [Sound Volume Command line](https://www.nirsoft.net/utils/sound_volume_command_line.html) (svcl): Used specifically in the activateVolume Powershell function to manage the Windows volume for situations like mine where your audio device deactivates and you need to wake it up before it is able to send or receive volume levels by playing a noise. If you don't have that issue, you can probably ignore this and delete any references to the activateVolume function in your scripts. Note the location of the exe as you will need to ensure it matches our default variables. Keeping it won't hurt anything.
* [dsclock](https://ds-clock.en.softonic.com/?ex=RAMP-3252.2): I wish I could find a first party link, but I think the company is no longer around. This is a nice little clock widget that can be set to always show, even over content being played. This was something I wanted for my configuration, but if you don't want this it is by no means necessary.