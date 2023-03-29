#!/bin/sh
#######################################
# somni.dotfiles: Oh My Zsh installer #
#######################################

### This script will install Oh My Zsh, a zsh configuration management framework.

### Oh My Zsh repository: https://github.com/ohmyzsh/ohmyzsh
### "Getting Started" documentation: https://github.com/ohmyzsh/ohmyzsh#getting-started


# Include common script
source "$(dirname "$(realpath $0)")/../_common.sh"

# Check for package prerequisties
echo
echo "Checking for zsh, curl, git..."
test_command_exit zsh
test_command_exit curl
test_command_exit git

# Install Oh My Zsh as described in documentation
echo
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
