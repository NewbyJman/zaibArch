# Nvidia GeForce MX250
echo "Installing nvidia drivers"
yay -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings --noconfirm --removemake --noanswerclean --noanswerdiff
sudo sh -c "sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"quiet splash nvidia-drm.modeset=1 nvidia-drm.fbdev=1\"/' /etc/default/grub"
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo sh -c 'sed -i "s/^MODULES=().*/MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" /etc/mkinitcpio.conf'
sudo sh -c 'sed -i "s/ *\<kms\> *//" /etc/mkinitcpio.conf'
mkinitcpio -P
sudo mkdir -p /etc/pacman.d/hooks
sudo bash -c  "cat <<EOT >> /etc/pacman.d/hooks/nvidia.hook 
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia-dkms
Target=linux-lts
# Change the linux part above and in the Exec line if a different kernel is used

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux-lts) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOT"

# Intel i3 third generation
echo "Installing ancient intel drivers"
sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver --noconfirm --needed
