# Move backwards in git history until given spec pass
#
# Useful to detect commit which broke the spec.
#
# Example usage:
#   rspec_reverse_history_until_spec_pass spec/failing_in_last_commit_spec.rb
#   rspec_reverse_history_until_spec_pass spec/failing_in_last_commit_spec.rb:8472
function rspec_reverse_history_until_spec_pass() {
  if [ -z "$1" ]; then
    echo "Please give failing spec[s] as parameter[s] !!!"
    return 1
  fi
  local rspec_reverse_history_until_spec_pass_RETVAL
  rspec_reverse_history_until_spec_pass_RETVAL="1"
  while [ "$rspec_reverse_history_until_spec_pass_RETVAL" -gt 0 ]
  do
    git checkout "HEAD~1" || return $?
    rspec -f p $(spec_recognize "$@") && return 0
  done
}
