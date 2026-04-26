#!/usr/bin/env bash
set -u

PACKAGES=(
    # Niri
    "niri-git"
    "xwayland-satellite"

    # Shell
    "noctalia-qs"
    "noctalia-shell"

    # Themeing
    "adw-gtk-theme"
    "nwg-look"
    "qt6ct-kde"
    "hicolor-icon-theme"
    "papirus-icon-theme-git"
    "phinger-cursors"

    # Input method
    "fcitx5"
    "fcitx5-qt"
    "fcitx5-gtk"
    "fcitx5-configtool"
    "fcitx5-hangul"
    "fcitx5-mozc"

    # Desktop portals
    "xdg-desktop-portal"
    "xdg-desktop-portal-kde"
    "xdg-desktop-portal-wlr"
    "kwallet"
    "kwallet-pam"
    "kwalletmanager"

    # Screen recording
    "gpu-screen-recorder"

    # File manager / Archiver / Thumbnailers
    "dolphin"
    "ark"
    "ffmpegthumbnailer"
    "ffmpegthumbs"
    "icoutils"
    "kdegraphics-thumbnailers"
    "libappimage"
    "kimageformats"
    "qt6-imageformats"

    # Clipboard manager
    "cliphist"

    # Media player
    "vlc"
    "amarok"
    "nomacs"

    # Media control
    "playerctl"
    "pavucontrol"

    # Web browser
    "vivaldi"
    "vivaldi-ffmpeg-codecs"

    # Terminal emulator
    "kitty"
)

##### MODULE PROCEDURE DEFINITIONS #####
function check_before_run() {
    if ! (command -v yay &> /dev/null); then
        # 'yay' is necessary for this module
        return 1
    fi

    return 0
}

function run() {
    echo "Installing Niri and fundamental packages..."
    yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
          "${PACKAGES[@]}"

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
