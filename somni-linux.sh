#!/usr/bin/env bash
set -eu

####### somni.dotfiles.linux #######
## Linux system  first-time setup ##

SYSTEM_CONFIG_ROOT=./system

function msg() {
  echo -e "$1"
}

### ** Check if the OS is based on Arch Linux **
if (grep -iE "^ID=[\"\']?arch[\"\']?$|^ID_LIKE=[\"\']?arch[\"\']?$" /etc/os-release >/dev/null 2>&1); then
  msg "[*] Checked: Arch Linux based system detected."
else
  msg "[!] This setup script is intended for Arch Linux based systems only. Exiting."
  exit 1
fi

### ** Check if running as non-root user **
if [[ $EUID -ne 0 ]]; then
  msg "[*] Checked: Running as non-root user."
else
  msg "[!] Do not run this script as root. Please run again as a regular user with sudo privileges."
  exit 1
fi

### ** All checks passed, proceed with the setup **

### ** Let's pollute the system ;) **
TARGET_VARIANT="Customized by somni"
if (grep -iE "^VARIANT=" /etc/os-release >/dev/null 2>&1); then
  if ! (grep -iE "^VARIANT=.*${TARGET_VARIANT}.*" /etc/os-release >/dev/null 2>&1); then
    sudo sed -i -E 's|^(VARIANT=)\"?([^\"]*)\"?$|\1\"\2 ('"${TARGET_VARIANT}"')\"|' /etc/os-release
  fi
else
  echo "VARIANT=\"$TARGET_VARIANT\"" | sudo tee -a /etc/os-release > /dev/null
fi

### ** Install & setup yay **
msg "\n[*] Install yay if not already installed..."
if ! command -v yay > /dev/null 2>&1; then
  msg "  └ yay not found. Installing yay..."

  # Install essential packages and clone the repository
  yes | sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay-bin.git

  # Build and install
  cd yay-bin
  makepkg -si

  # Cleanup
  cd ..
  rm -rf yay-bin

  if command -v yay > /dev/null 2>&1; then
    msg "  └ yay installed successfully."
  else
    msg "  └ Failed to install yay. Can't continue."
    exit 1
  fi
else
  msg "  └ yay is already installed."
fi

msg "\n[*] Setting up yay..."
yay -S --save --removemake --devel --editmenu --editor nano
yes | yay -S yay-bin

### ** Initial package database refresh and system upgrade **
msg "\n[*] Performing full package database refresh and system upgrade..."
yay -Syyu --noconfirm

### ** Install core packages **
msg "\n[*] Installing core packages..."
yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
      git git-lfs gnupg \
      nano wget curl aria2 \
      zsh oh-my-zsh-git zsh-theme-powerlevel10k-bin-git zsh-autosuggestions zsh-syntax-highlighting \
      parted smartmontools dosfstools exfatprogs ntfsplus-dkms-git ntfsprogs-plus f2fs-tools bcachefs-tools btrfs-progs lvm2 \
      sbctl zram-generator openssh \
      gzip zstd zip unzip xz tar 7zip \
      lm_sensors nvme-cli fastfetch \
      kmscon

### ** Install fonts **
msg "\n[*] Installing fonts..."
yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
      otf-ibm-plex noto-fonts-cjk noto-fonts-emoji \
      otf-pretendard otf-pretendard-jp otf-pretendard-std \
      ttf-nanum-meta otf-nanum-meta otf-kopub \
      ttf-d2coding ttf-d2coding-nerd ttf-nerd-fonts-symbols \
      ttf-koruri

### ** Install development packages **
msg "\n[*] Installing development packages..."
yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
      github-cli \
      dotnet-sdk \
      nodejs-lts corepack \
      python python-pip python-numpy python-yaml

### ** Install EasyEffects and dependencies **
msg "\n[*] Installing EasyEffects and dependencies..."
yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
      easyeffects \
      calf-no-gui lsp-plugins-lv2 lsp-plugins-vst3

### ** Cleanup package cache **
msg "\n[*] Cleaning up package cache..."
yay -Sc --noconfirm

### ** Update pkgfile database **
msg "\n[*] Updating pkgfile database..."
sudo mkdir -p /var/cache/pkgfile
sudo pkgfile --update

msg "\n[*] Enabling automatic pkgfile database updates..."
sudo systemctl enable --now pkgfile-update.timer

### ** ZRAM setup **
msg "\n[*] Copying zram-generator configuration..."
sudo cp $SYSTEM_CONFIG_ROOT/zram/zram-generator.conf /etc/systemd/zram-generator.conf

msg "\n[*] Starting ZRAM service..."
sudo systemctl daemon-reload
sudo systemctl start systemd-zram-setup@zram0

### ** KMSCON setup **
msg "\n[*] Copying KMSCON configuration..."
sudo cp $SYSTEM_CONFIG_ROOT/kmscon/kmscon.conf /etc/kmscon/kmscon.conf

msg "\n[*] Enabling KMSCON for all TTYs except TTY1/TTY6..."
sudo systemctl enable kmsconvt@
sudo systemctl disable kmsconvt@tty1
sudo systemctl disable kmsconvt@tty6
sudo systemctl enable getty@tty1
sudo systemctl enable getty@tty6

### ** Setup tmpfs for '/tmp' **
msg "\n[*] Setting up tmpfs for '/tmp'..."
if (sudo mount -av --fake | grep "^/tmp") > /dev/null 2>&1; then
  msg "  └ '/tmp' mountpoint is already present, skipping setup."
else
  msg "  └ '/tmp' mountpoint is not set up. Setting up tmpfs..."
  sudo rm -rf /tmp/*
  msg "\n# tmpfs for /tmp\ntmpfs /tmp tmpfs defaults,rw,noatime,mode=1777 0 0" | sudo tee -a /etc/fstab

  if $? -eq 0; then
    msg "  └ Successfully added fstab entry for /tmp."
  else
    msg "  └ Failed to add fstab entry for /tmp."
    exit 1
  fi
fi

### ** Reload fstab and mount all tmpfs entries **
msg "\n[*] Reloading fstab and mounting all tmpfs entries..."
sudo systemctl daemon-reload
sudo mount -av > /dev/null 2>&1

### ** Symlink user zsh configurations to root home **
msg "\n[*] Symlinking user zsh configurations to root home..."
sudo ln -sf $HOME/.zshrc /root/.zshrc
sudo ln -sf $HOME/.zprofile /root/.zprofile
sudo ln -sf $HOME/.p10k.zsh /root/.p10k.zsh

### ** Adjust current user's group memberships
msg "\n[*] Adjusting current user's group memberships..."
sudo usermod -aG wheel $USER

### ** Setup complete **
msg "\n[*] Linux system first-time setup is complete! Reboot is recommended."
