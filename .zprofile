# Editors
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

# Ensure path arrays do not contain duplicate
typeset -Ug cdpath fpath mailpath path
path=(
  ~/bin
  /usr/local/{bin,sbin}
  ~/.cargo/bin
  $path
)

# Less
export LESS='-F -g -i -M -R -S -s -X -z-4'

# Try lesspipe and lesspipe.sh
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
