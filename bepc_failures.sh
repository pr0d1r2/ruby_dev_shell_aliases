function bepc_failures() {
  local bepc_failures_ERR
  local bepc_failures_FILE
  local bepc_failures_FILES=()
  local bepc_failures_NUM=0
  for bepc_failures_FILE in `cat tmp/cucumber_failures-*.log`
  do
    bepc_failures_FILES+=$bepc_failures_FILE
    bepc_failures_NUM+=1
  done
  if [ $bepc_failures_NUM -eq 0 ]; then
    return 0
  elif [ $bepc_failures_NUM -eq 1 ]; then
    echorun bec_failures || return $?
  elif [ $bepc_failures_NUM -le `nproc` ]; then
    echorun bec_parallelized $bepc_failures_FILES || return $?
  else
    echorun bepc $bepc_failures_FILES || return $?
  fi
  rm -f tmp/cucumber_failures-*.log
}
