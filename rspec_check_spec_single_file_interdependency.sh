# Allow you to find single file causing failure of the last spec
#
# Example usage:
#   rspec_check_spec_single_file_interdependency first_spec.rb second_spec.rb last_spec_failing_because_of_one_of_previous_ones_spec.rb
# You can also specify random seed to be used:
#   SEED=8472 rspec_check_spec_single_file_interdependency first_spec.rb second_spec.rb last_spec_failing_because_of_one_of_previous_ones_spec.rb

function rspec_check_spec_single_file_interdependency() {
  local rspec_check_spec_single_file_interdependency_LAST_SPEC
  rspec_check_spec_single_file_interdependency_LAST_SPEC="${@:~0}"

  rspec_check_spec_single_file_interdependency_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_check_spec_single_file_interdependency_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_check_spec_single_file_interdependency_COMMAND+="TEST_ENV_NUMBER={%} silently bundle exec rspec -f p"
  if [ -n "$SEED" ]; then
    rspec_check_spec_single_file_interdependency_COMMAND+=" --seed $SEED"
  fi
  rspec_check_spec_single_file_interdependency_COMMAND+=" {} $rspec_check_spec_single_file_interdependency_LAST_SPEC"

  parallel --halt now,fail=1 "$rspec_check_spec_single_file_interdependency_COMMAND" ::: "$@"
  return $?
}
