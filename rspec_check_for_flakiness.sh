# Check for flakiness in RSpec example or file (in parallel)
#
# Example usage:
#   rspec_check_for_flakiness spec/my_spec.rb
#   rspec_check_for_flakiness spec/my_spec.rb:8472
function rspec_check_for_flakiness() {
  rspec_check_for_flakiness_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_check_for_flakiness_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_check_for_flakiness_COMMAND+="source $HOME/projects/common_shell_aliases/until_failure.sh && "
  rspec_check_for_flakiness_COMMAND+="SLEEP=1 ATTEMPTS=20 TEST_ENV_NUMBER={} until_failure silently bundle exec rspec -f p $*"
  cpu_list | parallel --halt now,fail=1 "$rspec_check_for_flakiness_COMMAND"
  return $?
}
