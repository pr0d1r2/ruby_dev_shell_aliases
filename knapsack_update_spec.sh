function knapsack_update_spec() {
  KNAPSACK=true KNAPSACK_GENERATE_REPORT=true bundle exec rspec spec || return $?
}
