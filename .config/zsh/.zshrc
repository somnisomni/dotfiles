####### somni.dotfiles.linux #######
## ZSH + Oh My Zsh Configurations ##

### ** Powerlevel10k instant prompt **
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### ** Personal customizations **
# Add local binary directories to the PATH
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Set `nano` as default CLI editor
export EDITOR="nano"

# `ls` aliases
alias ls='ls --group-directories-first --color=auto'
alias ll='ls -laFh'
alias l='ls -ACF'

### ** Oh My Zsh settings **
# ** Refer to the official documentation for more details: https://github.com/ohmyzsh/ohmyzsh/wiki
# Path to Oh My Zsh installation
ZSH=/usr/share/oh-my-zsh/

# Disable Oh My Zsh specific theme before loading Powerlevel10k
ZSH_THEME=""

# Case-insensitive completion
CASE_SENSITIVE="false"

# Set history timestamp format to ISO 8601
HIST_STAMPS="yyyy-mm-dd"

# Oh My Zsh built-in plugins
plugins=(git command-not-found nvm)

# Load zsh-autosuggestions plugin if available
#   Assuming it's installed via `zsh-autosuggestions` AUR package on Arch Linux, via Homebrew `zsh-autosuggestions` package on macOS
if [[ -r "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [[ -r "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Load zsh-syntax-highlighting plugin if available
#   Assuming it's installed via `zsh-syntax-highlighting` AUR package on Arch Linux, via Homebrew `zsh-syntax-highlighting` package on macOS
if [[ -r "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [[ -r "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Oh My Zsh cache directory
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# Finally load Oh My Zsh
source $ZSH/oh-my-zsh.sh

### ** Powerlevel10k **
#   Assuming it's installed via `zsh-theme-powerlevel10k-bin-git` AUR package on Arch Linux, via Homebrew `powerlevel10k` package on macOS
POWERLEVEL10K_INSTALLED=false
if [[ -r "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"
  POWERLEVEL10K_INSTALLED=true
elif [[ -r "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"
  POWERLEVEL10K_INSTALLED=true
fi

# Load Powerlevel10k configuration
if [[ -f ~/.p10k.zsh ]] && [[ $POWERLEVEL10K_INSTALLED == true ]]; then
  source ~/.p10k.zsh
fi
