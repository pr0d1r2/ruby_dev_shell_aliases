function rubocop_parallel_in_branch() {
  git_files_changed_in_branch | parallel "rubocop $* {}"
}
