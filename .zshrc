# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
# With a little help from www.joshuad.net/zshrc-config

export TERM="xterm-256color"

# Workaround for Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# Use neovim if it's installed
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
fi

### Files and Directories
local ZSH_CONF="${XDG_CONFIG_HOME:=$HOME/.config}/zsh"				# Define the place to store config files
local ZSH_CACHE="${XDG_CACHE_HOME:=$HOME/.cache}/zsh"				# Cache for storing history and zcompdump
local ZSH_PLUGS="${XDG_DATA_HOME:=$HOME/.local/share}/zsh"        # Location for plugins and files

# zgen lightweight package manager
plug=zgen
author=rslindee
export ZGEN_DIR=$ZSH_PLUGS/$plug
if [[ ! -d $ZGEN_DIR ]]; then
  mkdir $ZGEN_DIR
  wget -qO - https://api.github.com/repos/$author/$plug/tarball | \
    tar -C $ZGEN_DIR -xz --strip-components=1
fi
source $ZGEN_DIR/$plug.zsh

if ! zgen saved; then
  echo "Creating a zgen save"

  # ZSH port of the FISH shell's history search
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen load zsh-users/zsh-completions

  zgen save
fi

### Source helpers
  source $ZSH_CONF/functs.zsh
  source $ZSH_CONF/termsupport
  source $ZSH_CONF/aliases
  source $ZSH_CONF/bindkeys

# History
export HISTFILE=$ZSH_CACHE/history
export SAVEHIST=10000
export HISTSIZE=10000

# Powerlevel9k theme
source $ZSH_CONF/powerlevel9k-config
plug=powerlevel9k
author=bhilburn
if [[ ! -d $ZSH_PLUGS/$plug ]]; then
  mkdir $ZSH_PLUGS/$plug
  wget -qO - https://api.github.com/repos/$author/$plug/tarball | \
    tar -C $ZSH_PLUGS/$plug -xz --strip-components=1
fi
source $ZSH_PLUGS/$plug/*.zsh-theme

### Finish up and load
autoload -Uz compinit
# Load command line completions
compinit

# Autocompletion of command line switches
setopt COMPLETE_ALIASES
