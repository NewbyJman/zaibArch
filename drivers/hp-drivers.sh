# Bluetooth adapter doesn't work out of the box
echo "Configuring ancient rt3290 bluetooth adapter"
yay -S rtbth-dkms-git --noconfirm --removemake --noanswerclean --noanswerdiff
sudo sh -c 'sudo echo rtbth >> /etc/modules-load.d/rtbth.conf'

# Nvidia GT 630M
echo "Installing ancient nvidia drivers"
yay -S nvidia-390xx-dkms nvidia-390xx-utils lib32-nvidia-390xx-utils --noconfirm --removemake --noanswerclean --noanswerdiff
sudo pacman -S libglvnd opencl-nvidia lib32-libglvnd lib32-opencl-nvidia nvidia-settings --noconfirm --needed
sudo sh -c 'sed -i "s/^MODULES=().*/MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" /etc/mkinitcpio.conf'
mkinitcpio -P
sudo sh -c "sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"nvidia_drm.modeset=1 rd.driver.blacklist=nouveau modprob.blacklist=nouveau\"/' /etc/default/grub"
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkdir /etc/pacman.d/hooks
sudo bash -c  "cat <<EOT >> /etc/pacman.d/hooks/nvidia.hook 
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia-390xx-dkms
Target=linux-lts
# Change the linux part above and in the Exec line if a different kernel is used

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOT"

# Intel i3 third generation
echo "Installing ancient intel drivers"
sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel --noconfirm --needed