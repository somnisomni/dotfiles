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

# Show module selection dialog
dialog_module_items=()
build_dialog_module_items dialog_module_items
dialog_module_selected_tmp="$(mktemp)"
trap 'rm -f "$dialog_module_selected_tmp"' EXIT

show_dialog --no-tags \
            --title "First-Time Setup — Select Modules" \
            --checklist "Current user: $(whoami)\n\nSelect modules to execute:" 25 100 15 "${dialog_module_items[@]}" \
            2> "$dialog_module_selected_tmp"
dialog_exit=$?

if [[ $dialog_exit -ne 0 ]]; then
    echo "[!] Cancelled."
    exit 0
fi

dialog_module_selected=()
mapfile -d " " -t dialog_module_selected < "$dialog_module_selected_tmp"
if [[ ${#dialog_module_selected[@]} -eq 0 ]]; then
    echo "[!] No module selected. Nothing to do."
    exit 0
fi

# Execute selected modules
progress_current=0
progress_total=${#dialog_module_selected[@]}

for module_id in "${dialog_module_selected[@]}"; do
    progress_current=$((progress_current + 1))
    progress_percent=$((progress_current * 100 / progress_total))

    ((execute_module_by_id "$module_id" 2>&1 | tee -a output.log); ping -c 2 localhost > /dev/null) | \
    show_dialog --no-cancel \
                --no-kill \
                --title "First-Time Setup — Executing '$module_id' ($progress_percent%)" \
                --progressbox 20 100
done

# Done
show_dialog --title "First-Time Setup — Completed" \
            --extra-button --extra-label "Open Log File" \
            --msgbox "All done! Please check the 'output.log' file for details of module execution.\n\nReboot is strongly recommended." 8 100
if [[ $? -eq 3 ]]; then
    OPEN="xdg-open"
    command -v $OPEN &> /dev/null || OPEN="$PAGER"
    command -v $OPEN &> /dev/null || OPEN="less"

    $OPEN "output.log"
fi
