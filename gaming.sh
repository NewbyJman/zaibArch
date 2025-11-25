sudo pacman -S steam wine-staging winetricks wine-mono zenity lib32-pipewire lib32-libpulse --needed --noconfirm
yay -S protonup-qt heroic-games-launcher-bin --noconfirm --removemake --noanswerclean --noanswerdiff --needed
git clone https://github.com/kozec/dumbxinputemu
cd dumbxinputemu
curl https://github.com/kozec/dumbxinputemu/releases/download/v0.3.3/dumbxinputemu-v0.3.3-dlls.tar.gz -L -o dll.tar.gz
tar -xvzf dll.zip
winetricks --force setup_dumbxinputemu.verb