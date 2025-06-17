
# Used to keep a clock always on screen in the bottom left corner, even when media is playing.
# Can't find first party source, but this is the app: https://ds-clock.en.softonic.com/?ex=RAMP-3252.2

$ProcessActive = Get-Process dsclock -Module -ErrorAction SilentlyContinue
if ($ProcessActive -eq $null) {
    Start-Process  -FilePath "C:\Program Files\DS Clock\dsclock.exe"  
} else {
    Stop-Process -name "dsclock"
}