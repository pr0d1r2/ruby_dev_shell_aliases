function spring_stop_all() {
  kill_forcefully \
    "$(ps -ax | pgrep "spring app" | cut -b1-5)" \
    "$(ps -ax | pgrep "spring server" | cut -b1-5)"
  return $?
}
