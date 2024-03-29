export EDITOR="nvim"
export BROWSER="firefox"
export ZPLUG_HOME=$HOME/.zplug

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias ls='ls --color'
alias l='ls -la --si'

# zplug initialization
[[ ! -f $ZPLUG_HOME/init.zsh ]] && git clone https://github.com/zplug/zplug $ZPLUG_HOME
source $ZPLUG_HOME/init.zsh

# self-manage and install plugins / theme
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "lib/completion",   from:oh-my-zsh
zplug 'zdharma-continuum/fast-syntax-highlighting', defer:2, hook-load:'FAST_HIGHLIGHT=()'
zplug 'zsh-users/zsh-autosuggestions', from:github
zplug 'hlissner/zsh-autopair', defer:2

# install and load plugins
zplug check || zplug install
zplug load

# Spaceship prompt vars
SPACESHIP_AWS_SHOW=false
SPACESHIP_TIME_SHOW=true
SPACESHIP_VI_MODE_SHOW=false
#SPACESHIP_CHAR_SYMBOL="λ "
#SPACESHIP_CHAR_COLOR_SUCCESS="blue"

TERM="xterm-256color"

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.scripts:$HOME/.gem/ruby/2.7.0/bin:$HOME/go/bin:$PATH

## Aliases
[[ -f $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases

## Automagic tmux session/reconnection with SSH
#if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
#    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
#fi

# Automagic rehash for newly installed programs to show in completion
zstyle ':completion:*' rehash true

if [[ -f ~/.zsh_private ]]; then
    source ~/.zsh_private
fi
