function bec_detect_failure() {
  SLEEP=1 until_failure bec_run_all $@ || return $?
}
