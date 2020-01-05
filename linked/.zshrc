## autoload
fpath=("$HOME/.zsh/functions" $fpath)
autoload -Uz colors
autoload -Uz add-zsh-hook
autoload -Uz compinit
autoload -Uz history-search-end
autoload -Uz my_rprompt
autoload -Uz my_copyline

## setopt
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
PROMPT="%{${fg[yellow]}%}$%{${reset_color}%} "

## history
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 50
zstyle ':completion:*' list-colors ''
zstyle :compinstall filename "$HOME/.zshrc"

## alias
alias xl='tmux list-session'
alias xa='tmux a -t'
alias xn='tmux new -s'
alias b='bundle exec'
alias c='open .'
alias g='hub'
alias d='git diff'
alias s='git status --short'
alias gg='git grep'
alias br='git symbolic-ref HEAD | cut -b 12-'
alias t='tig'
alias r='bundle exec rspec -f d'
alias v='atom'
alias copy='tmux save - | pbcopy'
alias gv='git commit -v'
alias e='cd $(ghq root)/$(ghq list | peco)'
alias f='ghq get -p $@'
alias pr='hub browse -- pull/$(git rev-parse --abbrev-ref HEAD)'
alias gc='git branch | peco | xargs git checkout'

## function
a() { git add . $1 --all; git status --short }
k() { git grep -l $1 | xargs gsed -i -r -e "s;$1;$2;g" }
m() { git commit -m "$*" }

## Go...
export PATH=$PATH:/usr/local/Cellar/go/1.2.1/libexec/bin

## Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export ATOM_PATH=/opt/homebrew-cask/Caskroom/atom/latest

## local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR="/Users/r7kamura/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

. "/usr/local/opt/nvm/nvm.sh"

export EDITOR=vi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/r7kamura/Desktop/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/r7kamura/Desktop/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/r7kamura/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/r7kamura/Desktop/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(nodenv init -)"
export PATH="$HOME/.nodenv/bin:$PATH"
