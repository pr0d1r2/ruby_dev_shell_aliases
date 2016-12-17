function count_failures() {
  local count_failures_ERR
  local count_failures_SLEEP
  local count_failures_RUN
  local count_failures_COUNT
  case $SLEEP in
    "")
      count_failures_SLEEP=60
      ;;
    [0-9] | [1-9][0-9] | [1-9][0-9][0-9] | [1-9][0-9][0-9][0-9])
      count_failures_SLEEP=$SLEEP
      ;;
  esac
  count_failures_RUN=1
  count_failures_COUNT=0
  while [ 0 -eq 0 ]; do
    echo "count_failures: run #$count_failures_RUN (failures: $count_failures_COUNT) (`date`)"
    $@
    count_failures_ERR=$?
    if [ $count_failures_ERR -gt 0 ]; then
      count_failures_COUNT=$(( $count_failures_COUNT + 1 ))
    fi
    sleep $count_failures_SLEEP
    count_failures_RUN=$(( $count_failures_RUN + 1 ))
  done
}
