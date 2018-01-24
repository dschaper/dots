# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
# With a little help from http://www.joshuad.net/zshrc-config and
# https://github.com/unixorn/zsh-quickstart-kit/blob/master/zsh/.zshrc

source ~/.zprofile

### Files and Directories
export ZSH_CONF="${XDG_CONFIG_HOME:=$HOME/.config}/zsh"				# Define the place to store config files
export ZSH_CACHE="${XDG_CACHE_HOME:=$HOME/.cache}/zsh"				# Cache for storing history and zcompdump
export ZSH_PLUGS="${XDG_DATA_HOME:=$HOME/.local/share}/zsh"        # Location for plugins and files

export TERM="xterm-256color"

# Use neovim if it's installed
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
fi


# Workaround for Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

### Source helpers
if [[ -n $ZSH_CONF ]]; then
  for configfile in $ZSH_CONF/*
  do
    # If the configfile is readable and basename of configfile starts with two digits
    if [[ -r "${configfile}"  &&  "${configfile:t}" =~ '[0-9][0-9]' ]]; then
      source "${configfile}"
    fi
  done
fi

# History
export HISTFILE=$ZSH_CACHE/history
export SAVEHIST=10000
export HISTSIZE=10000
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:yadm *"

### Finish up and load
dedupe_path
autoload -Uz compinit
# Load command line completions
compinit
