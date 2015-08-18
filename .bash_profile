#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:~/.config/bspwm/panel
export PANEL_FIFO="/tmp/panel-fifo"

# OPAM configuration
. /home/kris/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
