function cucumber_stop_all_until_no_processes() {
  local cucumber_stop_all_until_no_processes_STATUS=0
  while [ $cucumber_stop_all_until_no_processes_STATUS -eq 0 ]
  do
    echorun cucumber_stop_all
    ps -ax | grep "bin/cucumber features" | grep -v grep | grep -q "bin/cucumber features"
    cucumber_stop_all_until_no_processes_STATUS=$?
    echorun sleep 5
  done
}
