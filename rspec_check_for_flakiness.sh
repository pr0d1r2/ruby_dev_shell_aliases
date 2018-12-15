# Check for flakiness in RSpec example or spec file.
# It checks example or spec file with all possible random seeds in parallel.
#
# Example usage:
#   rspec_check_for_flakiness spec/my_spec.rb
#   rspec_check_for_flakiness spec/my_spec.rb:8472
#   START=30 STEP=64 rspec_check_for_flakiness spec/my_spec.rb spec/my_spec.rb:8472
function rspec_check_for_flakiness() {
  local rspec_check_for_flakiness_COMMAND
  local rspec_check_for_flakiness_STEP
  local rspec_check_for_flakiness_START
  local rspec_check_for_flakiness_END
  local rspec_check_for_flakiness_COUNTER
  rspec_check_for_flakiness_STEP="$STEP"
  if [ -z "$rspec_check_for_flakiness_STEP" ]; then
    rspec_check_for_flakiness_STEP=64
  fi
  rspec_check_for_flakiness_START="$START"
  if [ -z "$rspec_check_for_flakiness_START" ]; then
    rspec_check_for_flakiness_START=1
  fi
  rspec_check_for_flakiness_COUNTER=1
  while [ "$rspec_check_for_flakiness_COUNTER" -le 65535 ]
  do
    rspec_check_for_flakiness_COMMAND="source $HOME/projects/common_shell_aliases/silently.sh && "
    rspec_check_for_flakiness_COMMAND+="source $HOME/projects/osx_shell_aliases/md5sum.sh && " ##Darwin
    rspec_check_for_flakiness_COMMAND+="SEED=\$(echo {} | cut -f 2 -d +) && "
    rspec_check_for_flakiness_COMMAND+="FILE=\$(echo {} | cut -f 1 -d +) && "
    rspec_check_for_flakiness_COMMAND+="TEST_ENV_NUMBER={%} silently bundle exec rspec --seed \$SEED -f p \$FILE"
    rspec_check_for_flakiness_END=$(expr "$rspec_check_for_flakiness_COUNTER" + "$rspec_check_for_flakiness_STEP" )

    START="$rspec_check_for_flakiness_COUNTER" END="$rspec_check_for_flakiness_END" seed_permutations "$@" | \
      parallel --halt now,fail=1 "$rspec_check_for_flakiness_COMMAND" || return $?

    rspec_check_for_flakiness_COUNTER+=$((rspec_check_for_flakiness_STEP+1))
  done
  return $?
}
