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
  source $ZSH_CONF/bindkeys.zsh

# Source plugins

# ZSH port of the FISH shell's history search
plug=zsh-history-substring-search
if [[ ! -d $ZSH_PLUGS/$plug ]]; then
  mkdir $ZSH_PLUGS/$plug
  wget -qO - https://api.github.com/repos/zsh-users/$plug/tarball | \
    tar -C $ZSH_PLUGS/$plug -xz --wildcards --no-anchored "*.zsh" --strip-components=1 
fi
source $ZSH_PLUGS/$plug/*.plugin.zsh


# Powerlevel9k theme
  source $ZSH_CONF/powerlevel9k-config.zsh
  if [[ ! -d $ZSH_PLUGS/powerlevel9k ]]; then
    wget -qO - https://api.github.com/repos/bhilburn/powerlevel9k/tarball | \
      tar -xz --wildcards --no-anchored '*theme' --strip-components=1 -C $ZSH_PLUGS/powerlevel9k
  fi
  source $ZSH_PLUGS/powerlevel9k/powerlevel9k.zsh-theme

autoload -Uz compinit promptinit
# Load command line completions
compinit
# Initialize prompt
promptinit

# Autocompletion with arrow-key driven interface
zstyle ':completion:*' menu select

# Autocompletion of command line switches
setopt COMPLETE_ALIASES

# History
HISTFILE=$ZSH_CACHE/history
SAVEHIST=10000
HISTSIZE=10000