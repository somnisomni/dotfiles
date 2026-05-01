somni.dotfiles.linux
====================
This repository contains my personal dotfiles and configuration files for Linux systems.  
*(especially for Arch Linux or Arch-based distributions)*

This dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for bootstrapping.

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

It can be manually executed at [`./_scripts/setup/setup.sh`](_scripts/setup/setup.sh).

`dialog` package is needed to make the script work, so install it before execute the script.
