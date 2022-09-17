function knapsack_ordered_specs() {
  cat knapsack_rspec_report.json | grep spec | cut -f 2 -d : | cut -b2- | sort -V | parallel -j 1 "grep {} knapsack_rspec_report.json" | cut -f 2 -d '"'
}
