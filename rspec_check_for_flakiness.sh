# Check for flakiness in RSpec example or spec file.
# It checks example or spec file with all possible random seeds in parallel.
#
# Example usage:
#   rspec_check_for_flakiness spec/my_spec.rb
#   rspec_check_for_flakiness spec/my_spec.rb:8472
function rspec_check_for_flakiness() {
  rspec_check_for_flakiness_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_check_for_flakiness_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_check_for_flakiness_COMMAND+="TEST_ENV_NUMBER={%} silently bundle exec rspec --seed {} -f p $*"
  seq 65535 | parallel --halt now,fail=1 "$rspec_check_for_flakiness_COMMAND"
  return $?
}
