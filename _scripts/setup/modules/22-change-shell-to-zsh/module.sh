#!/usr/bin/env bash
set -u

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    # Nothing to check
    return 0
}

function run() {
    echo "Updating user's shell to zsh..."
    sudo chsh -s "$(which zsh)" $USER

    echo "Linking zsh configuration files to the root user's home directory..."
    sudo ln -sf $HOME/.zshrc /root/.zshrc
    sudo ln -sf $HOME/.p10k.zsh /root/.p10k.zsh

    echo "Adding current user to the 'wheel' group..."
    sudo usermod -aG wheel $USER

    return 0
}

function check_after_run() {
    # Check if the current user's shell is set to zsh
    CURRENT_SHELL=$(getent passwd $USER | cut -d: -f7)

    if [[ "$CURRENT_SHELL" != "$(which zsh)" ]]; then
        return 1
    fi

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
