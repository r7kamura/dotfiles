# Wrap given text with specified color's escape sequence.
#
# ## Arguments
#
# 1. preserved color name (e.g. 'yellow')
# 2. wrapped text (e.g. 'Lorem ipsum dolor sit amet')
color() {
  local clear='\033[00m'
  local code

  case "${1}" in
    yellow)
      code='\033[01;33m'
      ;;
    blue)
      code='\033[01;34m'
      ;;
    purple)
      code='\033[01;35m'
      ;;
  esac

  echo -e "${code}${2}${clear}"
}

ghq_fuzzy_select() {
  ghq list --full-path | peco
}

ghq_fuzzy_switch() {
  cd $(ghq_fuzzy_select)
}

git_branch_current() {
  git branch --show-current 2> /dev/null
}

git_branch_list() {
  git branch --format '%(refname:lstrip=2)'
}

git_commit_with_arguments_message() {
  git commit --message "$*"
}

git_fuzzy_branch_select() {
  git_branch_list | peco
}

git_fuzzy_branch_switch() {
  git_fuzzy_branch_select | xargs git checkout
}

git_replace() {
  git grep --files-with-matches ${1} | xargs sed -i "s/${1}/${2}/g"
}

prompt() {
  cat <<-SHELL
$(color 'blue' ${PWD}) $(color 'purple' $(git_branch_current))
$(color 'yellow' '$') $()
SHELL
}

export PS1='$(prompt)'

# 1 character aliases.
alias a='git add --all; git status --short'
alias b='bundle exec'
alias c='open .'
alias d='git diff'
alias e='ghq_fuzzy_switch'
alias f='ghq get -p'
alias g='git'
alias k='git_replace'
alias m='git_commit_with_arguments_message'
alias r='source ~/.bashrc'
alias s='git status --short'
alias t='tig'

# 2 characters aliases.
alias br='git_branch_list'
alias dc='git diff --cached'
alias dh='git diff HEAD'
alias dr='git branch --merged | grep -v \* | xargs git branch --delete 2> /dev/null'
alias gc='git_fuzzy_branch_switch'
alias gg='git grep'
alias gm='git commit'
alias gp='git push'
alias gr='gh repo view --web'
alias ta='tmux attach-session -t'
alias tl='tmux list-session'
alias tn='tmux new-session -s'
