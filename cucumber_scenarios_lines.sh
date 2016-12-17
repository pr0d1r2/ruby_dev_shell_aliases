function cucumber_scenarios_lines() {
  local cucumber_scenarios_lines_FILE
  for cucumber_scenarios_lines_FILE in $@
  do
    cucumber_scenarios_at_lines $cucumber_scenarios_lines_FILE | sed -e "s|^|$cucumber_scenarios_lines_FILE:|"
  done
}
