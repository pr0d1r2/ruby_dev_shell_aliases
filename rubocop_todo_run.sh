function rubocop_todo_run() {
  rubocop_todo_files | parallel "bundle exec rubocop {}"
  return $?
}
