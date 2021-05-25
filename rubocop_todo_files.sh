function rubocop_todo_files() {
  git diff HEAD .rubocop_todo.yml | grep "^-    -" | cut -f 2 -d "'"
  return $?
}
