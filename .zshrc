export CLICOLOR=YES
autoload -U colors
colors
PROMPT="%{${fg[yellow]}%}✘╹◡╹✘%{${reset_color}%} "
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_space

bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt auto_cd
setopt auto_pushd

autoload -U compinit
compinit
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 50
zstyle ':completion:*' list-colors ''
zstyle :compinstall filename "$HOME/.zshrc"

# activate wildcard(*) in incremental-search
if zle -la | grep -q '^history-incremental-pattern-search'; then
  bindkey '^R' history-incremental-pattern-search-backward
  bindkey '^S' history-incremental-pattern-search-forward
fi

# ctrl + allow key
bindkey ";5C" forward-word
bindkey ";5D" backward-word

## Git
alias g="git"
alias gad="git add"
alias gb="git branch -v"
alias gba="git branch -a"
alias gbr="git branch -r"
alias gc="git commit -v"
alias gcl="git clone"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"
alias gdh="git diff HEAD"
alias gf="git fetch"
alias gg="git grep -n"
alias ggi="git grep -ni"
alias gl="git log --stat"
alias gll="git log --oneline"
alias glp="git log -p"
alias gls="git ls-files"
alias gm="git merge"
alias gst="git status"
alias gs="git show"
alias gsp="git stash pop"
alias gss="git stash save"
alias gssh="git stash show"
alias gsl="git stash list"
alias gPull="git pull"
alias gcd='cd ./$(git rev-parse --show-cdup)'
alias gcb="git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'"
alias gp='git push origin `gcb`'
alias ggg='git add -A && git commit -m "Generate with: $ $(fc -ln -1)"'

## Ruby
alias cov='open coverage/index.html -a "Google Chrome"'
alias b='bundle exec'
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
case "${TERM}" in screen) preexec() { echo -ne "\ek${1%% *}\e\\" } esac

## PATH
export PATH="$HOME/bin:$PATH"

## Mac
alias p='pbcopy'
alias o='open'
alias c='open .'
alias v='open -a macvim "$@"'
alias scr='screen'
alias font='defaults -currentHost write -globalDomain AppleFontSmoothing -int 2'
alias snip='open ~/.vim/bundle/snipMate/snippets'
export EDITOR="$HOME/bin/mvim -f"
pbcopy-displayed-command-line(){
    print -rn $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}"
}
zle -N pbcopy-displayed-command-line
bindkey '^x^p' pbcopy-displayed-command-line

## Else
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

alias src='cd ~/Dropbox/src'
alias d='git diff'
alias s='git status --short'
alias t='tig'
alias z='v ~/.zshrc'
alias zz='. ~/.zshrc'
alias r='bundle exec rspec'
alias blog='open ~/Dropbox/Apps/hakolog/entries'
alias q='exit'

function a {
  git add . $1
  git status --short
}

function m {
  git commit -m "$*"
}
