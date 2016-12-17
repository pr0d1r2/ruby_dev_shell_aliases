function bepcs() {
  local bepcs_ERR
  local bepcs_FILE
  local bepcs_ENTRY
  local bepcs_FILES=()
  for bepcs_FILE in $@
  do
    if [ -d $bepcs_FILE ]; then
      for bepcs_ENTRY in `find $bepcs_FILE -type f -name "*.feature"`
      do
        bepcs_FILES+=$bepcs_ENTRY
      done
    else
      bepcs_FILES+=$bepcs_FILE
    fi
  done
  rm -f tmp/cucumber_failures-*.log
  split_feature_scenarios_and_run_in_parallel_all $bepcs_FILES
  bepcs_ERR=$?
  if [ $bepcs_ERR -gt 0 ]; then
    echorun bepc_failures || echorun bec_failures || return $bepcs_ERR
  fi
}
