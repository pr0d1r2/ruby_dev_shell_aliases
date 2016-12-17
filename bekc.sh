function bekc() {
  if [ ! -f knapsack_cucumber_report.json ]; then
    echo 'No knapsack_cucumber_report.json !!!'
    return 8472
  fi
  case $1 in
    '')
      DISABLE_SPRING=1 bundle exec rake knapsack:cucumber
      ;;
    *)
      DISABLE_SPRING=1 KNAPSACK_TEST_FILE_PATTERN="{`echo $@ | tr ' ' ','`}" bundle exec rake knapsack:cucumber
      ;;
  esac
  return $?
}
