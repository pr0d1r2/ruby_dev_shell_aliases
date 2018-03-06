function rspec_check_performance_improvements_in_parallel() {
  git_not_clean || return $?
  local rspec_check_performance_improvements_in_parallel_FILES
  rspec_check_performance_improvements_in_parallel_FILES+=($(
    git status -sb | grep -E "^( M |M  |MM )" | grep "_spec\.rb$" | cut -b4-
  ))

  echo
  echo
  echo "${rspec_check_performance_improvements_in_parallel_FILES[@]}"

  echo
  echo 'Before'
  echorun silently git stash || return $?
  echo 'beps'
  # shellcheck disable=SC2128,2086
  DISABLE_SPRING=1 bundle exec parallel_rspec $rspec_check_performance_improvements_in_parallel_FILES > rspec_check_performance_improvements_in_parallel.before 2>&1
  tail -n 3 rspec_check_performance_improvements_in_parallel.before

  echo
  echo 'After'
  echorun silently git stash pop || return $?
  echo 'beps'
  # shellcheck disable=SC2128,2086
  DISABLE_SPRING=1 bundle exec parallel_rspec $rspec_check_performance_improvements_in_parallel_FILES > rspec_check_performance_improvements_in_parallel.after 2>&1
  tail -n 3 rspec_check_performance_improvements_in_parallel.after
}
