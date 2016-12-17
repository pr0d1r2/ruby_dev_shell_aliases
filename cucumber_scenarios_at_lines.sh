function cucumber_scenarios_at_lines() {
  grep -n "Scenario" $1 | cut -f 1 -d :
}
