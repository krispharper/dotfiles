plugins=(docker pylint tmux fzf)
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '~/.zshrc'

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

# Completions
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

# Prevent Ctrl-S from freezing vim
stty -ixon

# Set defaults
unset MAILCHECK
export ZSH_TMUX_AUTOSTART=true
export EDITOR=vim

bindkey '^R' history-incremental-search-backward
bindkey '^[[Z' reverse-menu-complete

setopt interactivecomments

# Add local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Add conda
. /opt/conda/etc/profile.d/conda.sh

recon() {
    CONDA_ENVIRONMENT=${1-$CONDA_DEFAULT_ENV}
    echo "Recreating conda environment $CONDA_ENVIRONMENT"
    conda deactivate && conda env remove -n $CONDA_ENVIRONMENT -y && conda env create -f environment.yml && conda env update -f environment-dev.yml && conda activate $CONDA_ENVIRONMENT
}

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

# Aliases
alias ll='ls -la'
alias tig='tig --all'
alias dc="docker system prune -af --volumes"
alias k="kubectl"

# Add git functions
function gc() {
    base="master"

    if [[ $(git branch --format="%(refname:short)" | grep dev) ]]; then
        base="dev"
    fi

    echo "Base branch is $base"

    # Go through each branch
    for b in $(git branch --format="%(refname:short)" | grep -vE "(master|uat|dev)"); do
        # git cherry prefixes each commit with "-" if it's included, and "+" if it isn't, so check if there are no "+" lines

        if [[ ! $(git cherry "upstream/$base" $b | grep "^+") ]]; then
            git branch -D $b && git push --delete github $b
        else
            echo "Not deleting $b because it hasn't been rebased into $base"
        fi
    done

    echo "Pruning remotes"
    git remote prune upstream github
}

function gcu() {
    if $(git diff-index --quiet HEAD); then
        git up
        gc
    else
        echo "Not updating because of uncommitted changes."
    fi
}

# Setup nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Add Promptline
vim_ins_mode="INSERT"
vim_cmd_mode="NORMAL"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  __promptline
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

source ~/.promptline.sh

# Set up fzf
export PATH=$PATH:/usr/local/bin/fzf
export FZF_DEFAULT_COMMAND='ag --ignore node_modules -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
