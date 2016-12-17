function knapsack_update_all() {
  knapsack_update_spec || return $?
  knapsack_update_cucumber || return $?
}
