# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
# With a little help from www.joshuad.net/zshrc-config
# Files and Directories
local ZSH_CONF=$XDG_CONFIG_HOME/zsh				# Define the place to store everything
local ZSH_CACHE=$XDG_CACHE_HOME/zsh				# Cache for storing history and zcompdump

export TERM="xterm-256color"

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
fi

# Source helpers
  source $ZSH_CONF/functs.zsh
  source $ZSH_CONF/termsupport.zsh
  source $ZSH_CONF/spectrum.zsh
  source $ZSH_CONF/aliases.zsh

# Powerlevel9k theme
  source $ZSH_CONF/powerlevel9k-config.zsh
  if [[ ! -d $XDG_DATA_HOME/powerlevel9k ]]; then
    wget -qO - https://api.github.com/repos/bhilburn/powerlevel9k/tarball | \
      tar -xz --wildcards --no-anchored '*theme' --strip-components=1
  fi
  source $XDG_DATA_HOME/powerlevel9k/powerlevel9k.zsh-theme

autoload -Uz compinit promptinit
# Load command line completions
compinit
# Initialize prompt
promptinit

# Autocompletion with arrow-key driven interface
zstyle ':completion:*' menu select

# Autocompletion of command line switches
setopt COMPLETE_ALIASES

# Force vi mode
bindkey -e
# Overrides for vi mode
bindkey "" history-incremental-pattern-search-backward #[CTRL-R]

# History
HISTFILE=$ZSH_CACHE/history
SAVEHIST=10000
HISTSIZE=10000

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "<Up>"   ]] && bindkey -- "<Up>"   up-line-or-beginning-search
[[ -n "<Down>" ]] && bindkey -- "<Down>" down-line-or-beginning-search
