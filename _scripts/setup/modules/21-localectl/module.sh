#!/usr/bin/env bash
set -u

KEYBOARD_LAYOUT="kr"
KEYBOARD_MODEL="pc104"
KEYBOARD_VARIANT="kr104"
KEYBOARD_OPTIONS="korean"

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    if ! (command -v localectl &> /dev/null); then
        return 1
    fi

    return 0
}

function run() {
    echo "Setting up X11 keyboard keymap: $KEYBOARD_MODEL $KEYBOARD_LAYOUT $KEYBOARD_VARIANT $KEYBOARD_OPTIONS"
    localectl set-x11-keymap "$KEYBOARD_LAYOUT" "$KEYBOARD_MODEL" "$KEYBOARD_VARIANT" "$KEYBOARD_OPTIONS"

    return 0
}

function check_after_run() {
    # Check if the keymap was set correctly
    localectl status | grep -qE "X11 Layout:\s+$KEYBOARD_LAYOUT" && \
    localectl status | grep -qE "X11 Model:\s+$KEYBOARD_MODEL" && \
    localectl status | grep -qE "X11 Variant:\s+$KEYBOARD_VARIANT" && \
    localectl status | grep -qE "X11 Options:\s+$KEYBOARD_OPTIONS"

    return $?
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
