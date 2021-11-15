# Allow you to find single file causing failure of the last spec
# Useful when parallel tests not set up in project.
#
# Example usage:
#   rspec_check_spec_single_file_interdependency_single_thread first_spec.rb second_spec.rb last_spec_failing_because_of_one_of_previous_ones_spec.rb
# You can also specify random seed to be used:
#   SEED=8472 rspec_check_spec_single_file_interdependency_single_thread first_spec.rb second_spec.rb last_spec_failing_because_of_one_of_previous_ones_spec.rb

function rspec_check_spec_single_file_interdependency_single_thread() {
  local rspec_check_spec_single_file_interdependency_single_thread_LAST_SPEC
  rspec_check_spec_single_file_interdependency_single_thread_LAST_SPEC="${@:~0}"

  rspec_check_spec_single_file_interdependency_single_thread_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
  rspec_check_spec_single_file_interdependency_single_thread_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
  rspec_check_spec_single_file_interdependency_single_thread_COMMAND+="silently bundle exec rspec -f p"
  if [ -n "$SEED" ]; then
    rspec_check_spec_single_file_interdependency_single_thread_COMMAND+=" --seed $SEED"
  fi
  rspec_check_spec_single_file_interdependency_single_thread_COMMAND+=" {} $rspec_check_spec_single_file_interdependency_single_thread_LAST_SPEC"

  parallel -j 1 --halt now,fail=1 "$rspec_check_spec_single_file_interdependency_single_thread_COMMAND" ::: "$@"
  return $?
}
