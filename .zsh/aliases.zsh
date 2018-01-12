   alias vi="vim"

   alias -g ...='../..'
   alias -g ....='../../..'
   alias -g .....='../../../..'
   alias -g ......='../../../../..'
   alias -g .......='../../../../../..'
   alias -g ........='../../../../../../..'
   
   alias ls="ls -h --color='auto'"
   alias lsa='ls -A'
   alias ll='ls -l'
   alias la='ls -lA'
   alias lx='ls -lXB'    #Sort by extension
   alias lt='ls -ltr'
   alias lk='ls -lSr'
   alias cdl=changeDirectory; function changeDirectory { cd $1 ; la }

   alias md='mkdir -p'
   alias rd='rmdir'

   # Search running processes. Usage: psg <process_name>
   alias psg="ps aux $( [[ -n "$(uname -a | grep CYGWIN )" ]] && echo '-W') | grep -i $1"

   # Copy with a progress bar
   alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --" 

   alias d='dirs -v | head -10'                      # List the last ten directories we've been to this session, no duplicates

   alias google='web_search google'                  # Note: websearch function is loaded in function file, see above
   alias ddg='web_search ddg'
   alias github='web_search github'
   alias wiki='web_search ddg \!w'
   alias news='web_search ddg \!n'
   alias youtube='web_search ddg \!yt'
   alias map='web_search ddg \!m'
   alias image='web_search ddg \!i'
