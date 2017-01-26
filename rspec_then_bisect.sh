function rspec_then_bisect() {
  rspec $@ || return $?
  rspec $@ --bisect || return $?
}
