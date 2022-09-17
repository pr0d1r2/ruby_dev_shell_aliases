function rspec_parallel_run() {
  local rspec_parallel_run_COMMAND
  rspec_parallel_run_COMMAND="test -f {} && (
    test -d tmp/rspec_parallel_run/{} || (
      TEST_ENV_NUMBER={%} RAILS_ENV=test bundle exec rspec {} && mkdir -p tmp/rspec_parallel_run/{}
    )
  )"
  if [ -f knapsack_rspec_report.json ]; then
    knapsack_ordered_specs | parallel "$rspec_parallel_run_COMMAND"
  else
    find . -type f -name "*_spec.rb" | parallel "$rspec_parallel_run_COMMAND"
  fi
}
