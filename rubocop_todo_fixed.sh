function rubocop_todo_fixed() {
  git dih .rubocop_todo.yml | grep -e "^-[A-Z]" | cut -f 1 -d : | cut -f 2- -d -
}
