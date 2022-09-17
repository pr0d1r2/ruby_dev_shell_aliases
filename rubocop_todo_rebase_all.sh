function rubocop_todo_rebase_all() {
  local rubocop_todo_rebase_all_LOOP
  rubocop_todo_rebase_all_LOOP=1
  while [ $rubocop_todo_rebase_all_LOOP -gt 0 ]
  do
    rubocop_todo_rebase_all_LOOP=0
    git status -sb || return $?
    echorun silently bin/test_unit || return $?
    rubocop_todo_continue_rebase
    if [ $(git status -sb | grep "^UU" | wc -l) -eq 1 ]; then
      if (git status -sb | grep -q "^UU .rubocop_todo.yml"); then
        rubocop_todo_rebase_all_LOOP=1
      fi
    elif [ $(git status -sb | grep "^UU" | wc -l) -eq 0 ]; then
      rubocop_todo_rebase_all_LOOP=1
    fi
  done
}
