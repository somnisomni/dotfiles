#!/usr/bin/env bash
set -u

TARGET_VARIANT="Customized by somni"

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    if ! (grep -iE "^VARIANT=" /etc/os-release >/dev/null 2>&1); then
        # If VARIANT property is not found, good to go
        return 0
    else
        if ! (grep -iE "^VARIANT=.*${TARGET_VARIANT}.*" /etc/os-release >/dev/null 2>&1); then
            # If VARIANT property is found but target variant value is not set, good to go
            return 0
        else
            # Otherwise it seems like it's already applied, so can skip this module
            return 2
        fi
    fi

    # If something's wrong?? then fail the check
    return 1
}

function run() {
    if (grep -iE "^VARIANT=" /etc/os-release >/dev/null 2>&1); then
        if ! (grep -iE "^VARIANT=.*${TARGET_VARIANT}.*" /etc/os-release >/dev/null 2>&1); then
            echo "Update existing VARIANT value by appending target value..."
            sudo sed -i -E 's|^(VARIANT=)\"?([^\"]*)\"?$|\1\"\2 ('"${TARGET_VARIANT}"')\"|' /etc/os-release
        fi
    else
        echo "Add VARIANT property with target value..."
        echo "VARIANT=\"$TARGET_VARIANT\"" | sudo tee -a /etc/os-release > /dev/null
    fi

    return 0
}

function check_after_run() {
    # Do 'check_before_run' again, this time it should be return 2 (skipped) if applied successfully
    check_before_run

    if [[ $? -eq 2 ]]; then
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