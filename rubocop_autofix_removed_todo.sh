function rubocop_autofix_removed_todo() {
  bundle exec rubocop -A $(rubocop_todo_removed_files)
  return $?
}
