#!/usr/bin/env bash
set -u

# Packages that are not need extra system-wide configuration should be added here
PACKAGES=(
    # libvirt
    "libvirt"
    "virt-manager"

    # QEMU
    "qemu-base"
    "qemu-desktop"

    # Fundamentals
    "virglrenderer"
    "virtiofsd"
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
    echo "Installing VM management packages..."
    yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
          "${PACKAGES[@]}"

    echo "Adding user to 'libvirt' group..."
    sudo usermod -aG libvirt "$USER"

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
