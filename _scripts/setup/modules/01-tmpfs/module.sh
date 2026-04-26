#!/usr/bin/env bash
set -u

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    if ! (command -v mount &> /dev/null); then
        return 1
    fi

    if (mount -av --fake | grep -qE "^/tmp\s"); then
        # /tmp is already configured in fstab, so this module should be skipped
        return 2
    fi

    return 0
}

function run() {
    echo "Removing the content of /tmp..."
    sudo rm -rf /tmp/*
    sudo mkdir -p /tmp

    echo "Inserting /tmp entry into /etc/fstab..."
    echo -e "\n# somni.dotfiles: /tmp on tmpfs\ntmpfs /tmp tmpfs defaults,noatime,nodev,nosuid,mode=1777 0 0" | sudo tee -a /etc/fstab

    echo "Reloading fstab and mount /tmp..."
    sudo systemctl daemon-reload
    sudo mount /tmp &> /dev/null

    return $?
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
