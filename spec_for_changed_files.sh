function spec_for_changed_files() {
  local spec_for_changed_files_FILE
  for spec_for_changed_files_FILE in `git_files_changed`
  do
    spec_for $spec_for_changed_files_FILE
  done
}
