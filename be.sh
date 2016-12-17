function be() {
  bundle exec $@ || return $?
}
