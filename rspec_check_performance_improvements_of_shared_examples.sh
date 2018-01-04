function rspec_check_performance_improvements_of_shared_examples() {
  git_not_clean || return $?
  local rspec_check_performance_improvements_of_shared_examples_SPECS
  rspec_check_performance_improvements_of_shared_examples_SPECS=($(
    specs_using_changed_shared_examples
  ))
  echo
  echo 'Before'
  git stash
  # shellcheck disable=SC2086,SC2128
  echorun bundle exec rspec -f p $rspec_check_performance_improvements_of_shared_examples_SPECS || return $?
  echo
  echo 'After'
  git stash pop
  # shellcheck disable=SC2086,SC2128
  echorun bundle exec rspec -f p $rspec_check_performance_improvements_of_shared_examples_SPECS || return $?
  echo
  echo
}
