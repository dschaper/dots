# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
# With a little help from www.joshuad.net/zshrc-config
# Files and Directories
local ZSH_CONF=$XDG_CONFIG_HOME/zsh				# Define the place to store config files
local ZSH_CACHE=$XDG_CACHE_HOME/zsh				# Cache for storing history and zcompdump
local ZSH_PLUGS=$XDG_DATA_HOME/zsh        # Location for plugins and files

export TERM="xterm-256color"

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
fi

# Source helpers
  source $ZSH_CONF/functs.zsh
  source $ZSH_CONF/termsupport.zsh
  source $ZSH_CONF/spectrum.zsh
  source $ZSH_CONF/aliases
  source $ZSH_CONF/bindkeys

# Source plugins

# ZSH port of the FISH shell's history search
install_plugin zsh-history-substring-search zsh-users $ZSH_PLUGS omz

# Powerlevel9k theme
source $ZSH_CONF/powerlevel9k-config.zsh
plug=powerlevel9k
author=bhilburn
if [[ ! -d $ZSH_PLUGS/$plug ]]; then
  mkdir $ZSH_PLUGS/$plug
  wget -qO - https://api.github.com/repos/$bhilburn/$plug/tarball | \
    tar -C $ZSH_PLUGS/$plug -xz --strip-components=1
fi
source $ZSH_PLUGS/$plug/*.zsh-theme

autoload -Uz compinit
# Load command line completions
compinit

# Autocompletion with arrow-key driven interface
zstyle ':completion:*' menu select

# Autocompletion of command line switches
setopt COMPLETE_ALIASES

# History
HISTFILE=$ZSH_CACHE/history
SAVEHIST=10000
HISTSIZE=10000