function rspec_check_performance_improvements() {
  git status -sb | grep -E "^( M |M  |MM )" | grep "_spec\.rb$" | cut -b4- | \
    parallel \
      -j 1 \
      --halt now,fail=1 \
      "echo &&
       echo &&
       echo {} &&
       echo &&
       echo 'Before' &&
       git stash &&
       bin/rspec -f p {} &&
       echo &&
       echo 'After' &&
       git stash pop &&
       bin/rspec -f p {} &&
       echo &&
       echo"
  return $?
}
