function cucumber_kill() {
  kill `ps -ax | grep bin/cucumber | grep -v grep | cut -b1-5`
  sleep 1
  kill -9  `ps -ax | grep bin/cucumber | grep -v grep | cut -b1-5`

  kill `ps -ax | grep webdriver | grep -v grep | cut -b1-5`
  sleep 1
  kill -9 `ps -ax | grep webdriver | grep -v grep | cut -b1-5`
}
