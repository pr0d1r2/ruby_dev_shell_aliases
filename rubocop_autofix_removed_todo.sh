function rubocop_autofix_removed_todo() {
  local rubocop_autofix_removed_todo_FILES
  local rubocop_autofix_removed_todo_RUBOCOP_FILES
  rubocop_autofix_removed_todo_FILES=$()
  rubocop_autofix_removed_todo_RUBOCOP_FILES=$(be rubocop --parallel $(rubocop_todo_removed_files) | grep "rb:" | cut -f 1 -d : | sort -u)
  if [ $(echo $rubocop_autofix_removed_todo_RUBOCOP_FILES | wc -l) -gt 1 ]; then
    bundle exec rubocop -A $(echo $rubocop_autofix_removed_todo_RUBOCOP_FILES)
  fi
  return $?
}
