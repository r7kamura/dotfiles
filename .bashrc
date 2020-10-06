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

tmux_fuzzy_attach_session() {
  tmux attach-session -t $(tmux_fuzzy_select_session)
}

tmux_fuzzy_select_session() {
  tmux_list_session | peco
}

tmux_list_session() {
  tmux list-session -F "#{session_name}"
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
alias br='git_branch_current'
alias dc='git diff --cached'
alias dh='git diff HEAD'
alias dr='git branch --merged | grep -v \* | xargs git branch --delete 2> /dev/null'
alias ga='git_fuzzy_stage_files; git status --short'
alias gc='git_fuzzy_branch_switch'
alias gg='git grep'
alias gm='git commit'
alias gp='git push'
alias gr='gh repo view --web'
alias pr='gh pr view -w || gh pr create -w'
alias ta='tmux_fuzzy_attach_session'
alias tl='tmux_list_session'
alias tn='tmux new-session -s'
