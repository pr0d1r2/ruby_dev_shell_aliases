function run_spec_for_changed_files() {
  local run_spec_for_changed_files_COUNT=0
  local run_spec_for_changed_files_FILE
  local run_spec_for_changed_files_FILES=()
  for run_spec_for_changed_files_FILE in `existing_spec_for_changed_files`
  do
    run_spec_for_changed_files_FILES+=$run_spec_for_changed_files_FILE
    run_spec_for_changed_files_COUNT+=1
  done
  if [ $run_spec_for_changed_files_COUNT -eq 1 ]; then
    echorun run_spec_for $run_spec_for_changed_files_FILES || return $?
  elif [ $run_spec_for_changed_files_COUNT -gt 1 ]; then
    echorun run_spec_for $run_spec_for_changed_files_FILES || return $?
  else
    echo "No specs for changed files !!!"
    return 8472
  fi
}
