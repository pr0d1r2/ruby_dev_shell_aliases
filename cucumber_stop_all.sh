function cucumber_stop_all() {
  echorun kill_forcefully `ps -ax | grep bin/cucumber | grep -v grep | cut -b1-5` &
  wait
}

