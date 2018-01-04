function rspec_check_performance_improvements_of_shared_examples() {
  git_not_clean || return $?
  test -d most_used_shared_examples || echorun most_used_shared_examples_determine || return $?
  local rspec_check_performance_improvements_of_shared_examples_SPECS
  rspec_check_performance_improvements_of_shared_examples_SPECS=($(
    git status -sb | \
      grep -E "^( M |M  |MM )" | \
      grep "\.rb$" | \
      grep '/shared_examples/' | \
      cut -b4- | \
      parallel 'cat most_used_shared_examples/{}.list' | \
      sort -u
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
