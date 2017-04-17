function rspec_check_performance_improvements() {
  local rspec_check_performance_improvements_SPECS=()
  local rspec_check_performance_improvements_SPEC
  for rspec_check_performance_improvements_SPEC in `git status -sb | grep "^ M " | grep "_spec\.rb$" | cut -b4-`
  do
    rspec_check_performance_improvements_SPECS+="$rspec_check_performance_improvements_SPEC"
  done
  for rspec_check_performance_improvements_SPEC in $rspec_check_performance_improvements_SPECS
  do
    echo
    echo
    echo "$rspec_check_performance_improvements_SPEC"
    echo
    echo "Before"
    echorun git stash || return $?
    echorun bin/rspec $rspec_check_performance_improvements_SPEC
    echo
    echo "After"
    echorun git stash pop || return $?
    echorun bin/rspec $rspec_check_performance_improvements_SPEC
    echo
    echo
  done
}
