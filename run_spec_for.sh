function run_spec_for() {
  local run_spec_for_COUNT=0
  local run_spec_for_FILE
  local run_spec_for_FILES=()
  for run_spec_for_FILE in `existing_spec_for $@`
  do
    run_spec_for_FILES+=$run_spec_for_FILE
    run_spec_for_COUNT+=1
  done
  if [ $run_spec_for_COUNT -eq 1 ]; then
    echorun bers $run_spec_for_FILES || return $?
  elif [ $run_spec_for_COUNT -gt 1 ]; then
    echorun beps $run_spec_for_FILES || return $?
  else
    echo "No specs for $@ !!!"
    return 8472
  fi
}
