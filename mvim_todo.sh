function mvim_todo() {
  todo_files_in_git_branch | parallel mvim
}
