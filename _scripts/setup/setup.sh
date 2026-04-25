#!/usr/bin/env bash
set -u

# Predefined/precomputed constant values
BASEDIR="$(dirname "${BASH_SOURCE[0]}")"
MODULES_DIR="modules"

# Source library scripts
source $BASEDIR/../libs/common.sh
source $BASEDIR/_functions.sh

# Check if the OS is based on Arch Linux
if check_arch_linux_based_os; then
    echo "Detected Arch Linux-based OS"
else
    echo "[Error] This script is intended to be executed on Arch Linux-based OS."
    exit 1
fi

# Check if running as non-root user
if check_non_root_user; then
    echo "Detected running on non-root user"
else
    echo "[Error] This script is not intended to be executed with root privileges."
    echo "        If you really want to do, manually remove non-root user check condition in the script and execute again."
    exit 1
fi

# `dialog` is needed for this script
if ! command -v dialog &> /dev/null; then
    echo "[Error] 'dialog' should be installed to use this script."
    exit 1
fi

# Check for module folder
if [[ ! -d "$BASEDIR/$MODULES_DIR" ]]; then
    echo "[Error] Module directory ('$MODULES_DIR') not exists. Nothing to do."
    exit 1
fi

# Bogus sudo, to prevent password prompt interrupting the setup flow
sudo -v

#TODO
result=()
build_dialog_module_items result
dialog --clear --title "Test" --no-tags --checklist "Select:" 20 80 10 "${result[@]}" --stdout
