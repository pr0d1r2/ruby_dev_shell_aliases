function split_feature_scenarios_and_run_in_parallel() {
  local split_feature_scenarios_and_run_in_parallel_FILE
  for split_feature_scenarios_and_run_in_parallel_FILE in $@
  do
    DISABLE_SPRING=1 echorun bundle exec rake "parallel:features[,'`split_feature_scenarios $split_feature_scenarios_and_run_in_parallel_FILE`']" || return $?
  done
}
