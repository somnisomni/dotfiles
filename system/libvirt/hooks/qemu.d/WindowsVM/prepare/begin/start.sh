#!/bin/bash
set -x

HOME_USER="somni"
REALTEK_AUDIO_PCI="pci_0000_0d_00_4"
NVIDIA_GPU_PCI="pci_0000_0b_00_0"
NVIDIA_AUDIO_PCI="pci_0000_0b_00_1"
SSD_DEVICE_TO_PASSTHROUGH="/dev/nvme2n1"

# SSD unmount
sync
umount -l $SSD_DEVICE_TO_PASSTHROUGH*
swapoff $SSD_DEVICE_TO_PASSTHROUGH*

# display manager
systemctl stop display-manager

# VTconsole
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# efi framebuffer
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/unbind

# avoid race condition
sleep 3

# audio
systemctl --user -M $HOME_USER@ stop pipewire.socket \
                                     pipewire.service \
                                     pipewire-pulse.service \
                                     pipewire-pulse.socket \
                                     wireplumber.service
modprobe -r snd_usb_audio snd_hda_intel    # unload them first for safer batch unload
lsmod | grep snd | awk '{print $1}' | xargs modprobe -r -a --remove-holders

# avoid race condition
sleep 3

# nvidia
if pgrep -x "nvidia-smi" > /dev/null; then
	killall -v nvidia-smi
fi
modprobe -r -a --remove-holders nvidia_drm nvidia_modeset nvidia_uvm nvidia
modprobe -r -a --remove-holders nouveau

# avoid race condition
sleep 3

# detach audio
virsh nodedev-detach $REALTEK_AUDIO_PCI

# detach nvidia
virsh nodedev-detach $NVIDIA_AUDIO_PCI
virsh nodedev-detach $NVIDIA_GPU_PCI

# vfio
modprobe -a vfio vfio_iommu_type1 vfio_pci
