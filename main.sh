echo "Enter host name"
read hostName
echo "Enter username"
read userName
echo "Enter password"
read userPassword
echo "Enter Timezone (eg: Asia/Dubai)"
read timeZone
echo "Create swap file? (y/n)"
read swapBool
if [ $swapBool == "y" ]; then
    echo "Enter swap size (GiB):"
    read swapSize
fi

(
    # Delete existing paritions
    echo d
    echo
    echo d
    echo 
    echo d
    echo 
    echo g      # create new parition table
    # EFI partition
    echo n      # Add new parition
    echo 1      # Parition number
    echo        # First sector (default)
    echo "+500M"  # Last sector
    echo t
    echo 1      # Partition number
    echo 1      # Set to EFI

    # Root parition
    echo n      # Add new parition
    echo 2      # Parition number
    echo        # First sector (default)
    echo        # Last sector
    echo t
    echo 2      # Partition number
    echo 44     # Set to LVM

    #Write changes
    echo p
    echo w
) | fdisk -W always /dev/sda    # Overwrite any signatures

fdisk -l

# Formatting Partitions
mkfs.fat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2

# Mounting Partitions
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

# Download base linux (lts)
pacstrap -K /mnt base base-devel linux-lts linux-lts-headers linux-firmware neovim git --noconfirm --needed
genfstab -U /mnt >> /mnt/etc/fstab  # Generate fstab

cat <<EOF > /mnt/postMount.sh
echo "Setting system clock"
timedatectl set-timezone $timeZone
ln -sf usr/share/zoneinfo/$timeZone /etc/localtime
hwclock --systohc

echo "Generating locales"
sed -i "s/^#en_GB.UTF-8 UTF-8.*/en_GB.UTF-8 UTF-8/" /etc/locale.gen
sed -i "s/^#en_GB ISO-8859-1.*/en_GB ISO-8859-1/" /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf

echo "Setting host"
echo $hostName >> /etc/hostname
echo "127.0.0.1     localhost" >> /etc/hosts
echo "::1     localhost" >> /etc/hosts
echo "127.0.1.1     ${hostName}.localdomain     localhost" >> /etc/hosts
mkinitcpio -P
echo "Adding network, bluetooth, ssh, and grub"
pacman -Syu networkmanager grub efibootmgr bluez bluez-plugins bluez-utils openssh dkms reflector --noconfirm --needed
systemctl enable NetworkManager
systemctl enable sshd
systemctl enable bluetooth
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo "Enabling multilib"
sed -i "s/^#VerbosePkgLists.*/VerbosePkgLists/" /etc/pacman.conf
sed -i "s/^#ParallelDownloads = .*/ParallelDownloads = 5/" /etc/pacman.conf
sed -i "/^ParallelDownloads = 5.*/a ILoveCandy" /etc/pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Syu
sed -i "s/^PS1=.*/PS1='\\\\n\\\\[\\\\e[97;48;5;54m\\\\] \\\\u@\\\\[\\\\e[3m\\\\]\\\\h\\\\[\\\\e[23m\\\\] \\\\[\\\\e[48;5;129m\\\\]٭\\\\[\\\\e[48;5;54m\\\\] \\\\w \\\\n\\\\[\\\\e[0;38;5;129m\\\\]\\\\$ \\\\[\\\\e[0m\\\\]'/" /etc/skel/.bashrc

if [ $swapBool == "y" ]; then
    echo "Creating swap file"
    mkswap -U clear --size ${swapSize}G --file /swapfile
    swapon /swapfile
    sed -i -e '$a\'$'\n''# swapfile' /etc/fstab
    sed -i -e '$a\'$'\n''/swapfile none swap defaults 0 0' /etc/fstab
    sed -i -e 's/filesystems fsck/filesystems resume fsck/' /etc/mkinitcpio.conf
fi

echo "Creating user: ${userName}"
echo "root:123" | chpasswd
useradd -m $userName
echo "${userName}:${userPassword}" | chpasswd
echo '${userName} ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
sed -i "s/^PS1=.*/PS1='\\\\n\\\\[\\\\e[38;5;54m\\\\]╭─\\\\[\\\\e[97;48;5;54m\\\\] \\\\u\\\\[\\\\e[22m\\\\] 🟑 \\\\[\\\\e[3m\\\\]\\\\h\\\\[\\\\e[23;1m\\\\] \\\\[\\\\e[0;38;5;54;48;5;92m\\\\]\\\\[\\\\e[97m\\\\] \\\\[\\\\e[2m\\\\]\\\\@\\\\[\\\\e[22m\\\\] \\\\[\\\\e[38;5;92;48;5;129m\\\\]\\\\[\\\\e[97m\\\\] \\\\w\\\\[\\\\e[0;38;5;129m\\\\]\\\\[\\\\e[0m\\\\]\\\\n\\\\[\\\\e[38;5;54m\\\\]╰➤ \\\\[\\\\e[38;5;129;1m\\\\]\\\\$ \\\\[\\\\e[0m\\\\]'/" /home/${userName}/.bashrc
EOF

arch-chroot /mnt sh postMount.sh
umount -R /mnt
shutdown now
