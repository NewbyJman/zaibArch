sudo pacman -S qemu-full libvirt virt-manager virt-viewer edk2-ovmf dnsmasq iptables-nft bridge-utils swtpm dmidecode
sudo systemctl enable --now libvirtd.service
sudo systemctl status libvirtd.service
sudo usermod -aG libvirt,kvm zaib

## WINDOWS 10
# Download windows Virtio drivers ISO: https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers
# Memory -> Enable Shared Memory
# Add Hardware -> Filesystem -> Driver: virtiofs + set source path + name the Target path
# CD ROm -> Virtio ISO
# download winfsp on windows
# video QXL -> Virtio
# Add Hardware -> Channel -> org.qemu.guest_agent.0
