function poke_files_changed_in_branch() {
  local poke_files_changed_in_branch_ID
  poke_files_changed_in_branch_ID="# POKE_FILES_CHANGED_IN_BRANCH_$(datetimeh)"
  git_files_changed_in_branch | grep -v "^Guardfile$" | \
    parallel "echo -n '$poke_files_changed_in_branch_ID' >> {} && grep -v '$poke_files_changed_in_branch_ID' {} > {}.tmp && mv {}.tmp {}"
}
