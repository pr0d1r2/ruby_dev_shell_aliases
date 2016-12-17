function bec_failures() {
  local bec_failures_ERR
  local bec_failures_FILE
  local bec_failures_ERROR_FILE
  local bec_failures_FAILED=()
  local bec_failures_ANY=0
  for bec_failures_ERROR_FILE in `ls -d tmp/cucumber_failures-*.log`
  do
    local bec_failures_ANY_IN_ERROR_FILE=0
    for bec_failures_FILE in `cat $bec_failures_ERROR_FILE`
    do
      echorun bec -p parallel $bec_failures_FILE
      if [ $? -gt 0 ]; then
        bec_failures_ANY_IN_ERROR_FILE=1
        bec_failures_ANY=1
        bec_failures_FAILED+=$bec_failures_FILE
      fi
    done
    if [ $bec_failures_ANY_IN_ERROR_FILE -eq 0 ]; then
      rm -f $bec_failures_ERROR_FILE
    fi
  done
  if [ $bec_failures_ANY_IN_ERROR_FILE -gt 0 ]; then
    echo
    echo 'FAILED:'
    echo $bec_failures_FAILED
  fi
  return $bec_failures_ANY_IN_ERROR_FILE
}
