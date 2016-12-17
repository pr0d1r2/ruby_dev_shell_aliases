function split_feature_scenarios_and_run_in_parallel_all() {
  local split_feature_scenarios_and_run_in_parallel_all_ERR
  local split_feature_scenarios_and_run_in_parallel_all_FILES=()
  local split_feature_scenarios_and_run_in_parallel_all_FILE
  for split_feature_scenarios_and_run_in_parallel_all_FILE in `split_feature_scenarios $@`
  do
    split_feature_scenarios_and_run_in_parallel_all_FILES+=$split_feature_scenarios_and_run_in_parallel_all_FILE
  done
  DISABLE_SPRING=1 echorun bundle exec parallel_cucumber $split_feature_scenarios_and_run_in_parallel_all_FILES
  split_feature_scenarios_and_run_in_parallel_all_ERR=$?
  if [ $split_feature_scenarios_and_run_in_parallel_all_ERR -eq 0 ]; then
    for split_feature_scenarios_and_run_in_parallel_all_FILE in $split_feature_scenarios_and_run_in_parallel_all_FILES
    do
      echorun rm -rf $split_feature_scenarios_and_run_in_parallel_all_FILE &
    done
    wait
    echo "SUCCESS"
  else
    return $split_feature_scenarios_and_run_in_parallel_all_ERR
  fi
}
