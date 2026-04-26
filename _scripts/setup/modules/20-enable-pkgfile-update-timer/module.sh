#!/usr/bin/env bash
set -u

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    if ! (command -v pkgfile &> /dev/null); then
        # 'pkgfile' is necessary for this module
        return 1
    fi

    if (systemctl is-enabled pkgfile-update.timer &> /dev/null); then
        # Timer is already enabled, so this module can be skipped
        return 2
    fi

    return 0
}

function run() {
    echo "Executing pkgfile update for the first time..."
    sudo mkdir -p /var/cache/pkgfile
    sudo pkgfile --update

    echo "Enabling pkgfile-update.timer..."
    sudo systemctl enable --now pkgfile-update.timer

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
