function rspec_check_performance_improvements_for_all_files() {
  git_not_clean || return $?
  local rspec_check_performance_improvements_for_all_files_SPECS
  rspec_check_performance_improvements_for_all_files_SPECS=($(
    git status -sb | grep -E "^( M |M  |MM )" | grep "_spec\.rb$" | cut -b4-
  ))
  echo
  echo 'Before'
  git stash
  # shellcheck disable=SC2086,SC2128
  echorun bundle exec rspec -f p $rspec_check_performance_improvements_for_all_files_SPECS || return $?
  echo
  echo 'After'
  git stash pop
  # shellcheck disable=SC2086,SC2128
  echorun bundle exec rspec -f p $rspec_check_performance_improvements_for_all_files_SPECS || return $?
  echo
  echo
}
