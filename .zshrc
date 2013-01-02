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


## variable
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export EDITOR=vim
export CLICOLOR=YES
export NODE_PATH='/usr/local/lib/node_modules/'
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
colors
compinit
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
alias ls='ls -1'
alias b='bundle exec'
alias o='open'
alias c='open .'
alias src='cd ~/Dropbox/src'
alias chrome='open -a "Google Chrome" "$@"'
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
alias v='open -a macvim "$@"'
alias vv='v ~/.vimrc'
alias snip='open ~/.vim/bundle/snipMate/snippets'
alias copy='tmux save - | pbcopy'


## function
a() { git add . $1; git status --short }
m() { git commit -m "$*" }
u() { cd ./$(git rev-parse --show-cdup)/$1 }
gl() { [ $# -eq 1 ] && git status -s | awk '{print$1="";print}' | grep -v "^$" | awk "NR==$1" }
ga() { [ $# -eq 1 ] && git add $(gl $1) && s }
gd() { [ $# -eq 1 ] && git diff -- $(gl $1) && s}
gr() { [ $# -eq 1 ] && git reset -- $(gl $1) && s}
gv() { [ $# -eq 1 ] && v $(gl $1) }


## local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
