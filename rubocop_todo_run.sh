function rubocop_todo_run() {
  git diff HEAD .rubocop_todo.yml | grep "^-    -" | cut -f 2 -d "'" | \
    parallel "bundle exec rubocop {}"
  return $?
}
