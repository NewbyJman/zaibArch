sudo reflector --protocol https --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
echo "Building yay"
sudo pacman -S "go" --noconfirm --needed
cd ~/
git clone https://aur.archlinux.org/yay.git
cd ~/yay
makepkg -si --noconfirm
cd ~/

PKGS=(
    "sddm qt5-quickcontrols2 qt5-graphicaleffects"

    # XFCE components
    "xfwm4 xfce4-session xfce4-settings xfce4-screensaver xfdesktop thunar-volman thunar-archive-plugin tumbler thunar-media-tags-plugin gvfs"
    "xfce4-terminal"
    "xfce4-xfconf"
    "xfce4-panel"
    "xfce4-power-manager xfce4-notifyd xfce4-pulseaudio-plugin xfce4-whiskermenu-plugin"    

    # Desktop utilities
    "lxtask"
    "xarchiver"
    "noto-fonts"
    
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
    "albert"
)

for PKG in "${YPKGS[@]}"; do
    yay -S $PKG --noconfirm --removemake --noanswerclean --noanswerdiff --needed
done

sudo systemctl enable sddm bluetooth.service NetworkManager.service ntpd
sudo ntpd -u ntp:ntp
sudo ntpd -qg
sudo hwclock --systohc
sudo systemctl --user --now disable pulseaudio.service pulseaudio.socket
sudo systemctl --user mask pulseaudio
sudo systemctl --user --now enable pipewire pipewire-pulse pipewire-media-session

//sh driverInstall.sh

echo "Set nvidia as default GPU"
yay -S envycontrol --noconfirm --removemake --noanswerclean --noanswerdiff
sudo envycontrol -s nvidia --dm sddm

sudo systemctl start sddm
