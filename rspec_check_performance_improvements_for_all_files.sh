function rspec_check_performance_improvements_for_all_files() {
  local rspec_check_performance_improvements_for_all_files_SPECS
  rspec_check_performance_improvements_for_all_files_SPECS=($(
    git status -sb | grep -E "^( M |M  |MM )" | grep "_spec\.rb$" | cut -b4-
  ))
  echo
  echo 'Before'
  git stash
  echorun bundle exec rspec -f p $rspec_check_performance_improvements_for_all_files_SPECS || return $?
  echo
  echo 'After'
  git stash pop
  echorun bundle exec rspec -f p $rspec_check_performance_improvements_for_all_files_SPECS || return $?
  echo
  echo
}
