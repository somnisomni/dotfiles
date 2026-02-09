####### somni.dotfiles.linux #######
## ZSH + Oh My Zsh Configurations ##

### ** Oh My Zsh settings **
# ** Refer to the official documentation for more details: https://github.com/ohmyzsh/ohmyzsh/wiki
# Path to Oh My Zsh installation
ZSH=/usr/share/oh-my-zsh/

# Oh My Zsh theme
ZSH_THEME="agnoster"

# Case-insensitive completion
CASE_SENSITIVE="false"

# Set history timestamp format to ISO 8601
HIST_STAMPS="yyyy-mm-dd"

# Oh My Zsh plugins
plugins=(git command-not-found nvm)

# Oh My Zsh cache directory
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# Finally load Oh My Zsh
source $ZSH/oh-my-zsh.sh

### ** Personal customizations **
# Add local binary directories to the PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Set `nano` as default CLI editor
export EDITOR="nano"

# `ls` aliases
alias ls='ls --group-directories-first --color=auto'
alias ll='ls -laFh'
alias l='ls -ACF'
