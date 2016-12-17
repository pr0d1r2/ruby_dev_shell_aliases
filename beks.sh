function beks() {
  if [ ! -f knapsack_rspec_report.json ]; then
    echo 'No knapsack_rspec_report.json !!!'
    return 8472
  fi
  case $1 in
    '')
      DISABLE_SPRING=1 bundle exec rake "knapsack:rspec[--fail-fast]"
      ;;
    *)
      DISABLE_SPRING=1 KNAPSACK_TEST_FILE_PATTERN="{`echo $@ | tr ' ' ','`}" bundle exec rake "knapsack:rspec[--fail-fast]"
      ;;
  esac
  return $?
}
