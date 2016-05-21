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

. /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

venv() {
    local activate=~/.python/$1/bin/activate
    if [ -e "$activate" ] ; then
        source "$activate"
    else
        echo "Error: $activate not found"
    fi
}

venv27() { venv 27 ; }


