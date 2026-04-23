#!/usr/bin/env bash
set -u

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    # Return value should be a one of [0, 1, 2]
    #   - 0: Successfully checked and should be proceed to run()
    #   - 1: Check failed or something's wrong during check
    #   - 2: Successfully checked and further procedures can be skipped
    return 0
}

function run() {
    # Only 0 indicates success. Otherwise the procedure has failed or something's wrong.
    return 0
}

function check_after_run() {
    # Unlike check_before_run(), only 0 indicates success. Otherwise the check has failed or something's wrong.
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