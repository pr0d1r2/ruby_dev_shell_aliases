function guard_stop_all() {
  echorun kill_forcefully `ps -ax | grep guard-rspec | grep -v grep | cut -b1-5` &
  echorun kill_forcefully `ps -ax | grep _guard-core | grep -v grep | cut -b1-5` &
  echorun kill_forcefully `ps -ax | grep bin/guard | grep -v grep | cut -b1-5` &
  wait
}
