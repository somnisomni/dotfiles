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

    # Otherwise it's not good to go, well, maybe
    return 0
}

function run() {
    echo "Do a full system upgrade using '$PACKAGE_MANAGER'..."
    if [[ $PACKAGE_MANAGER = "pacman" ]]; then
        yes | sudo $PACKAGE_MANAGER -Syyu --noconfirm
    else
        yes | $PACKAGE_MANAGER -Syyu --noconfirm
    fi

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