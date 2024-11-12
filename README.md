HOW TO INSTALL

-Arch install medium
    1- create a bootable flash (google arch iso, download from website and flash it)
    2- select drive from bios
    3- launch arch install medium

-Connect to internet
    check station using:
        `iwctl`
        `device list`

    assuming station is wlan0, connect in one line like so:
        `iwctl --passphrase <password> station wlan0 connect <SSID>`
    or the boring method:
        `iwctl`
        `station wlan0 scan`
        `station wlan0 get-networks`
        `station wlan0 connect <SSID>`

-Git clone
    1- pacman -Sy git
    2- git clone https://github.com/NewbyJman/zaibArch.git

-CLI download
    1- run main.sh (sh <path to>/main.sh)
    2- follow prompts
    3- system will auto-shutdown once completed
    4- remove usb and boot system
    5- login and connect to internet using nmtui
    6- git clone for Desktop environment if needed

-Desktop environment
    1- run desktop.sh (sh <path to>/desktop.sh)
    2- select environment from the prompts
    3- (Not a feature yet) select driver config
    4- system will auto-reboot

-Preferences
    There's a few preferences to apply if needed (for kde, xfce, openbox)
    1- run preferenceConf.sh
    2- follow the prompts
    3- reboot system if you want, restart dm or just log out and log back in

Custom folder (and prompt option) is for me to rice, learn and test
