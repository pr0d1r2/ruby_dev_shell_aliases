function cucumber_scenarios_or_tags_at_lines() {
  local cucumber_scenarios_or_tags_at_lines_LINE
  local cucumber_scenarios_or_tags_at_lines_LINE_PREVIOUS
  for cucumber_scenarios_or_tags_at_lines_LINE in `cucumber_scenarios_at_lines $1`
  do
    cucumber_scenarios_or_tags_at_lines_LINE_PREVIOUS=`expr $cucumber_scenarios_or_tags_at_lines_LINE - 1`
    sed -n ${cucumber_scenarios_or_tags_at_lines_LINE_PREVIOUS}p $1 | grep -q "@"
    if [ $? -eq 0 ]; then
      echo $cucumber_scenarios_or_tags_at_lines_LINE_PREVIOUS
    else
      echo $cucumber_scenarios_or_tags_at_lines_LINE
    fi
  done
}
