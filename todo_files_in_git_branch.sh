function todo_files_in_git_branch() {
  git_files_changed_in_branch | parallel "grep -q TODO {} && echo {}"
}
