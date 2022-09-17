function rubocop_todo_continue_rebase() {
  echorun silently bundle exec rubocop --regenerate-todo && \
    git add .rubocop_todo.yml && \
    GIT_EDITOR=true git rebase --continue
}
