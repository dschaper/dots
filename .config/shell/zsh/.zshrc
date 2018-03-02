# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
# With a little help from http://www.joshuad.net/zshrc-config and
# https://github.com/unixorn/zsh-quickstart-kit/blob/master/zsh/.zshrc

### Files and Directories
export TERM="xterm-256color"
eval $(dircolors "${ZDOTDIR}/dircolors/${DIR_COLORS}")

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Use neovim if it's installed
if (( $+commands[nvim] )); then
  export VISUAL=nvim
elif (( $+commands[vim] )); then
  export VISUAL=vim
elif (( $+commands[nano] )); then
  export VISUAL=nano
fi
  export EDITOR=$VISUAL

# Workaround for Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

### Source helpers
if [[ -n $ZDOTDIR ]]; then
  for configfile in $ZDOTDIR/*
  do
    # If the configfile is readable and basename of configfile starts with two digits
    if [[ -r "${configfile}"  &&  "${configfile:t}" =~ '[0-9][0-9]' ]]; then
      source "${configfile}"
    fi
  done
fi

# History
export HISTFILE=$ZSH_CACHE_DIR/history
export SAVEHIST=10000
export HISTSIZE=10000
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:yadm *"

### Finish up and load
dedupe_path
autoload -Uz compinit
# Load command line completions
compinit -d $ZSH_CACHE_DIR/zcompdump
