somni.dotfiles.linux
====================
This repository contains my personal dotfiles and configuration files for Linux systems.

This dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for bootstrapping.

Desired System Setup
--------------------
- **OS**: Any Arch-based distro (*mainly [CachyOS](https://cachyos.org)*)
- **Package Manager**: [yay](https://github.com/jguer/yay) as pacman/AUR helper
- **Shell**: [zsh](https://www.zsh.org) with [Oh My Zsh](https://ohmyz.sh) and [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **Window Manager**: [Niri](https://github.com/niri-wm/niri) with [Noctalia Shell](https://noctalia.dev)
- **Terminal**: [Kitty](https://sw.kovidgoyal.net/kitty/)
- **File Manager**: [Dolphin](https://apps.kde.org/dolphin/)
- **Web Browser**: [Vivaldi](https://vivaldi.com/)

Configuration Bootstrap
-----------------------
Make sure to have clone this repository with Dotbot submodule:

```sh
git clone --recurse-submodules
```

To bootstrap the dotfiles after clone, run the following command in the root of the repository:

```sh
./install
```

This will execute Dotbot for user and system configurations.  
For user-specific configuration, see [install.yaml](install.yaml).
For system-wide configuration, see [install-sudo.yaml](install-sudo.yaml).

Modular System Setup Scripts
----------------------------
While executing `install` script, a prompt will ask whether to execute system setup script or not.  
The script provides some options(*'modules'*) for setting up the system, reducing repetitive manual work after installing a new system.

It can be executed manually at [`./_scripts/setup/setup.sh`](_scripts/setup/setup.sh).

`dialog` package is needed to make the script work, so install it before execute the script.
