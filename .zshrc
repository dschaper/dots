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

## START zgen lightweight package manager
plug=zgen
author=rslindee
export ZGEN_DIR=$ZSH_PLUGS/$plug
export ZGEN_INIT=$ZSH_CONF/$plug
if [[ ! -d $ZGEN_DIR ]]; then
  mkdir $ZGEN_DIR
  wget -qO - https://api.github.com/repos/$author/$plug/tarball | \
    tar -C $ZGEN_DIR -xz --strip-components=1
fi
source $ZGEN_DIR/$plug.zsh


if ! zgen saved; then
  echo "Creating a zgen save"

  zgen load zdharma/fast-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions
  zgen load djui/alias-tips
  zgen load peterhurford/git-it-on.zsh
  zgen load unixorn/autoupdate-zgen
  zgen load petervanderdoes/git-flow-completion

  zgen save
fi
export ZSH_PLUGINS_ALIAS_TIPS_TEXT=" "
## END zgen

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

# Powerlevel9k theme
plug=powerlevel9k
author=bhilburn
if [[ ! -d $ZSH_PLUGS/$plug ]]; then
  mkdir $ZSH_PLUGS/$plug
  wget -qO - https://api.github.com/repos/$author/$plug/tarball | \
    tar -C $ZSH_PLUGS/$plug -xz --strip-components=1
fi
source $ZSH_PLUGS/$plug/*.zsh-theme

### Finish up and load
dedupe_path
autoload -Uz compinit
# Load command line completions
compinit
