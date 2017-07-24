# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '/home/kris/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt appendhistory beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# Completion options for cd -
setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
setopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')
autoload -U compinit && compinit   # load + start completion
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'

unset MAILCHECK
export EDITOR=vim
alias ll='ls -la'

# Add Powerline
. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# Add virtualenv
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

venv() {
    mkvirtualenv --python=$(which python3) $1
}

bpython() {
    if test -n "$VIRTUAL_ENV"
    then
        if [ ! -f "$VIRTUAL_ENV/bin/bpython" ];
        then
            pip install bpython
        fi
        command "$VIRTUAL_ENV/bin/bpython" "$@"
    else
        command bpython "$@"
    fi
}


# Tiny Care Terminal settings
export TTC_REPOS=/home/kris/Development
export TTC_WEATHER=10022
export TTC_CELSIUS=false
export TTC_CONSUMER_KEY=No7isIDRwowm0rWrNzGBQeVsZ
export TTC_CONSUMER_SECRET=LCQjkUp1UNmGRwkR3mA2Ers7YVVigNAc5oGW57gWoFodzz3O6r
export TTC_ACCESS_TOKEN=804131787999940608-E9rsURg6mVeeFfUwU0q4Jd0joQvzTcv
export TTC_ACCESS_TOKEN_SECRET=rsYcEtTQYxdu6QAge0Fym9bQ5BXvEXXDmHQqWUuAdlKmj

# Remote convenience functions
alias vpn='vpn2'
