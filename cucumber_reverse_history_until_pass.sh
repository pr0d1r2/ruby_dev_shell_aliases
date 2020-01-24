# Move backwards in git history until given cucuber pass
#
# Useful to detect commit command -v broke the cucuber.
#
# Example usage:
#   cucumber_reverse_history_until_pass features/failing_in_last_commit.feature
#   cucumber_reverse_history_until_pass features/failing_in_last_commit.feature:8472
function cucumber_reverse_history_until_pass() {
  if [ -z "$1" ]; then
    echo "Please give failing cucumber[s] as parameter[s] !!!"
    return 1
  fi
  local cucumber_reverse_history_until_pass_RETVAL
  local cucumber_reverse_history_until_pass_CUCUMBER_SETUP
  cucumber_reverse_history_until_pass_RETVAL="1"
  while [ "$cucumber_reverse_history_until_pass_RETVAL" -gt 0 ]
  do
    git checkout "HEAD~1" || return $?
    cucumber_reverse_history_until_pass_CUCUMBER_SETUP="$(cucumber_setup)" || return $?
    $cucumber_reverse_history_until_pass_CUCUMBER_SETUP || return $?
    cucumber "$(cucumber_recognize "$@")" && return 0
  done
}
