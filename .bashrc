ghq_fuzzy_select() {
  ghq list --full-path | peco
}

ghq_fuzzy_switch() {
  cd $(ghq_fuzzy_select)
}

git_branch_list() {
  git branch --format '%(refname:lstrip=2)'
}

git_fuzzy_branch_select() {
  git_branch_list | peco
}

git_fuzzy_branch_switch() {
  git_fuzzy_branch_select | xargs git checkout
}

git_branch_current() {
  git branch --show-current 2> /dev/null
}

prompt_all() {
  echo -e "$(prompt_pwd) $(prompt_git_branch)\n$(prompt_symbol) "
}

prompt_git_branch() {
  local clear='\033[00m'
  local purple='\033[01;35m'
  echo -e "${purple}$(git_branch_current)${clear}"
}

prompt_pwd() {
  local clear='\033[00m'
  local blue='\033[01;34m'
  echo -e "${blue}${PWD}${clear}"
}

prompt_symbol() {
  local clear='\033[00m'
  local yellow='\033[01;33m'
  echo -e "${yellow}\$${clear}"
}

export PS1='$(prompt_all)'

alias e='ghq_fuzzy_switch'
alias gc='git_fuzzy_branch_switch'
