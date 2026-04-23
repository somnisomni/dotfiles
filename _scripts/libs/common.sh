#!/usr/bin/env bash
set -u

function check_arch_linux_based_os() {
    if (grep -iE "^ID=[\"\']?arch[\"\']?$|^ID_LIKE=[\"\']?arch[\"\']?$" /etc/os-release > /dev/null 2>&1); then
        return 0
    else
        return 1
    fi
}

function check_non_root_user() {
    [[ $EUID -ne 0 ]]
    return $?
}