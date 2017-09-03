function cucumber_stop_all() {
  kill_forcefully "$(ps -ax | pgrep bin/cucumber | cut -b1-5)"
}
