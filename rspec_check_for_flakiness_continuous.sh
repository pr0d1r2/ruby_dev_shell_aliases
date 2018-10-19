# Check for flakiness in RSpec example or spec file.
# It checks example or spec file with all possible random seeds in parallel.
# Without stopping on the first occurrence (also see rspec_check_for_flakiness)
#
# Example usage:
#   rspec_check_for_flakiness_continuous spec/my_spec.rb
#   rspec_check_for_flakiness_continuous spec/my_spec.rb:8472
function rspec_check_for_flakiness_continuous() {
  rspec_check_for_flakiness_continuous_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_check_for_flakiness_continuous_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_check_for_flakiness_continuous_COMMAND+="TEST_ENV_NUMBER={%} silently bundle exec rspec --seed {} -f p $*"
  seq 65535 | parallel "$rspec_check_for_flakiness_continuous_COMMAND"
  return $?
}
