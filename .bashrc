clipboard_copy() {
  clip.exe
}

clipboard_paste() {
  powershell.exe -command get-clipboard
}

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
    red)
      code='\001\033[01;31m\002'
      ;;
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

git_branch_create_feature() {
  git switch --create "$1"
}

git_branch_current() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

git_branch_delete_selected() {
  git_branch_list | peco | xargs git branch --delete --force 2> /dev/null
}

git_branch_delete_merged() {
  git branch --merged | grep -v \* | xargs git branch --delete 2> /dev/null
}

git_branch_list() {
  git branch --format '%(refname:lstrip=2)'
}

git_commit_with_arguments_message() {
  git commit --allow-empty --message "$*"
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
  git grep --files-with-matches -E -- "${1}" | xargs sed -i -r "s;${1};${2};g"
}

prompt() {
  if [ $? -eq 0 ]; then
    local symbol_color_name='yellow'
  else
    local symbol_color_name='red'
  fi
  cat <<-SHELL
$(color 'blue' ${PWD}) $(color 'purple' $(git_branch_current))
$(color ${symbol_color_name} '$') $()
SHELL
}

retry_previous_command_with_prompt() {
  previous_command=$(fc -ln -2 -2 | awk '{$1=$1}1')
  echo "$ ${previous_command}"
  $previous_command
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

alias cb='code ~/.bashrc'
alias co='clipboard_copy'
alias dc='docker-compose'
alias dk='docker ps --quiet | xargs --no-run-if-empty docker kill'
alias ga='git_fuzzy_stage_files; git status --short'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git_fuzzy_branch_switch'
alias gco='git checkout'
alias gd='git diff'
alias gf='git_branch_create_feature'
alias gg='git grep -n'
alias gl='git pull'
alias gm='git_commit_with_arguments_message'
alias gpf='git push --force'
alias grs='gh repo set-default'
alias gr='git_replace'
alias grc='git rebase --continue'
alias gs='git status --short'
alias gx='git_branch_delete_selected'
alias gz='git_branch_delete_merged'
alias pa='clipboard_paste'
alias pd='gh pr create --draft'
alias po='gh repo view --web'
alias pr='gh pr view -w || gh pr create -w'
alias prc='gh pr create --fill'
alias prcd='prc --draft'
alias qe='ghq_fuzzy_switch'
alias qf='ghq get -p'
alias rc='retry_previous_command_with_prompt | clipboard_copy'
alias sb='source ~/.bashrc'
alias ta='tmux_fuzzy_attach_session'
alias tl='tmux_list_session'
alias tn='tmux_create_new_session_from_pwd'

export EDITOR="code --wait"
