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
    "xfwm4 xfce4-session xfce4-settings xfce4-screensaver"
    "xfce4-terminal tmux"
    "xfce4-xfconf"
    "xfce4-panel"
    "xfce4-power-manager xfce4-notifyd xfce4-pulseaudio-plugin xfce4-whiskermenu-plugin"    

    # Desktop utilities
    "nemo nemo-preview nemo-fileroller gvfs gvfs-mtp ntfsfix ffmpegthumbnailer"
    "xarchiver"
    "lxtask"
    "noto-fonts noto-fonts-emoji ttf-nerd-fonts-symbols-mono"
    "adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts adobe-source-han-sans-cn-fonts"
    "ttf-scheherazade-new"
    "xsel"
    
    # Pipewire audio
    "pipewire pipewire-alsa wireplumber pipewire-pulse sof-firmware"

    # Panel plugins
    "network-manager-applet"
    "blueman"
    "pavucontrol"

    # Extras
    "parcellite"
    "chromium"
    "cups"
    "scrcpy"
    "viewnior feh flameshot vlc vlc-plugins-all"
    "bat fastfetch"
    "gimp kdenlive"
    "libreoffice-fresh"
    "mousepad qalculate-gtk"
    "cheese"
    "qbittorrent"
)

for PKG in "${PKGS[@]}"; do
    sudo pacman -S $PKG --noconfirm --needed
done

YPKGS=(
    "mugshot"
    "xfce4-docklike-plugin"
    "localsend"
    "7-zip"
    "albert"
    "waterfox-bin"
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
sudo systemctl --user --now enable pipewire pipewire-pulse pipeware-alsa
sudo systemctl enable cups
//go to localhost:631 to setup printers

//sh driverInstall.sh

echo "Set nvidia as default GPU"
yay -S envycontrol --noconfirm --removemake --noanswerclean --noanswerdiff
sudo envycontrol -s nvidia --dm sddm
