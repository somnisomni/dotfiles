#!/usr/bin/env bash
set -u

PACKAGE_MANAGER=pacman

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    if (command -v yay &> /dev/null); then
        # If 'yay' is available, use it
        PACKAGE_MANAGER=yay
        return 0
    fi

    if (command -v $PACKAGE_MANAGER &> /dev/null); then
        # If pacman or yay is available, good to go
        return 0
    fi

    if ($PACKAGE_MANAGER -Q --quiet kmscon &> /dev/null); then
        # If 'kmscon' is already installed, skip this module
        return 2
    fi

    # Otherwise it's not good to go, well, maybe
    return 1
}

function run() {
    echo "Installing KMSCON..."
    if [[ $PACKAGE_MANAGER = "pacman" ]]; then
        yes | sudo $PACKAGE_MANAGER -S --needed --noconfirm kmscon
    else
        yes | $PACKAGE_MANAGER -S --needed --noconfirm kmscon
    fi

    echo "Enabling KMSCON for all TTYs except TTY1 and TTY6..."
    sudo systemctl disable getty@
    sudo systemctl enable kmsconvt@
    sudo systemctl disable kmsconvt@tty1
    sudo systemctl disable kmsconvt@tty6
    sudo systemctl enable getty@tty1
    sudo systemctl enable getty@tty6

    return 0
}

function check_after_run() {
    # Check for 'kmscon' package is installed
    if ($PACKAGE_MANAGER -Q --quiet kmscon &> /dev/null); then
        return 0
    fi

    return 1
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
