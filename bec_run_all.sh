function bec_run_all() {
  echorun bec `one_liner $@` || return $?
}
