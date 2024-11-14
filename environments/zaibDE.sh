PKGS=(
    "sddm qt5-quickcontrols2 qt5-graphicaleffects"

    # XFCE components
    "xfwm4 xfce4-session xfce4-settings xfce4-screensaver xfdesktop thunar-volman thunar-archive-plugin catfish tumbler thunar-media-tags-plugin gvfs"
    "xfce4-terminal"
    "xfce4-xfconf"
    "xfce4-panel"
    "xfce4-power-manager xfce4-notifyd xfce4-pulseaudio-plugin xfce4-whiskermenu-plugin"    

    # Desktop utilities
    "lxtask"
    "xarchiver"
    
    # Pipewire audio
    "pipewire pipewire-alsa pipewire-media-session pipewire-pulse"

    # Panel plugins
    "network-manager-applet"
    "blueman"
    "pavucontrol"

    # Extras
    "flameshot"
    "parcellite"
    "vlc"
    "chromium"
    "viewnior"
    "gimp"
    "mousepad"
    "cheese"
    "qbittorrent"
)

for PKG in "${PKGS[@]}"; do
    sudo pacman -S $PKG --noconfirm --needed
done

YPKGS=(
    "mugshot"
    "xfce4-docklike-plugin"
    "7-zip"
)

for PKG in "${YPKGS[@]}"; do
    yay -S $PKG --noconfirm --noremovemake --noanswerclean --noanswerdiff
done
