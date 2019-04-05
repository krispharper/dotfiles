plugins=(docker pylint tmux)
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

setopt interactivecomments

# Conda completions
fpath+=/home/kris/Development/conda-zsh-completion
compinit conda

# Prevent Ctrl-S from freezing vim
stty -ixon

unset MAILCHECK
export ZSH_TMUX_AUTOSTART=true
export EDITOR=vim

bindkey '^R' history-incremental-search-backward
bindkey '^[[Z' reverse-menu-complete

# Add Powerline
. ~/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

# Add conda
. /opt/conda/etc/profile.d/conda.sh

bpython() {
    if test -n "$CONDA_DEFAULT_ENV"
    then
        if [ ! -f "$CONDA_PREFIX/bin/bpython" ];
        then
            pip install bpython
        fi
        command "$CONDA_PREFIX/bin/bpython" "$@"
    else
        command bpython "$@"
    fi
}

eval $(thefuck --alias)

# Tiny Care Terminal settings
export TTC_REPOS=/home/kris/Development
export TTC_WEATHER=10022
export TTC_CELSIUS=false
export TTC_CONSUMER_KEY=No7isIDRwowm0rWrNzGBQeVsZ
export TTC_CONSUMER_SECRET=LCQjkUp1UNmGRwkR3mA2Ers7YVVigNAc5oGW57gWoFodzz3O6r
export TTC_ACCESS_TOKEN=804131787999940608-E9rsURg6mVeeFfUwU0q4Jd0joQvzTcv
export TTC_ACCESS_TOKEN_SECRET=rsYcEtTQYxdu6QAge0Fym9bQ5BXvEXXDmHQqWUuAdlKmj

# Remote convenience functions

# Set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$PATH:/home/kris/Development/fzf/bin
export FZF_DEFAULT_COMMAND='ag --ignore node_modules --ignore .tox -g ""'

# Aliases
alias ll='ls -la'
alias tig='tig --all'
alias dc="docker system prune -af --volumes"
