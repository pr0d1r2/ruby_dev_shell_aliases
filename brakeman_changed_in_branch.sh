function brakeman_changed_in_branch() {
  brakeman --only-files `git_files_changed_vs_origin_master` . || return $?
}
