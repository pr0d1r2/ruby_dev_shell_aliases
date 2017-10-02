# Show cucumber scenarios lines
#
# Example usage:
#   cucumber_scenarios_lines features/my.feature features/other.feature:111
#
# Will return:
#   features/my.feature:22
#   features/my.feature:45
#   features/other.feature:111
function cucumber_scenarios_lines() {
  parallel \
    'grep -n "Scenario" {} | cut -f 1 -d : | sed -e "s|^|{}:|"' \
    ::: \
    "$@" 2>/dev/null
  parallel \
    "echo {} | grep -E ':[0-9]{1,}$'" \
    ::: \
    "$@" 2>/dev/null
}
