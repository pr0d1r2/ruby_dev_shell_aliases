function spring_stop_all() {
  local spring_stop_all_PID
  for spring_stop_all_PID in `ps -ax | grep "spring app" | grep -v grep | cut -b1-5`
  do
    kill $spring_stop_all_PID
  done
  for spring_stop_all_PID in `ps -ax | grep "spring server" | grep -v grep | cut -b1-5`
  do
    kill $spring_stop_all_PID
  done
}
