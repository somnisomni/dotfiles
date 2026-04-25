#!/usr/bin/env bash
set -u

function check_before_run() {
    if (! command -v yay &> /dev/null) \
       || (! pacman -Q yay &> /dev/null); then
        # If 'yay' command cannot be found OR have not installed by pacman, good to go
        return 0
    else
        # If 'yay' seems like correctly installed on the system, skip this module
        return 2
    fi

    # If something's wrong, fail the check
    return 1
}

function run() {
    echo "Installing essential packages and clone the repository..."
    yes | sudo pacman -S --needed git base-devel
    git clone --depth 1 --single-branch https://aur.archlinux.org/yay-bin.git $HOME/.cache/yay-bin

    echo "Building and installing 'yay-bin' package..."
    pushd $HOME/.cache/yay-bin
    makepkg -si

    echo "Cleaning up 'yay-bin' repository..."
    popd
    rm -rf yay-bin

    echo "Checking for 'yay' command..."
    if (! command -v yay &> /dev/null); then
        return 1
    fi

    echo "Configuring yay..."
    yay -S --save --removemake --devel --editmenu --editor nano

    echo "Making sure 'yay-bin' package have marked as installed on the system..."
    yes | yay -S yay-bin

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

check_before_run
EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
    run
    EXIT_CODE=$?

    check_after_run
    EXIT_CODE=$?
fi

exit $EXIT_CODE
