# Show gems dependencies changes
#
# Example usage (to check gems changed on specific month):
#   gem_dependency_blame carrierwave | grep " 2018-05"
function gem_dependency_blame() {
  parallel \
    'echo {} ; gem dependency {} | cut -f 1 -d "(" | grep -v "^Gem "' \
    ::: \
    "$@" | \
  sort -u | \
  parallel \
    "git blame Gemfile | grep {} ; git blame Gemfile.lock | grep {}"
  return $?
}
