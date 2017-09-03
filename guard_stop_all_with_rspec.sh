function guard_stop_all_with_rspec() {
  guard_stop_all
  pkill rspec
  kill_forcefully "$(ps -ax | pgrep rspec | cut -b1-5)"
}
