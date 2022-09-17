function rspec_check_for_flakiness_in_project() {
  local rspec_check_for_flakiness_in_project_FILE
  for rspec_check_for_flakiness_in_project_FILE in $(knapsack_ordered_specs)
  do
    if [ ! -d "tmp/rspec_check_for_flakiness_in_project/$rspec_check_for_flakiness_in_project_FILE" ]; then
      echorun rspec_check_for_flakiness "$rspec_check_for_flakiness_in_project_FILE" && \
        mkdir -p "tmp/rspec_check_for_flakiness_in_project/$rspec_check_for_flakiness_in_project_FILE"
    fi
  done
}
