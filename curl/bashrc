# Colorize directory listing
alias ls="ls -ph --color=auto"

# Colorize grep
if echo hello|grep --color=auto l >/dev/null 2>&1; then
    export GREP_OPTIONS="--color=auto" GREP_COLOR="1;31"
fi

# Shell
export CLICOLOR="1"
export PS1="\[\033[40m\]\[\033[34m\][ \[\033[33m\]\u@\H:\[\033[32m\]\w\[\033[34m\] ]$\[\033[0m\] "
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=1;40:bd=34;40:cd=34;40:su=0;40:sg=0;40:tw=0;40:ow=0;40:"

# enable bash completion in interactive shells
if ! shopt -oq posix; then
 if [ -f /usr/share/bash-completion/bash_completion ]; then
   . /usr/share/bash-completion/bash_completion
 elif [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
 fi
fi
