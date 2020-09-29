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

git_fuzzy_branch_select() {
  git_branch_list | peco
}

git_fuzzy_branch_switch() {
  git_fuzzy_branch_select | xargs git checkout
}

prompt() {
  cat <<-SHELL
$(color 'blue' ${PWD}) $(color 'purple' $(git_branch_current))
$(color 'yellow' '$') $()
SHELL
}

export PS1='$(prompt)'

alias e='ghq_fuzzy_switch'
alias gc='git_fuzzy_branch_switch'
