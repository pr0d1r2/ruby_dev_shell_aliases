function knapsack_update_cucumber() {
  KNAPSACK=true KNAPSACK_GENERATE_REPORT=true bundle exec cucumber features || return $?
}
