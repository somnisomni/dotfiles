#!/usr/bin/env bash
set -u

# Packages that are not need extra system-wide configuration should be added here
PACKAGES=(
    # CLI text editor
    "nano"

    # Network tools
    "wget"
    "curl"
    "aria2"
    "openssh"

    # Cryptography tools
    "gnupg"

    # Filesystem tools
    "parted"
    "dosfstools"
    "exfatprogs"
    "ntfsplus-dkms-git"
    "ntfsprogs-plus"
    "f2fs-tools"
    "bcachefs-dkms"
    "bcachefs-tools"
    "btrfs-progs"
    "lvm2"

    # Hardware tools
    "smartmontools"
    "lm_sensors"
    "nvme-cli"

    # Extra system tools
    "sbctl"
    "fastfetch"

    # Compression tools
    "gzip"
    "zstd"
    "zip"
    "unzip"
    "xz"
    "tar"
    "7zip"

    # ZSH shell
    "zsh"
    "oh-my-zsh-git"
    "zsh-theme-powerlevel10k-bin-git"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"

    # EasyEffects + plugins
    "easyeffects"
    "calf-no-gui"
    "lsp-plugins-lv2"
    "lsp-plugins-vst3"
)

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    if ! (command -v yay &> /dev/null); then
        # 'yay' is necessary for this module
        return 1
    fi

    return 0
}

function run() {
    echo "Installing core packages..."
    yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
          "${PACKAGES[@]}"

    return 0
}

function check_after_run() {
    # Nothing to check, just pass 0
    return 0
}

##### MODULE PROCEDURE EXECUTION #####
check_before_run
EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
    run
    EXIT_CODE=$?

    check_after_run
    EXIT_CODE=$?
fi

exit $EXIT_CODE
