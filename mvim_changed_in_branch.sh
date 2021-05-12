function mvim_changed() {
  git_files_changed_in_branch | parallel "mvim {}"
}
