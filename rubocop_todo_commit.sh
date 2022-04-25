function rubocop_todo_commit() {
  bundle exec rubocop --parallel $(rubocop_todo_removed_files | grep ".rb$") && git commit -a -m "Conform to $(rubocop_todo_fixed)"
}
