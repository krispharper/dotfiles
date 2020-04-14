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

# Conda completions
fpath+=~/Development/conda-zsh-completion
compinit conda

# Prevent Ctrl-S from freezing vim
stty -ixon

unset MAILCHECK
export ZSH_TMUX_AUTOSTART=true
export EDITOR=vim

bindkey '^R' history-incremental-search-backward
bindkey '^[[Z' reverse-menu-complete

setopt interactivecomments

# Add local settings
source ~/.zshrc.local

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

# Set up fzf
export PATH=$PATH:/usr/local/bin/fzf
export FZF_DEFAULT_COMMAND='ag --ignore node_modules -g ""'

# Aliases
alias ll='ls -la'
alias tig='tig --all'
alias dc="docker system prune -af --volumes"

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
