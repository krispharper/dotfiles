#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export EDITOR=vim
[ -z "$TMUX" ] && export TERM=xterm-256color
export STEAM_FRAME_FORCE_CLOSE=1

. /home/kris/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh

WORKON_HOME=/home/kris/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

eval $(thefuck --alias)

venv() {
    local activate=~/.python/$1/bin/activate
    if [ -e "$activate" ] ; then
        source "$activate"
    else
        echo "Error: $activate not found"
    fi
}

venv27() { venv 27 ; }

bpython() {
    if test -n "$VIRTUAL_ENV"
    then
        PYTHONPATH="$(python -c 'import sys; print(":".join(sys.path))')" \
        command bpython "$@"
    else
        command bpython "$@"
    fi
}

alias vpn='vpn2'
alias ll='ls -la'
