function rubocop_todo_removed_files() {
  git dih .rubocop_todo.yml | grep "^-    - '" | cut -f 2 -d "'"
  return $?
}
