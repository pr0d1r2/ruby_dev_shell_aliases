function overcommit_disable() {
  OVERCOMMIT_DISABLE=1 $@ || return $?
}
