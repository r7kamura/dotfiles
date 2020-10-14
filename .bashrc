# Wrap given text with specified color's escape sequence.
#
# ## Arguments
#
# 1. preserved color name (e.g. 'yellow')
# 2. wrapped text (e.g. 'Lorem ipsum dolor sit amet')
color() {
  local clear='\001\033[00m\002'
  local code

  case "${1}" in
    yellow)
      code='\001\033[01;33m\002'
      ;;
    blue)
      code='\001\033[01;34m\002'
      ;;
    purple)
      code='\001\033[01;35m\002'
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

git_branch_delete_merged() {
  git branch --merged | grep -v \* | xargs git branch --delete 2> /dev/null
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

git_fuzzy_stage_files() {
  git status --porcelain | sed -e 's/^...//' | peco | xargs git add
}

git_replace() {
  git grep --files-with-matches "${1}" | xargs sed -i "s/${1}/${2}/g"
}

prompt() {
  cat <<-SHELL
$(color 'blue' ${PWD}) $(color 'purple' $(git_branch_current))
$(color 'yellow' '$') $()
SHELL
}

tmux_create_new_session_from_pwd() {
  tmux new-session -s $(tmux_session_name_from_pwd)
}

tmux_fuzzy_attach_session() {
  tmux attach-session -t $(tmux_fuzzy_select_session)
}

tmux_fuzzy_select_session() {
  tmux_list_session | peco
}

tmux_list_session() {
  tmux list-session -F "#{session_name}"
}

tmux_session_name_from_pwd() {
  basename ${PWD} | sed 's/\.//g'
}

export PS1='$(prompt)'

alias ga='git_fuzzy_stage_files; git status --short'
alias gb='git branch'
alias gc='git_fuzzy_branch_switch'
alias gd='git diff HEAD'
alias gg='git grep'
alias gm='git_commit_with_arguments_message'
alias gr='git_replace'
alias gs='git status --short'
alias gz='git_branch_delete_merged'
alias pr='gh pr view -w || gh pr create -w'
alias qe='ghq_fuzzy_switch'
alias qf='ghq get -p'
alias sb='source ~/.bashrc'
alias ta='tmux_fuzzy_attach_session'
alias tl='tmux_list_session'
alias tn='tmux_create_new_session_from_pwd'
