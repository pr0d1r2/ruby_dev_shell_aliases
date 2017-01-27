function run_spec_for_files_changed_in_branch() {
  local run_spec_for_files_changed_in_branch_COUNT=0
  local run_spec_for_files_changed_in_branch_FILE
  local run_spec_for_files_changed_in_branch_FILES=()
  for run_spec_for_files_changed_in_branch_FILE in `existing_spec_for \`git_files_changed_in_branch\``
  do
    run_spec_for_files_changed_in_branch_FILES+=$run_spec_for_files_changed_in_branch_FILE
    run_spec_for_files_changed_in_branch_COUNT=`expr $run_spec_for_files_changed_in_branch_COUNT + 1`
  done
  if [ $run_spec_for_files_changed_in_branch_COUNT -eq 1 ]; then
    echorun bers $run_spec_for_files_changed_in_branch_FILES || return $?
  elif [ $run_spec_for_files_changed_in_branch_COUNT -gt 1 ]; then
    echorun beps $run_spec_for_files_changed_in_branch_FILES || return $?
  else
    echo "No specs for changed files !!!"
    return 8472
  fi
}
