#!/bin/zsh
# /home/user/.zshenv: user .zshenv file for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# XDG defaults
if (( $+commands[xdg-user-dirs-update] )); then
  xdg-user-dirs-update
  xdg-user-dirs-update --set CONFIG $HOME/.config
  source $(xdg-user-dir CONFIG)/user-dirs.dirs
fi

: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_CACHE_HOME:=$HOME/.cache}
: ${XDG_DATA_HOME:=$HOME/.local/share}
: ${XDG_RUNTIME_HOME:=$HOME/.tmp}
typeset -xm 'XDG_*'

# zsh
: ${ZDOTDIR:=$XDG_CONFIG_HOME/shell/zsh}
: ${ZSH_CACHE_DIR:=$XDG_CACHE_HOME/zsh}
typeset -x 'ZDOTDIR'
typeset -x 'ZSH_CACHE_DIR'

# zplug
: ${ZPLUG_CACHE_DIR:=${XDG_CACHE_HOME}/zplug}
: ${ZPLUG_HOME:=${XDG_DATA_HOME}/zplug}
: ${ZPLUG_LOADFILE:=${ZDOTDIR}/zplugrc}
typeset -xm 'ZPLUG_*'

# dircolors
: ${DIR_COLORS:=gruvbox.256dark}
typeset -x 'DIR_COLORS'
