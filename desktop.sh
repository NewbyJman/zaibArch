echo "Select desktop type:"
echo "1. Custom"
echo "2. Not Custom"
read dType

if [ $dType == 2 ]; then
    echo "Select environment:"
    echo "1. Plasma full"
    echo "2. Plasma base"
    echo "3. XFCE full"
    echo "4. Cinammon"
    echo "5. Openbox"
    read dE
    if [ $de == 4 ]; then
        dM="lightdm"
    elif [ $de == 5 ]; then
        dM="lxdm"
    else
        dM="sddm"
    fi
fi

sudo reflector --protocol https --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
echo "Building yay"
sudo pacman -S "go" --noconfirm --needed
cd ~/
git clone https://aur.archlinux.org/yay.git
cd ~/yay
makepkg -si --noconfirm
cd ~/

if [ $dType == 1 ]; then
    sh ~/zaibArch/environments/zaibDE.sh
    dM="sddm"
elif [ $dType == 2 ]; then
    sh ~/zaibArch/environments.sh $dM $dE
fi

sudo systemctl enable $dM bluetooth.service NetworkManager.service ntpd
sudo ntpd -u ntp:ntp
sudo ntpd -qg
sudo hwclock --systohc
sudo systemctl --user --now disable pulseaudio.service pulseaudio.socket
sudo systemctl --user mask pulseaudio
sudo systemctl --user --now enable pipewire pipewire-pulse pipewire-media-session

sh driverInstall.sh

if [ $dM != "lxdm" ]; then
    echo "Set nvidia as default GPU"
    yay -S envycontrol --noconfirm --removemake --noanswerclean --noanswerdiff
    sudo envycontrol -s nvidia --dm $dM
fi

sudo systemctl start $dm
