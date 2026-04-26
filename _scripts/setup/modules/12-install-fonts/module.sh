#!/usr/bin/env bash
set -u

FONTS_SANS_SERIF=(
    # All languages
    "noto-fonts-cjk"
    "otf-ibm-plex"

    # Latin
    "otf-pretendard-std"
    "otf-montserrat"
    "ttf-lato"
    "ttf-nunito"

    # Hangul
    "otf-pretendard"
    "ttf-nanum-meta"
    "otf-nanum-meta"
    "otf-kopub"

    # Kana / Kanji
    "otf-pretendard-jp"
)

FONTS_SERIF=(
    # Kana / Kanji
    "ttf-jigmo"
)

FONTS_MONOSPACE=(
    # Korean
    "ttf-d2coding"
    "ttf-d2coding-nerd"
)

FONTS_SYMBOLS=(
    # Nerd Fonts
    "ttf-nerd-fonts-symbols"

    # Emoji
    "noto-fonts-emoji"
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
    echo "Installing sans-serif fonts..."
    yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
          "${FONTS_SANS_SERIF[@]}"

    echo "Installing serif fonts..."
    yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
          "${FONTS_SERIF[@]}"

    echo "Installing monospace fonts..."
    yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
          "${FONTS_MONOSPACE[@]}"

    echo "Installing symbol fonts..."
    yes | yay -S --needed --answerdiff None --noconfirm --sudoloop --removemake \
          "${FONTS_SYMBOLS[@]}"

    echo "Rebuilding font caches..."
    fc-cache -fv

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
