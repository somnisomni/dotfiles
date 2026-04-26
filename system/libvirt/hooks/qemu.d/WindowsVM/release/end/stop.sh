#!/bin/bash
set -x

HOME_USER="somni"
REALTEK_AUDIO_PCI="pci_0000_0d_00_4"
NVIDIA_GPU_PCI="pci_0000_0b_00_0"
NVIDIA_AUDIO_PCI="pci_0000_0b_00_1"

# unload vfio
modprobe -r -a vfio vfio_pci vfio_iommu_type1
sleep 3

# attach nvidia
virsh nodedev-reattach $NVIDIA_GPU_PCI
virsh nodedev-reattach $NVIDIA_AUDIO_PCI

# attach audio
virsh nodedev-reattach $REALTEK_AUDIO_PCI

# nvidia
modprobe -a nvidia nvidia_modeset nvidia_uvm nvidia_drm

# audio
modprobe -a snd_hda_intel snd_usb_audio snd_hrtimer snd_seq
systemctl --user -M $HOME_USER@ start pipewire.socket \
                                      pipewire.service \
                                      pipewire-pulse.service \
                                      pipewire-pulse.socket \
                                      wireplumber.service
sleep 3

# VTconsole
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# efi framebuffer
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

# remount all
sync
mount -a
swapon -a

# display manager
systemctl start display-manager
