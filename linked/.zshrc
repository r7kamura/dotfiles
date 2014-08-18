## autoload
fpath=("$HOME/.zsh/functions" $fpath)
autoload -Uz colors
autoload -Uz add-zsh-hook
autoload -Uz compinit
autoload -Uz history-search-end
autoload -Uz my_rprompt
autoload -Uz my_copyline


## setopt
setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_HISTORY
setopt HIST_EXPAND
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt transient_rprompt


## variable
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"
export EDITOR=vim
export CLICOLOR=YES
export GOPATH=$HOME

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000


## keybind
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
if zle -la | grep -q '^history-incremental-pattern-search'; then
  bindkey '^R' history-incremental-pattern-search-backward
  bindkey '^S' history-incremental-pattern-search-forward
fi


## execution
# compinit
colors
my_rprompt
my_copyline


## prompt
PROMPT="%{${fg[yellow]}%}✘╹◡╹✘%{${reset_color}%} "


## history
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 50
zstyle ':completion:*' list-colors ''
zstyle :compinstall filename "$HOME/.zshrc"


## alias
alias ll='ls -1'
alias xl='tmux list-session'
alias xa='tmux a -t'
alias xn='tmux new -s'
alias b='bundle exec'
alias o='git ls-files | p open'
alias c='open .'
alias g='hub'
alias d='git diff'
alias s='git status --short'
alias gg='git grep'
alias br='git symbolic-ref HEAD | cut -b 12-'
alias t='tig'
alias r='bundle exec rspec -f d'
alias q='exit'
alias z='v ~/.zshrc'
alias zz='. ~/.zshrc'
alias v='atom'
alias vv='v ~/.vimrc'
alias snip='open ~/.vim/bundle/snipMate/snippets'
alias copy='tmux save - | pbcopy'
alias gv='git commit -v'
alias e='ghq list -p | p cd'
alias f='ghq get -p $@'
alias ll='ls -1'
alias j='find . -type d -name ".git" -prune -o -type d -print | p cd'


## function
a() { git add . $1 --all; git status --short }
m() { git commit -m "$*" }
u() { cd ./$(git rev-parse --show-cdup)/$1 }
p() { peco | while read LINE; do $@ $LINE; done }

## Go...
export PATH=$PATH:/usr/local/Cellar/go/1.2.1/libexec/bin

## Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export ATOM_PATH=/opt/homebrew-cask/Caskroom/atom/latest

## local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
