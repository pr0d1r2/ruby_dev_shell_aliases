# Check for flakiness in RSpec example or spec file.
# It checks example or spec file with all possible random seeds on single thread.
# Usefule when parallel tests not set up in project.
#
# Example usage:
#   rspec_check_for_flakiness_single_thread spec/my_spec.rb
#   rspec_check_for_flakiness_single_thread spec/my_spec.rb:8472
#   START=30 STEP=64 rspec_check_for_flakiness_single_thread spec/my_spec.rb spec/my_spec.rb:8472
function rspec_check_for_flakiness_single_thread() {
  local rspec_check_for_flakiness_single_thread_COMMAND
  local rspec_check_for_flakiness_single_thread_STEP
  local rspec_check_for_flakiness_single_thread_START
  local rspec_check_for_flakiness_single_thread_END
  local rspec_check_for_flakiness_single_thread_COUNTER
  rspec_check_for_flakiness_single_thread_STEP="$STEP"
  if [ -z "$rspec_check_for_flakiness_single_thread_STEP" ]; then
    rspec_check_for_flakiness_single_thread_STEP=64
  fi
  rspec_check_for_flakiness_single_thread_START="$START"
  if [ -z "$rspec_check_for_flakiness_single_thread_START" ]; then
    rspec_check_for_flakiness_single_thread_START=1
  fi
  rspec_check_for_flakiness_single_thread_COUNTER=1
  while [ "$rspec_check_for_flakiness_single_thread_COUNTER" -le 65535 ]
  do
    rspec_check_for_flakiness_single_thread_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
    rspec_check_for_flakiness_single_thread_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
    rspec_check_for_flakiness_single_thread_COMMAND+="SEED=\$(echo {} | cut -f 2 -d +) && "
    rspec_check_for_flakiness_single_thread_COMMAND+="FILE=\$(echo {} | cut -f 1 -d +) && "
    rspec_check_for_flakiness_single_thread_COMMAND+="silently bundle exec rspec --seed \$SEED -f p \$FILE"
    rspec_check_for_flakiness_single_thread_END=$(expr "$rspec_check_for_flakiness_single_thread_COUNTER" + "$rspec_check_for_flakiness_single_thread_STEP" )

    START="$rspec_check_for_flakiness_single_thread_COUNTER" END="$rspec_check_for_flakiness_single_thread_END" seed_permutations "$@" | \
      parallel -j 1 --halt now,fail=1 "$rspec_check_for_flakiness_single_thread_COMMAND" || return $?

    rspec_check_for_flakiness_single_thread_COUNTER+=$((rspec_check_for_flakiness_single_thread_STEP+1))
  done
  return $?
}
