export EDITOR="nvim"
export BROWSER="firefox"
export ZPLUG_HOME=$HOME/.zplug
export GDK_SCALE=2

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias ls='ls --color'
alias l='ls -la --si'

# zplug initialization
[[ ! -f $ZPLUG_HOME/init.zsh ]] && git clone https://github.com/zplug/zplug $ZPLUG_HOME
source $ZPLUG_HOME/init.zsh

# do self-manage
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Themes
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# load nice libs from oh-my-zsh
zplug "lib/completion",   from:oh-my-zsh
#zplug "lib/history",      from:oh-my-zsh
#zplug "lib/key-bindings", from:oh-my-zsh
#zplug "lib/termsupport", from:oh-my-zsh

#zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3 # Syntax highlighting for commands, load last
# another eyecandy

zplug 'zdharma/fast-syntax-highlighting', defer:2, hook-load:'FAST_HIGHLIGHT=()'
zplug 'zsh-users/zsh-autosuggestions', from:github
# Time the shell startup

#zplug "paulmelnikow/zsh-startup-timer"

# auto-close quotes and brackets like a pro
zplug 'hlissner/zsh-autopair', defer:2

# finally install and load those plugins
zplug check || zplug install
zplug load

# Spaceship prompt vars
SPACESHIP_AWS_SHOW=true
SPACESHIP_VI_MODE_SHOW=false
#SPACESHIP_CHAR_SYMBOL="λ "
#SPACESHIP_CHAR_COLOR_SUCCESS="blue"

TERM="xterm-256color"

# FIXME: If you come from bash you might have to change your $PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.scripts:$HOME/.gem/ruby/2.6.0/bin:$PATH

# probably always going to want this
export AWS_PROFILE=saml

## Aliases
[[ -f $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases

## Automagic tmux session/reconnection with SSH
#if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
#    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
#fi

# Automagic rehash for newly installed programs to show in completion
zstyle ':completion:*' rehash true

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
#(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
