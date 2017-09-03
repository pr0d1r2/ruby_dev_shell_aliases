function guard_stop_all() {
  kill_forcefully \
    "$(ps -ax | pgrep guard-rspec | cut -b1-5)" \
    "$(ps -ax | pgrep _guard-core | cut -b1-5)" \
    "$(ps -ax | pgrep bin/guard | cut -b1-5)"
  return $?
}
