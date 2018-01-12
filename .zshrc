# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
# With a little help from www.joshuad.net/zshrc-config
# Files and Directories
local ZSH_CONF=$HOME/.zsh				# Define the place to store everything
local ZSH_CACHE=$ZSH_CONF/cache				# Cache for storing history and zcompdump
local LOCAL_ZSHRC=$HOME/.zshlocal/.zshrc		# Local machine overrides

export TERM="xterm-256color"

# Source helpers
  source $ZSH_CONF/functs.zsh
  source $ZSH_CONF/termsupport.zsh
  source $ZSH_CONF/spectrum.zsh
  source $ZSH_CONF/aliases.zsh

# Powerlevel9k theme
  source $ZSH_CONF/powerlevel9k-config.zsh
  source $ZSH_CONF/powerlevel9k/powerlevel9k.zsh-theme

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
bindkey "[[R" history-incremental-pattern-search-backward

# History
HISTFILE=$ZSH_CACHE/history
SAVEHIST=10000
HISTSIZE=10000

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search
