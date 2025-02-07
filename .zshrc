export EDITOR="nvim"
export BROWSER="firefox"
export ZDOTDIR=$HOME/.config/zsh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt inc_append_history

alias ls='ls --color'
alias l='ls -lah'

# Install starship prompt
if ! command -v starship >/dev/null 2>&1; then
  if which wget >/dev/null; then
    echo "Downloading via wget"
    wget https://starship.rs/install.sh
  elif which curl >/dev/null; then
    echo "Downloading via curl"
    curl -sS -O https://starship.rs/install.sh
  else
    echo "Cannot download, neither wget nor curl. Exiting"
    exit 1
  fi
  sh ./install.sh
  rm ./install.sh
fi

# antidote install
[ -d ${ZDOTDIR:-$HOME}/.antidote ] || git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins

# load antidote
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh

# antidote plugins
echo "getantidote/use-omz
ohmyzsh/ohmyzsh path:lib
ohmyzsh/ohmyzsh path:plugins/extract

# add fish-like features
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions
zsh-users/zsh-history-substring-search
zsh-users/zsh-completions

# add vi-mode
jeffreytse/zsh-vi-mode
hlissner/zsh-autopair
" >${zsh_plugins}.txt

# Lazy-load antidote and generate the static load file only when needed

if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

# Spaceship prompt vars
SPACESHIP_AWS_SHOW=true
SPACESHIP_TIME_SHOW=true
SPACESHIP_VI_MODE_SHOW=true
TERM="xterm-256color"

# vi mode
bindkey -v

# moar path
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/.scripts:$HOME/go/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/Users/dblokzyl/.cargo/bin:$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH

# Automagic rehash for newly installed programs to show in completion
zstyle ':completion:*' rehash true

## Aliases / private functions
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.zsh_private ] && source ~/.zsh_private
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# python versions stuff
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv init --path)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# starship prompt ftw
eval "$(starship init zsh)"
