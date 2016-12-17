function guard_stop_all_with_rspec() {
  guard_stop_all
  echorun pkill rspec
  echorun kill_forcefully `ps -ax | grep rspec | grep -v grep | cut -b1-5`
}
