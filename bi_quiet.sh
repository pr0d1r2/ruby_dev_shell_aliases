function bi_quiet() {
  local bi_quiet_STATUS
  bi &> /tmp/.bi_quiet-$$.log
  bi_quiet_STATUS=$?
  if [ $bi_quiet_STATUS -gt 0 ]; then
    cat /tmp/.bi_quiet-$$.log
  fi
  rm -f /tmp/.bi_quiet-$$.log
  return $bi_quiet_STATUS
}
