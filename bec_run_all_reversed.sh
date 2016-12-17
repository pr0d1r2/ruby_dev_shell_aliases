function bec_run_all_reversed() {
  echorun bec `one_liner \`array_reverse $@\`` || return $?
}
